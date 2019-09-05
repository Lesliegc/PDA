import 'package:flutter/material.dart';
import 'package:pda_pick_app/example/page/checkout_order.dart';
class Modular extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
      ),
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            children: <Widget>[
              Expanded(child: new IconButton(icon: Icon(Icons.add_alert),iconSize: 50, onPressed: (){
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new SearchBox()),
                );
              })),
              Text("拣货",style: TextStyle(fontSize: 13,color: Color(0xFF333333),))
              
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            children: <Widget>[
              Expanded(child: new IconButton(icon: Icon(Icons.add_alert),iconSize: 50, onPressed: (){

              })),
              Text("复验",style: TextStyle(fontSize: 13,color: Color(0xFF333333),))

            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            children: <Widget>[
              Expanded(child: new IconButton(icon: Icon(Icons.add_alert),iconSize: 50, onPressed: (){

              })),
              Text("拣货",style: TextStyle(fontSize: 13,color: Color(0xFF333333),))

            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          child: Column(
            children: <Widget>[
              Expanded(child: new IconButton(icon: Icon(Icons.add_alert),iconSize: 50, onPressed: (){

              })),
              Text("拣货",style: TextStyle(fontSize: 13,color: Color(0xFF333333),))

            ],
          ),
        )
      ],
    );
  }
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: Text("PDA拣货APP",style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        )),
      ),
      body: new Container(
        child: Modular(),
      ),
    ),
   );
  }
}


void main() {
  runApp(MyApp());
}