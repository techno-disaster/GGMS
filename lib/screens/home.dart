import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:ggms/screens/camera.dart';
import 'package:ggms/screens/garbage.dart';
import 'package:google_fonts/google_fonts.dart';

List<CameraDescription> cameras;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "GGMS",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            GarbageScreen(),
            TakePictureScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Submit'),
            icon: Icon(Icons.apps),
            activeColor: Colors.amber,
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            title: Text('Camera'),
            icon: Icon(Icons.photo_camera),
            activeColor: Colors.amber,
            inactiveColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
