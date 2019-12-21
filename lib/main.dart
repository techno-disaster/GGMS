import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:ggms/screens/home.dart';

List<CameraDescription> cameras;
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        cameras,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
