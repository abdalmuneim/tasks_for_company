
class ShipmentModels {
  final String uid;
  final String driver;
  final String shipmentId;
  final LocationModel shipmentLocation;
  final String createAt;
  String? updateAt;
  final String timestamp;
  LocationModel? driverLocation;
  final bool isCompleted;
  final bool isStart;

  ShipmentModels({
    required this.uid,
    required this.driver,
    required this.shipmentId,
    required this.shipmentLocation,
    required this.createAt,
    this.updateAt,
    required this.timestamp,
    this.driverLocation,
    required this.isCompleted,
    required this.isStart,
  });

  factory ShipmentModels.fromJson(Map<String, dynamic> json) => ShipmentModels(
        uid: json["uid"],
        driver: json["driver"],
        shipmentId: json["shipmentId"],
        shipmentLocation: LocationModel.fromJson(json["shipmentLocation"]),
        createAt: json["createAt"],
        updateAt: json["updateAt"],
        timestamp: json["timestamp"],
        driverLocation: LocationModel.fromJson(json["driverLocation"]),
        isCompleted: json["isCompleted"],
        isStart: json["isStart"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "driver": driver,
        "shipmentId": shipmentId,
        "shipmentLocation": shipmentLocation.toJson(),
        "createAt": createAt,
        "updateAt": updateAt,
        "timestamp": timestamp,
        "driverLocation": driverLocation?.toJson(),
        "isCompleted": isCompleted,
        "isStart": isStart,
      };
}

class LocationModel {
  final String latitude;
  final String longitude;

  LocationModel({required this.latitude, required this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(latitude: json["latitude"], longitude: json["longitude"]);
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
