import 'package:flutter/material.dart';
import "package:barcode_scan_example/official/FocusTestRoute.dart";
import 'package:barcode_scan_example/official/PackTestRoute.dart';
import 'package:barcode_scan_example/official/TabPage.dart';

void main() {
  runApp(MyApp());
}

//---------------------------- ParentWidget ----------------------------

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        active: _active,
      ),
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false}) : super(key: key);

  final bool active;

  _TapboxCState createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
      children: <Widget>[
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(color: Colors.lightGreen[700]),
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: new IconButton(
                      icon: Icon(Icons.add_alert),
                      iconSize: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new TabePage()),
                        );
                      })),
              Text(
                "拣货",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(color: Colors.teal[700]),
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: new IconButton(
                      icon: Icon(Icons.add_alert),
                      iconSize: 60,
                      onPressed: () {
                        Navigator.push<String>(context, new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return new FocusTestRoute();

                          /// 跳转到第三页，并且传递参数过去
                        })).then((String result) {
                          // 接收返回值的逻辑处理，通过一个 Dialog 展示出来
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  content: new Text("您输入的订单号为:$result"),
                                );
                              });
                        });
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new FocusTestRoute()),
                        );
                      })),
              Text("验货",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(color: Colors.redAccent[700]),
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: new IconButton(
                      icon: Icon(Icons.add_alert),
                      iconSize: 60,
                      onPressed: () {
                        Navigator.push<String>(context, new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return new PackTestRoute();

                          /// 跳转到第三页，并且传递参数过去
                        })).then((String result) {
                          // 接收返回值的逻辑处理，通过一个 Dialog 展示出来
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  content: new Text("您输入的订单号为:$result"),
                                );
                              });
                        });
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new PackTestRoute()),
                        );
                      })),
              Text("打包",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

//------------------------- MyApp ----------------------------------

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          buttonTheme: new ButtonThemeData(
              minWidth: 0,
              height: 0,
              padding: EdgeInsets.all(0),
              buttonColor: Colors.transparent)),
      title: 'Flutter Demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('pda拣货'),
        ),
        body: new Center(
          child: new ParentWidget(),
        ),
      ),
      routes: {
        "PackTestRoute": (BuildContext context) => new PackTestRoute(),
        "FocusTestRoute": (BuildContext context) => new FocusTestRoute(),
        "TabePage": (BuildContext context) => new TabePage(),
      },
    );
  }
}
