class TruckDriverModel {
  final String uid;
  final String name;
  final String phone;
  final String createAt;

  TruckDriverModel(
      {required this.uid,
      required this.name,
      required this.phone,
      required this.createAt});

  factory TruckDriverModel.fromJson(Map<String, dynamic> json) =>
      TruckDriverModel(
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"],
        createAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "phone": phone,
        "createdAt": createAt,
      };
}
