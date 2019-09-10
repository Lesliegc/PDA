import 'package:flutter/material.dart';
// import 'dart:convert';
import 'dart:async';
// import 'package:dio/dio.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class FocusTestRoute extends StatefulWidget {
  //  final String title;   // 储存传递过来的参数
  // FocusTestRoute({this.title});
  @override
  _FocusTestRouteState createState() => new _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  TextEditingController phoneEditingController = new TextEditingController();
  FocusNode focusNode2 = new FocusNode();
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("验货"),
        centerTitle: true,
      ),
      body: Container(
          child: Card(
              child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            new Container(
              child:
                  new MaterialButton(onPressed: scan, child: new Text("Scan")),
              padding: const EdgeInsets.all(8.0),
            ),
            new Text(barcode),
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

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      print(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
