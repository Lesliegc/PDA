import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:barcode_scan_example/utils/goodlist.dart';

class TabePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拣货作业"),
        actions: <Widget>[
          IconButton(
            icon: Text("拣货"),
            
            onPressed: (){
              print('search');
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
  List<Shop> selectedShops;
  bool sort;

  @override
  void initState() {
    this.getData();
    sort = false;
    selectedShops = [];
    super.initState();
  }

  var mlist = [];
  //选中单个
  void selectRow(int index, bool isSelected) {
    mlist = mlist[index];
  }

  Future getData() async {
    try {
      Dio dio = new Dio();
      final String _url =
          'http://172.17.8.193:8080/order-center/ui/PDA/getMyJianHuoTask.action?loginid=shgbpdatest&shopid=114';
      Response response;
      response = await dio.post(_url);

      var articleMap = json.decode(response.toString())['data'];

      setState(() {
        mlist = articleMap;
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
            rows: mlist.map((item) {
              return DataRow(
                  selected: mlist.contains(item),
                  onSelectChanged: (b) {
                    print("Onselect");
                    // onSelectedRow(b, item);
                  },
                  cells: [
                    DataCell(
                      Text(item['taskid'].toString(),
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(item['items'].toString(),
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                    ),
                    DataCell(
                      Text(item['amount'].toString()),
                    ),
                  ]);
            }).toList(),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    print('进来');
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        Expanded(
          flex: 4,
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
                child: Text('共有${mlist.length}个拣货任务，已选中2个拣货任务'),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: OutlineButton(
                child: Text('刷 新'),
                onPressed:() {
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
