import 'package:bustracker/services/MapsTest.dart';
import 'package:bustracker/services/MyMaps.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Model/StationsInfo.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  // ignore: deprecated_member_use
  List<StationInfoModel> stations = StationInfoModel.getStations();
  List<bool> ischeckedlist = [];
  int index = 0;
  bool isChecked = false;

  Widget bodyFunction() {
    switch (index) {
      case 0:
        return MapsPage();
        break;
      case 1:
        return addStation();
        break;
      case 2:
        return addBus();
        break;
      default:
        return Container(color: Colors.white);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
        child: FloatingActionButton(
          splashColor: Colors.white,
          backgroundColor: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.send),
              SizedBox(
                width: 10,
              ),
              Text(
                "Submit",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ), //child widget inside this button
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onPressed: () {
            print("Button is pressed.");
            //task to execute when this button is pressed
          },
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.blue,
        elevation: 20,
        curveSize: 80,
        items: [
          TabItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Image.asset(
                  "images/bus-stop5.png",
                ),
              ),
              title: 'Stations'),
          TabItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Image.asset("images/bus-stop 4.png"),
              ),
              title: 'Add station'),
          TabItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Image.asset("images/bus1.png"),
              ),
              title: 'add bus'),
          const TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        onTap: (val) {
          setState(() {
            index = val;
          });
        },
      ),
      body: bodyFunction(),
    );
  }

  Widget addStation() {
    // function get form station innfo
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Station Informations'),
            )
          ];
        },
        body: Container(
          child: Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Column(
                children: <Widget>[
                  getWidgetImageStationLogo(),
                  getWidgetStationForm(),
                ],
              )),
        ));
  }

  Widget getWidgetImageStationLogo() {
    return Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset("images/bus-station.png"),
        ));
  }

  Widget getWidgetStationForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    label: Text('enter the refernce of bus stop'),
                    border: OutlineInputBorder())),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                    label: Text('enter the atitude'),
                    border: OutlineInputBorder())),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                    label: Text('enter the Longittude'),
                    border: OutlineInputBorder())),
          ),
        ],
      ),
    );
  }

  Widget addBus() {
    setState(() {
      for (int i = 0; i < stations.length; i++) {
        ischeckedlist.add(false);
      }
      for (int i = 0; i < ischeckedlist.length - 1; i++) {
        print(ischeckedlist[i]);
      }
    });
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Station Informations'),
            )
          ];
        },
        body: Container(
          child: Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Column(
                children: <Widget>[
                  getWidgetImageBusLogo(),
                  getWidgetBusForm(),
                ],
              )),
        ));
  }

  Widget getWidgetImageBusLogo() {
    return Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset("images/bus1.png"),
        ));
  }

  Widget getWidgetBusForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: TextField(
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              decoration: InputDecoration(
                  label: Text('Bus Number'), border: OutlineInputBorder())),
        ),
        Container(
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: stations.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  child: new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          new CheckboxListTile(
                              activeColor: Colors.pink[300],
                              dense: true,
                              //font change
                              title: new Text(
                                "${stations[index].stationName}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                              value: ischeckedlist[index],
                              secondary: Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  "images/bus-stop 4.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  ischeckedlist[index] = val as bool;
                                });
                              }),
                        ],
                      )),
                );
              }),
        ),
      ]),
    );
  }
}
