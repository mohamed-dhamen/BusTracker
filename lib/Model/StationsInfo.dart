class StationInfoModel {
  String stationName;
  double stationAt;
  double stationLon;

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
}
