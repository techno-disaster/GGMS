import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ggms/screens/admin/admin1.dart';
// import 'package:ggms/screens/garbage.dart';
import 'package:ggms/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

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
            builder: (context) => HomeScreen(),
          ),
        );
      } else if (rdata == 'ADMIN') {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
            builder: (context) => AdminPage(),
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
      backgroundColor: Colors.black,
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(17, 150, 17, 0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text(
                "Log In",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              color: Color.fromRGBO(30, 32, 35, 1),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password:'),
                        //validator: (value) => value.length < 8
                        //   ? 'You need at least 8 characters'
                        //   : null,
                        onSaved: (value) => password = value,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ButtonTheme(
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                              minWidth: 303,
                              buttonColor: Color.fromRGBO(64, 142, 239, 1),
                              child: RaisedButton(
                                onPressed: () {
                                  uploadcred();
                                  print(email);
                                  print(password);
                                },
                                child: Text('Sign in'),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
