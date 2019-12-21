import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ggms/screens/garbage.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

final formKey = GlobalKey<FormState>();
String email, password, rdata;

class LoginPageState extends State<LoginPage> {
  void uploadcred() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(email);
      print(password);
    }
    try {
      FormData formData =
          new FormData.from({"email": email, "password": password});
      print(formData.values);
      Response response =
          await Dio().post("http://172.22.120.154:3000/auth", data: formData);
      print(formData.values);
      print("File upload response: $response");
      rdata = response.data;
      print(response.data);
      if (rdata == 'USER') {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
            builder: (context) => GarbageScreen(),
          ),
        );
      }
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Login"),
        ),
        body: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email:'),
                    //validator: (value) =>
                    //    !value.contains('@') ? 'Not a valid Email' : null,
                    onSaved: (value) => email = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password:'),
                    //validator: (value) => value.length < 8
                    //   ? 'You need at least 8 characters'
                    //   : null,
                    onSaved: (value) => password = value,
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            uploadcred();
                            print(email);
                            print(password);
                          },
                          child: Text('Sign in'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(email);
      print(password);
    }
  }
}
