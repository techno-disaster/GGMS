import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ggms/screens/final.dart';
import 'package:path/path.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
      print('Date Selected: ${date.day.toString()}');
      setState(() {
        date = picked;
      });
    }
  }

  Response response = new Response();
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

  String a, b, c, d;
  String type;
  String _date = "Not set";
  String _time = "Not set";
  String finaltime1;
  String finaltime2;
  String finaldate;
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
        padding: EdgeInsets.all(20),
        child: new Column(
          children: <Widget>[
            Image.asset(
              'assets/images/onboarding1.png',
              height: 200,
              width: 250,
            ),
            SizedBox(
              height: 80,
            ),
            TextField(
              onChanged: (text) {
                print(text);
                type = text;
              },
            ),
            SizedBox(height: 50),
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
                            DatePicker.showDatePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 310.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime(2000, 1, 1),
                                maxTime: DateTime(2022, 12, 31),
                                onConfirm: (date) {
                              _date =
                                  '${date.year} - ${date.month} - ${date.day}';
                              setState(() {});
                              finaldate = '${date.day}';
                              print(finaldate);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
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
                SizedBox(width: 10),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: IconButton(
                          onPressed: () {
                            DatePicker.showTimePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 310.0,
                                ),
                                showTitleActions: true, onConfirm: (time) {
                              print('confirm $time');
                              _time =
                                  '${time.hour} : ${time.minute} : ${time.second}';
                              setState(() {});
                              finaltime1 = '${time.hour} : ${time.minute}';
                              print(finaltime1);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                            setState(() {});
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
                ),
                SizedBox(width: 10),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: IconButton(
                          onPressed: () {
                            DatePicker.showTimePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 310.0,
                                ),
                                showTitleActions: true, onConfirm: (time) {
                              print('confirm $time');
                              _time =
                                  '${time.hour} : ${time.minute} : ${time.second}';
                              setState(() {});
                              finaltime2 = '${time.hour} : ${time.minute}';
                              print(finaltime2);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                            setState(() {});
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
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              color: Color.fromRGBO(35, 37, 40, 1),
              child: ButtonTheme(
                height: 80,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                child: MaterialButton(
                  child: Text(
                    "Enter Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    a = finaldate.toString();
                    b = finaltime1.toString();
                    c = finaltime2.toString();
                    d = type.toString();
                    print(a);
                    print(b);
                    print(c);
                    print(d);
                  },
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
