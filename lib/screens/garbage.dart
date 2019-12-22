import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ggms/screens/camera.dart';
import 'package:google_fonts/google_fonts.dart';

List<CameraDescription> cameras;

class GarbageScreen extends StatefulWidget {
  @override
  _GarbageScreenState createState() => _GarbageScreenState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'tag1'),
      Company(2, 'tag2'),
      Company(3, 'tag3'),
      Company(4, 'tag4'),
      Company(5, 'tag5'),
    ];
  }
}

class Bin {
  int id;
  String name;

  Bin(this.id, this.name);

  static List<Bin> getBins() {
    return <Bin>[
      Bin(1, 'Full'),
      Bin(5, 'Normal'),
    ];
  }
}

List<Company> _companies = Company.getCompanies();
List<DropdownMenuItem<Company>> _dropdownMenuItems;
Company selectedCompany1;

List<int> _bins = [1, 5];
List<DropdownMenuItem<int>> _dropdownMenuBins;
int selectedBin1;

class _GarbageScreenState extends State<GarbageScreen> {
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    selectedCompany1 = _dropdownMenuItems[0].value;
    _dropdownMenuBins = buildDropdownMenuBinItems(_bins);
    selectedBin1 = _dropdownMenuBins[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<int>> buildDropdownMenuBinItems(List bins) {
    List<DropdownMenuItem<int>> binitems = List();
    for (int bin in bins) {
      binitems.add(
        DropdownMenuItem(
          value: bin,
          child: Text(bin == 1 ? 'abc' : 'bcd'),
        ),
      );
    }
    return binitems;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      selectedCompany1 = selectedCompany;
    });
  }

  onChangeDropdownBinItem(int selectedBin) {
    setState(() {
      selectedBin1 = selectedBin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/onboarding2.png', height: 250, width: 250,),
              SizedBox(height: 60,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  color: Color.fromRGBO(35, 37, 40, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Select a company",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DropdownButton(
                                  value: selectedCompany1,
                                  items: _dropdownMenuItems,
                                  onChanged: onChangeDropdownItem,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  'Selected: ${selectedCompany1.name}',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          child: Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Select a type of bin",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              DropdownButton(
                                value: selectedBin1,
                                items: _dropdownMenuBins,
                                onChanged: onChangeDropdownBinItem,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Selected: $selectedBin1',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: Container(
                  child: ButtonTheme(
                    height: 90,
                    minWidth: double.infinity,
                    buttonColor: Color.fromRGBO(35, 37, 40, 1),
                    child: RaisedButton(
                      elevation: 11.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Upload Image and \nupload submit",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                          ),
                          IconButton(
                            icon: Icon(Icons.linked_camera),
                            iconSize: 35,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TakePictureScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TakePictureScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
