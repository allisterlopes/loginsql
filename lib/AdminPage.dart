import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {

  AdminPage({this.username});
  final String username;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("welcome admin"),),
      body: Column(
        children: <Widget>[
          Text('Hello $username', style: TextStyle(fontSize: 20.0),),
          RaisedButton(
           child: Text("LogOut"),
           onPressed: (){
             Navigator.pushReplacementNamed(context, '/MyHomePage');
           }, 
          )
        ],
      ),
    );
  }
}
