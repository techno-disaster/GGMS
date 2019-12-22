import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalScreen extends StatefulWidget {
  String a, b, c, d;
  FinalScreen({this.a, this.b, this.c, this.d});

  @override
  _FinalScreenState createState() => _FinalScreenState(a, b, c, d);
}

class _FinalScreenState extends State<FinalScreen> {
  String a, b, c, d;
  _FinalScreenState(this.a, this.b, this.c, this.d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Analytics",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Image.network(
              'http://172.22.120.154:3000/data?date=$a&time1=$b&time2=$c&type=$d'),
        ),
      ),
    );
  }
}
