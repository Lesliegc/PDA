import 'package:flutter/material.dart';
import 'package:pda_pick_app/official/PackTestRoute.dart';
import 'package:pda_pick_app/official/FocusTestRoute.dart';
import 'package:pda_pick_app/official/TabPage.dart';

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
    return new Container(
      padding: const EdgeInsets.all(160.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              children: [
                new GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "TabePage");
                  },
                  child: new Container(
                       margin: const EdgeInsets.only(bottom: 20.0),
                    child: Center(
                      child: Text('拣货',
                          style:
                              TextStyle(fontSize: 26.0, color: Colors.white)),
                    ),
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(color: Colors.lightGreen[700]),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                                      Navigator.push<String>(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new FocusTestRoute();   /// 跳转到第三页，并且传递参数过去
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
                    Navigator.pushNamed(context, "FocusTestRoute");
                  },
                  child: new Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Center(
                      child: Text('复验',
                          style:
                              TextStyle(fontSize: 26.0, color: Colors.white)),
                    ),
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(color: Colors.teal[700]),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                                      Navigator.push<String>(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new PackTestRoute();   /// 跳转到第三页，并且传递参数过去
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
                    Navigator.pushNamed(context, "FocusTestRoute");
                  },

                  child: new Container(
                    child: Center(
                      child: Text('打包',
                          style:
                              TextStyle(fontSize: 26.0, color: Colors.white)),
                    ),
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(color: Colors.redAccent[700]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
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
        "PackTestRoute": (BuildContext context) => new PackTestRoute (),
        "FocusTestRoute": (BuildContext context) => new FocusTestRoute(),
        "TabePage": (BuildContext context) => new TabePage(),
      },
    );
  }
}
