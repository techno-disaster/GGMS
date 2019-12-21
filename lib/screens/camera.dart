import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ggms/screens/garbage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
double lat;
double long;
  Future getImage() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    lat = position.latitude;
    long = position.longitude;
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _uploadFile(image);

    setState(() {
      _image = image;
    });
  }

  // Methode for file upload
  void _uploadFile(filePath) async {
    // Get base file name
    String fileName = basename(filePath.path);
    print("File base name: $fileName");

    try {
      FormData formData = new FormData.from({
        "date": DateTime.now(),
        "time": "01:02",
        "longitude": long,
        "latitude": lat,
        "dsc": selectedCompany1.name,
        "weight": selectedBin1,
        "img1": new UploadFileInfo(filePath, fileName)
      });

      Response response =
          await Dio().post("http://172.22.120.154:3000/grievance", data: formData);
      print("File upload response: $response");

      // Show the incoming message in snakbar
      _showSnakBarMsg(response.data['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  // Method for showing snak bar message
  void _showSnakBarMsg(String msg) {
    _scaffoldstate.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("GFSS"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
