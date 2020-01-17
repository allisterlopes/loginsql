import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginsql/AdminPage.dart';
import 'package:loginsql/MemberPage.dart';

void main() => runApp(MyApp());

String username='';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
      routes: <String,WidgetBuilder>{
        '/AdminPage': (BuildContext context)=> new AdminPage(username: username,),
        '/MemberPage': (BuildContext context)=> new MemberPage(username: username,),
        '/MyHomePage': (BuildContext context)=> new MyHomePage(),

      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();


  String msg='';
  
  Future<List> _login() async {
    final response = await http.post("http://192.168.43.206/my_store/login.php", body: {
      "username": user.text,
      "password": pass.text,

    });
    print(response.body);
  var datauser = jsonDecode(response.body);

  if(datauser.length==0){
    setState(() {
      msg="Login Fail";
    });
  }else{
    if(datauser[0]['level']=='admin'){
      print("welcome admin");
      Navigator.pushReplacementNamed(context, '/AdminPage');
    }else if(datauser[0]['level']=='member'){
      Navigator.pushReplacementNamed(context, '/MemberPage');
      print("welcome member");
    }
    setState(() {
      username = datauser[0]['username'];
    });
  }

  return datauser;

  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Username" , style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: user,
                decoration: InputDecoration(
                  hintText: 'Username'
                ),
              ),
              Text("Password" , style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'password'
                ),
              ),
              RaisedButton(
                child: Text("Login"),
                  onPressed: (){
                  _login();
                  }
                  ),

              Text(msg,
                  style: TextStyle(fontSize: 20.0, color: Colors.red),)

            ],
          ),
        ),
      ),
    );
  }
}

