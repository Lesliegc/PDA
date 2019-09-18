import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:barcode_scan_example/utils/httputil.dart';
import 'package:barcode_scan_example/common/api.dart';
import 'package:barcode_scan_example/utils/goodlist.dart';
import 'package:barcode_scan_example/View/Order.dart';

class TabePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拣货作业"),
        actions: <Widget>[
          IconButton(
            icon: Text("拣货"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderTest(id: "99161025395685")));
            },
          )
        ],
        centerTitle: true,
      ),
      body: SnackBarPage(),
    );
  }
}

class SnackBarPage extends StatefulWidget {
  @override
  _SnackBarPageState createState() => _SnackBarPageState();
}

class _SnackBarPageState extends State<SnackBarPage> {
  bool sort;
  List<ProjectData> _datas = new List(); //一级分类集合
  List<ProjectData> selectedUsers;
  
  @override
  void initState() {
    getData();
    sort = false;
    selectedUsers = [];
    super.initState();
  }

  onSelectedRow(bool selected, item) async {
    setState(() {
      if (selected) {
        selectedUsers.add(item);
        selectedUsers.map((v) =>
        print(v.taskid)
        ).toList();
        
      } else {
      selectedUsers.remove(item);
      }
    });
  }



  Future getData() async {
    try{
      var data = {"loginid": "shgbpdatest", "shopid": 114};

      var response = await HttpUtil().post(Api.Task, data: data);

      Map taskMap = json.decode(response.toString());
      var projectEntity = new ProjectEntity.fromJson(taskMap);
      setState(() {
        if(_datas.length != null)_datas=projectEntity.data;
      });
    } catch (e) {
      print(e);
    }

  
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            sortAscending: sort,
            sortColumnIndex: 0,
            columns: [
              DataColumn(label: Text("订单号码"), numeric: false, tooltip: "订单号码"),
              DataColumn(
                label: Text("品 项"),
                numeric: false,
                tooltip: "品项",
              ),
              DataColumn(
                label: Text("数 量"),
                numeric: false,
                tooltip: "数量",
              ),
            ],
            rows: _datas.map((item) {
              return DataRow(
                  selected: selectedUsers.contains(item),
                    onSelectChanged: (bool selected) {
                   onSelectedRow(selected, item);
            },
                  cells: [
                    DataCell(
                      Text(item.taskid.toString(),
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(item.items.toString(),
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                    ),
                    DataCell(
                      Text(item.amount.toString()),
                    ),
                  ]);
            }).toList(),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: dataBody(),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.amberAccent,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: OutlineButton(
                child: Text('共有${_datas.length}个拣货任务'),
                onPressed: null,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: OutlineButton(
                child: Text('刷 新'),
                onPressed: () {
                  getData();
                },
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
