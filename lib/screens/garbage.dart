import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ggms/screens/camera.dart';

List<CameraDescription> cameras;

class GarbageScreen extends StatefulWidget {
  var cameras;
  GarbageScreen(this.cameras);
  @override
  _GarbageScreenState createState() => _GarbageScreenState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Apple'),
      Company(2, 'Google'),
      Company(3, 'Samsung'),
      Company(4, 'Sony'),
      Company(5, 'LG'),
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
      Bin(2, 'Normal'),
    ];
  }
}

List<Company> _companies = Company.getCompanies();
List<DropdownMenuItem<Company>> _dropdownMenuItems;
Company _selectedCompany;

List<Bin> _bins = Bin.getBins();
List<DropdownMenuItem<Bin>> _dropdownMenuBins;
Bin _selectedBin;

class _GarbageScreenState extends State<GarbageScreen> {
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    _dropdownMenuBins = buildDropdownMenuBinItems(_bins);
    _selectedBin = _dropdownMenuBins[0].value;
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

  List<DropdownMenuItem<Bin>> buildDropdownMenuBinItems(List bins) {
    List<DropdownMenuItem<Bin>> binitems = List();
    for (Bin bin in bins) {
      binitems.add(
        DropdownMenuItem(
          value: bin,
          child: Text(bin.name),
        ),
      );
    }
    return binitems;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  onChangeDropdownBinItem(Bin selectedBin) {
    setState(() {
      _selectedBin = selectedBin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Container(
              child: ButtonTheme(
                height: 70,
                minWidth: double.infinity,
                buttonColor: Colors.white,
                child: RaisedButton(
                  elevation:11.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Upload Image",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 150,
                      ),
                      IconButton(
                        icon: Icon(Icons.linked_camera),
                        iconSize: 35,
                        color: Colors.red,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TakePictureScreen(widget.cameras),
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
                        builder: (context) => TakePictureScreen(widget.cameras),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Select a company"),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButton(
                    value: _selectedCompany,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Selected: ${_selectedCompany.name}'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Select a type of bin"),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButton(
                    value: _selectedBin,
                    items: _dropdownMenuBins,
                    onChanged: onChangeDropdownBinItem,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Selected: ${_selectedBin.name}'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                    child: Container(
                      child: ButtonTheme(
                        height: 70,
                        minWidth: double.infinity,
                        buttonColor: Colors.white,
                        child: RaisedButton(
                          elevation: 11.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Submit Grievance",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
