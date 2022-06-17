import 'package:cloud_firestore/cloud_firestore.dart';

class StationInfoModel {
  String stationName;
  double stationAt;
  double stationLon;
  static final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("station");

  StationInfoModel(
      {required this.stationName,
      required this.stationLon,
      required this.stationAt});

  static List<StationInfoModel> getStations() {
    List<StationInfoModel> stations = [];
    stations.add(StationInfoModel(
        stationLon: 12, stationAt: 10, stationName: "station1"));
    stations.add(StationInfoModel(
        stationLon: 12, stationAt: 10, stationName: "station2"));
    stations.add(StationInfoModel(
        stationLon: 12, stationAt: 10, stationName: "station3"));
    stations.add(StationInfoModel(
        stationLon: 12, stationAt: 10, stationName: "station4"));
    stations.add(StationInfoModel(
        stationLon: 12, stationAt: 10, stationName: "station5"));
    return stations;
  }

  static  getStationData() async {
    List<StationInfoModel> station = [];
    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        Map<String, dynamic> data = result.data()! as Map<String, dynamic>;
        station.add(new StationInfoModel(
            stationName: data['name'],
            stationLon: data['longitutde'],
            stationAt: data['atitude']));
      }
    });
  }

  static setStationData() async {
    Map<String, dynamic> data = {
      'name': 'station4',
      'latitude': 17.66,
      "logitude": -1.33
    };

    await collectionRef
        .doc()
        .set(data)
        .then((value) => print("data is stored"))
        .catchError((onError) => print(" somthing wrang : $onError"));
  }
}
