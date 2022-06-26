import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late BitmapDescriptor myIcon;
  late GoogleMapController controller;

  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("station");

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specify1, specifyId) async{
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
    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        Map<String, dynamic> data = result.data()! as Map<String, dynamic>;
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        print(result.data());

        initMarker(data["latitude"], data["longitude"], data["name"]);
      }
    });

    print(markers);
  }

  @override
  void initState() {
    super.initState();
  }

  // Set<Marker> getMarker() {
  //     return <Marker>[
  //       Marker(
  //           markerId: MarkerId('courent location'),
  //           position: LatLng(33.573050, -7.597099),
  //           icon: BitmapDescriptor.defaultMarker,
  //           infoWindow: InfoWindow(title: 'Location'))
  //     ].toSet();
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            markers: markers.values.toSet(),
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(34.229059268755805, -3.99616706964861),
                zoom: 12.0),
            onMapCreated: (GoogleMapController controller) {
              controller = controller;
              getMarkerData();
            }));
  }
}
