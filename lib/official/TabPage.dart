import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:pda_pick_app/demo01/views/detail.dart';

class TabePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拣货"),
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
  bool _value = false;
  bool _value1 = false;
  bool _value2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        CheckboxListTile(
          secondary: const Icon(Icons.shutter_speed),
          value: _value,
          title: Text('升压'),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        CheckboxListTile(
          secondary: const Icon(Icons.shutter_speed),
          value: _value1,
          title: Text('升降压'),
          onChanged: (value) {
            setState(() {
              _value1 = value;
            });
          },
        ),
        CheckboxListTile(
          secondary: const Icon(Icons.shutter_speed),
          value: _value2,
          title: Text('降压'),
          onChanged: (value) {
            setState(() {
              _value2 = value;
            });
          },
        ),
        RaisedButton(
          onPressed: () {
            final snackBar = SnackBar(
              content: Text('升压$_value,升降压$_value1,降压$_value2'),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          },
          child: Text('确定'),
        ),
      ],
    ));
  }
}
