import 'package:bustracker/services/MapsTest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Model/StationsInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  static final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("station");
  List<bool> ischeckedlist = List.generate(400, (index) => false);
  int index = 0;
  bool isChecked = false;
  TextEditingController stationnamecontroller = TextEditingController();
  TextEditingController stationlatitudecontroller = TextEditingController();
  TextEditingController stationlongitudecontroller = TextEditingController();
  TextEditingController busnumbercontroller = TextEditingController();

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
        return Drawer(backgroundColor: Colors.blue);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
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
    return SingleChildScrollView(
        child: Container(
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
        margin: EdgeInsets.only(top: 60, bottom: 30),
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
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
                controller: stationnamecontroller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    label: Text('enter the refernce of bus stop'),
                    border: OutlineInputBorder())),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
                controller: stationlatitudecontroller,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                    label: Text('enter the atitude'),
                    border: OutlineInputBorder())),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
                controller: stationlongitudecontroller,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                    label: Text('enter the Longittude'),
                    border: OutlineInputBorder())),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                // background color
                primary: Colors.orange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: const Center(
                    child: Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
              onPressed: () async {
                // String latitude = stationlatitudecontroller.text.toString();
                double latitude =
                    double.parse(stationlatitudecontroller.text.toString());
                double longitutde =
                    double.parse(stationlongitudecontroller.text.toString());

                // String longitutde = stationlongitudecontroller.text.toString();
                String name = stationnamecontroller.text.toString();
                print(name);
                print(latitude);
                if (!latitude.isNaN && !longitutde.isNaN && name.isNotEmpty) {
                  Map<String, dynamic> data = {
                    'name': stationnamecontroller.text.toString(),
                    'latitude': latitude,
                    "longitude": longitutde
                  };
                  await collectionRef
                      .doc()
                      .set(data)
                      .then((value) => print("data is stored"))
                      .catchError(
                          (onError) => print(" somthing wrang : $onError"));
                  stationnamecontroller.clear();
                  stationlatitudecontroller.clear();
                  stationlongitudecontroller.clear();
                } else {
                  setState(
                    () {
                      final snackBar = SnackBar(
                        content: const Text('somthing wrang!'),
                        action: SnackBarAction(
                          label: 'Go back ',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget addBus() {
    return SingleChildScrollView(
        child: Container(
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
                  label: const Text('Bus Number'),
                  border: OutlineInputBorder())),
        ),
        getDataFromFireToListBuilder(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            // background color
            primary: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            textStyle: const TextStyle(fontSize: 20),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            child: const Center(
                child: Text(
              'Submit',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
          ),
          onPressed: () {
            debugPrint('Button clicked!');
          },
        ),
      ]),
    );
  }

  Widget getDataFromFireToListBuilder() {
    Stream<QuerySnapshot<Map<String, dynamic>>> streamData =
        FirebaseFirestore.instance.collection('station').snapshots();
    return Container(
        height: 300,
        child: StreamBuilder<QuerySnapshot>(
            stream: streamData,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot st = snapshot.data.docs[index];
                  return Card(
                    child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            CheckboxListTile(
                                activeColor: Colors.pink[300],
                                dense: true,
                                //font change
                                title: new Text(
                                  "${st["name"]}",
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
                                    print(ischeckedlist.length);
                                  });
                                }),
                          ],
                        )),
                  );
                },
              );
            }));
  }
}
