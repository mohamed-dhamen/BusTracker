import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController controller;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specify1, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify, specify1),
      //infoWindow: InfoWindow(title: 'Shop', snippet: specify['address']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    FirebaseFirestore.instance.collection("station").get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          print(docs.docs[i]['latitude']);
          print(docs.docs[i]['longitude']);
          initMarker(docs.docs[i]['latitude'], docs.docs[i]['longitude'],
              docs.docs[i].id);
        }
      }
    });
  }

  @override
  void initState() {
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> getMarker() {
      return <Marker>[
        Marker(
            markerId: MarkerId('courent location'),
            position: LatLng(33.573050, -7.597099),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Location'))
      ].toSet();
    }

    return Scaffold(
        body: GoogleMap(
            markers: getMarker(),
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(33.573050, -7.597099), zoom: 12.0),
            onMapCreated: (GoogleMapController controller) {
              controller = controller;
            }));
  }
}
