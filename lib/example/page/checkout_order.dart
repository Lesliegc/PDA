import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pda_pick_app/common/toast.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:pda_pick_app/example/scanner/FlutterBarcodeScanner.dart';

class BarcodeScane{
  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver("#ff6666", "Cancel", true)
        .listen((barcode) => print(barcode));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes =
      await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

  }

}


class HttpUtils{
  static void pick_order(String channel_sheet_no,BuildContext context){
    // 拣货代码
    if(true){
      // 拣货成功，将对话框关闭
      Navigator.of(context).pop();
      // 新建一个对话框显示拣货成功然后消失
      Toast.toast(context,msg: "$channel_sheet_no 订单拣货成功");

    }else{
      Toast.toast(context,msg: "$channel_sheet_no 订单拣货失败");
    }
  }

  static void post(url,_context) async{

    Map<String,dynamic>  param ={
      "channel_sheetno":"59816192043228914",
    };
    try{
      final http.Response response = await http.post(
          url,
          body: json.encode(param),
          encoding: Utf8Codec());

      final Map<String, dynamic> responseData = json.decode(response.body);
      print('$responseData 数据');
      var order = responseData['data']['order'];

      if(order.length==0){
        showDialog(
            context:_context,
            builder: (_context)=>AlertDialog(
              title: Text("该订单不存在"),
            ));
      }else{
        // 做一个弹框，展示数据
        // 先解析数据
        var order_info = order[0];
        String name = order_info['buyer']['nick'];
        String orderNumber = order_info['channel_sheetno'];
        String createtime = order_info['order_time'];
        String status = order_info['order_status'];
        double pay = order_info['payment'];
        String shopid = order_info['org_name'];
        String channel = order_info['channel_name'];
        showDialog(
            context: _context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return new AlertDialog(
                title: Text("订单详情",style: TextStyle(color: Colors.cyan,fontSize: 20)),
                content: new SingleChildScrollView(
                  child: new ListBody(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Text("姓名:",textAlign: TextAlign.left),
                          new Text(name,style: TextStyle(color: Colors.black),textAlign: TextAlign.right)
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Text("订单状态:",textAlign: TextAlign.left),
                          new Text(status,style: TextStyle(color: Colors.black),textAlign: TextAlign.right)
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Text("订单编号:",textAlign: TextAlign.left),
                          new Text(orderNumber,style: TextStyle(color: Colors.black),textAlign: TextAlign.right)
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Text("订单金额:",textAlign: TextAlign.left),
                          new Text(pay.toString(),style: TextStyle(color: Colors.black),textAlign: TextAlign.right)
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Text("门店名称:",textAlign: TextAlign.left),
                          new Text("西城杨红店",style: TextStyle(color: Colors.black),textAlign: TextAlign.right)
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Text("渠道:",textAlign: TextAlign.left),
                          new Text(channel,style: TextStyle(color: Colors.black),textAlign: TextAlign.right)
                        ],

                      ),
                      new Row(
                        children: <Widget>[
                          new Text("下单时间:",textAlign: TextAlign.left),
                          new Text(createtime,style: TextStyle(color: Colors.black),textAlign: TextAlign.right)
                        ],

                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  new Row(
                    children: <Widget>[
                      new FlatButton(onPressed: (){
//                        Navigator.of(context).pop();
                      pick_order(orderNumber, context);

                      }, child: new Text("确定拣货")),
                      new FlatButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: new Text("取消拣货"))
                    ],
                  )
                ],
              );

            }
        );

      }
    }catch(error){
      print("出现错误");
    }
  }
}


// 拣货页面
class SearchBox extends StatelessWidget{
  // 定义订单框点击控制器
  //手机号的控制器
  TextEditingController orderNumber = TextEditingController();
  BuildContext _context = null;
   void search(){
    // 定义点击事件方法
   var ordernumber = orderNumber.text;
   if(ordernumber==null || ordernumber == ""){
     showDialog(
         context:_context,
         builder: (_context)=>AlertDialog(
           title: Text("订单编号不可以为空"),
         ));
   }else{
     dynamic params = {};

     var url = "https://wm.cloud360.com.cn/amp-openapi-service/rest?method=service.order.query&token=1643729567756566927";
     HttpUtils.post(url,_context);
   }
  }


  @override
  Widget build(BuildContext context) {
    _context = context;
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("查找订单"),
      ),
      body: new Column(
        children: <Widget>[
          new TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller:orderNumber,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10.0),
                hintText: '请输入订单号)',
                prefixIcon: Icon(Icons.title),
                suffixIcon: IconButton(icon: Icon(Icons.scanner), onPressed:(){
                  BarcodeScane scanner = new BarcodeScane();
                  scanner.startBarcodeScanStream();

                })

            ),

          ),
          new RaisedButton(
            onPressed:search,
            child: new Text("查找"),color: Colors.red,textColor: Colors.black,splashColor: Colors.black,highlightColor: Colors.green)
        ],
      ),
    );
  }

}