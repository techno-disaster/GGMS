import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // var queryParameters = {
  //   'param1': 'one',
  //   'param2': 'two',
  // };
  // var uri =
  //     Uri.https('www.myurl.com', '/search', queryParameters);
  // var response = await http.get(uri, headers: {
  //   HttpHeaders.authorizationHeader: 'Token $token',
  //   HttpHeaders.contentTypeHeader: 'application/json',
  // });
  DateTime date = new DateTime.now();
  TimeOfDay time = new TimeOfDay.now();
  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      initialDate: date,
      firstDate: new DateTime(2019, 11, 1),
      lastDate: new DateTime.now(),
      context: context,
    );
    if (picked != null && picked != date) {
      print('Date Selected: ${date.toString()}');
      setState(() {
        date = picked;
      });
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: time);
    if (picked != null && picked != time) {
      print('Date Selected: ${time.toString()}');
      setState(() {
        time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Admin Console"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: new Column(
          children: <Widget>[
            Image.asset(
              'assets/images/onboarding1.png',
              height: 250,
              width: 250,
            ),
            SizedBox(
              height: 100,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: IconButton(
                          onPressed: () {
                            selectDate(context);
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            size: 45,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text("Choose Date")
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(35, 37, 40, 1),
                    borderRadius: new BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  // color: Color.fromRGBO(35, 37, 40, 1),
                  height: 100,
                  width: 100,
                ),
                SizedBox(width: 50),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: IconButton(
                          onPressed: () {
                            selectTime(context);
                          },
                          icon: Icon(
                            Icons.timer,
                            size: 45,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text("Choose Time")
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(35, 37, 40, 1),
                    borderRadius: new BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  height: 100,
                  width: 100,
                )
              ],
            ),

            // new Text(
            //   ('Date Selected: ${date.toString()}'),
            // ),
            // new RaisedButton(
            //   onPressed: () {
            //     selectDate(context);
            //   },
            //   child: Text("Select Date"),
            // ),
            // new Text('   '),
            // new Text(
            //   ('Time Selected: ${time.toString()}'),
            // ),
            // new RaisedButton(
            //   onPressed: () {
            //     selectTime(context);
            //     print(
            //       time.toString(),
            //     );
            //   },
            //   child: Text("Select Time"),
            // ),
            // new Text('   ')
          ],
        ),
      ),
    );
  }
}
