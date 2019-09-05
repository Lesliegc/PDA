import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pda_pick_app/utils/goodlist.dart'
    show Detail, GoodList, GoodListBean;

class Picking extends StatefulWidget {
  List<Detail> arrDetail;
  final String pickOid;
  Picking(@required this.pickOid, {oid});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Picking> {
  var _tabView = <Widget>[];
  String barcode = "";
  Dio dio = new Dio();
  var conlist = [];
  final String _allurl =
      'https://wm.cloud360.com.cn/picking-order-service/api/v1.0/order/all/query?ent_id=0';

  Future getOrder() async {
    try {
      Response response;

      response = await dio.post(_allurl, data: {"oid": widget.pickOid});
      var orderDetail = json.decode(response.toString())['data']['detail'];
      print(orderDetail);
      //  var articleEntity = new ArticleEntity.fromJson(articleMap);

      setState(() {
        conlist = orderDetail;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // for (int i = 0; i < widget.arrDetail.length; i++) {

    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getOrder();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pickOid,
          style: TextStyle(color: Colors.greenAccent),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            //1.8是banner宽高比，0.8是viewportFraction的值
            height: MediaQuery.of(context).size.width / 1.8 * 0.8,
            // child: Swiper(
            //   loop: false,
            //   autoplay: false,
            //   autoplayDelay: 3000,
            //   //触发时是否停止播放
            //   autoplayDisableOnInteraction: true,
            //   duration: 600,
            //   //默认分页按钮
            //   //视图宽度，即显示的item的宽度屏占比
            //   viewportFraction: 0.8,
            //   //两侧item的缩放比
            //   scale: 0.9,

            //   onTap: (int index) {
            //     //点击事件，返回下标
            //     print("index-----" + index.toString());
            //   },
            // ),
          ),
          Flexible(
            child: new ListView.builder(
                shrinkWrap: true,
                itemCount: conlist.length,
                itemBuilder: (BuildContext context, int position) {
                  return getRow(position);
                }),
          )
        ],
      ),
    );
  }

  Widget getRow(int i) {
    return new GestureDetector(
        child: new Container(
      padding: new EdgeInsets.all(10.0),
      child: new ListTile(
        subtitle: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "品名:",
                        style:
                            TextStyle(color: Color(0xFF121917), fontSize: 14.0),
                      ),
                      new Text(
                        conlist[i]["item_name"],
                        style: TextStyle(
                          color: Color(0xFF121917),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "条码:",
                        style:
                            TextStyle(color: Color(0xFF121917), fontSize: 14.0),
                      ),
                      new Text(
                        conlist[i]["barcode"],
                        style: TextStyle(
                          color: Color(0xFF121917),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "货位信息:",
                        style:
                            TextStyle(color: Color(0xFF121917), fontSize: 14.0),
                      ),
                      new Text(
                        conlist[i]["cargo_info"] ?? "0",
                        style: TextStyle(
                          color: Color(0xFF121917),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "未拣:",
                        style:
                            TextStyle(color: Color(0xFF121917), fontSize: 14.0),
                      ),
                      new Text(
                        conlist[i]["unsort_qty"].toString(),
                        style: TextStyle(
                          color: Color(0xFF121917),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "已拣:",
                        style:
                            TextStyle(color: Color(0xFF121917), fontSize: 14.0),
                      ),
                      new Text(
                        conlist[i]["sorted_qty"].toString(),
                        style: TextStyle(
                          color: Color(0xFF121917),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

}
