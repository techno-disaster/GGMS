import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:ggms/screens/home.dart';
// import 'package:ggms/screens/login.dart';
import 'package:flutter/services.dart';
// import 'package:ggms/screens/admin/admin1.dart';
// import 'package:ggms/screens/home.dart';
import 'package:ggms/screens/onboarding.dart';

List<CameraDescription> cameras;
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:OnboardingScreen(),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
