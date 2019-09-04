import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:async';
// import 'package:dio/dio.dart';

class PackTestRoute extends StatefulWidget {
  //    final String title;   // 储存传递过来的参数
  // PackTestRoute({this.title});

  @override
  _PackTestRouteState createState() => new _PackTestRouteState();
}

class _PackTestRouteState extends State<PackTestRoute> {
  TextEditingController phoneEditingController = new TextEditingController();
  FocusNode focusNode2 = new FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("打包"),
        centerTitle: true,
      ),
      body: Container(
          child: Card(
              child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: phoneEditingController,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "请输入订单号搜索",
              ),
              // autofocus: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      child: Text("搜索"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        // 点击确认按钮

                        if (phoneEditingController.text == '') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  new AlertDialog(title: new Text("请输入订单号")));
                          return;
                        }

                        // 将输入的内容返回
                        Navigator.pop(context, phoneEditingController.text);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ))),
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
    );
  }
}
