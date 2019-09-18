import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';

class OrderTest extends StatelessWidget {
  final id;
  const OrderTest({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("拣货作业"),
        actions: <Widget>[
          IconButton(
            icon: Text("完成"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        centerTitle: true,
      ),
      body: OrderPage(id:this.id),
    );
  }
}

class OrderPage extends StatefulWidget {
  final id;
  const OrderPage({Key key, this.id}) : super(key: key);
 
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    this.getOrder();
  }

    var orderList = [];

  Future getOrder() async {
    try {
      Dio dio = new Dio();
      final String _url =
          'http://172.17.10.235:8080/order-center/ui/PDA/startJianHuo.action';
      Response response;
             var data = {
      "loginid":"shgbpdatest",
      "shopid":113,
      "tasks":widget.id,
      };
      response = await dio.post(_url, queryParameters: data);

      var orticleMap = json.decode(response.toString())['data'][0]['shelfgoodslist'];
      print(orticleMap);
      setState(() {
        orderList = orticleMap;
      });
    } catch (e) {
      print(e);
    }
  }

    @override
  Widget build(BuildContext context) {
      print('进来');
      return new ListView.builder(
          itemCount: orderList == null ? 0 : orderList.length,
          itemBuilder: (BuildContext context, int index) {
            var mitem = orderList[index];
              return new Card(
                child: new Container(
                  padding: new EdgeInsets.all(10.0),
                  child: new ListTile(
                    subtitle: new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("#" + (index + 1).toString() + "品名:"),
                              new Expanded(
                                  child: new Container(
                                child: new Text("${mitem["productname"]}"+"(${mitem["skuname"]})",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0)),
                              ))
                            ],
                          ),
                          new Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: new Text('${mitem["barcodeid"]}',
                                    style: TextStyle(
                                      color: Color(0xFF121917),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: new Text("规格:"+'${mitem["pkspec"]}'
                                  )),
                            ],
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Text("需拣:"+'${mitem['amount']}'),
                                ],
                              ),
                            ],
                          ),
                          // _generateItem(arr[j]["oid"]),
                        ],
                      ),
                    ),
//              trailing: new Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
//              onTap: () => _onTap(mlist[index]["id"].toString()),
                  ),
                ),
              );
            
            
          });
    
  }
}