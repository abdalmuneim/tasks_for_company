const String tableRooms = 'rooms';

class RoomsModel {
  RoomsModel({
    required this.rooms,
  });

  final List<RoomModel> rooms;

  factory RoomsModel.fromJson(Map<String, dynamic> json) =>
      RoomsModel(
        rooms: List<RoomModel>.from(
            json["rooms"].map((json) => RoomModel.fromJson(json))),
      );

  Map<String, dynamic> toJson() =>
      {
        "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
      };
}

class RoomFields {
  static final List<String> values = [
    id,
    roomNum,
    statusRoom,
    doubleSingle,
    hotelBranch,
    price,
  ];

  static const String id = 'id';
  static const String roomNum = 'room_num';
  static const String statusRoom = 'status_room';
  static const String doubleSingle = 'double_single';
  static const String hotelBranch = 'hotel_branch';
  static const String price = 'price';
}

class RoomModel {
  final int id;
  final String roomNum;
  final int statusRoom;
  final String doubleSingle;
  final String hotelBranch;
  final int price;

  RoomModel({
    required this.id,
    required this.roomNum,
    required this.statusRoom,
    required this.doubleSingle,
    required this.hotelBranch,
    required this.price,
  });

  RoomModel copy({
    int? id,
    String? roomNum,
    int? statusRoom,
    String? doubleSingle,
    String? hotelBranch,
    int? price,
  }) =>
      RoomModel(
        id: id ?? this.id,
        roomNum: roomNum ?? this.roomNum,
        statusRoom: statusRoom ?? this.statusRoom,
        doubleSingle: doubleSingle ?? this.doubleSingle,
        hotelBranch: hotelBranch ?? this.hotelBranch,
        price: price ?? this.price,
      );

  static RoomModel fromJson(Map<String, Object?> json) => RoomModel(
        id: json[RoomFields.id] as int,
        roomNum: json[RoomFields.roomNum] as String,
        statusRoom: json[RoomFields.statusRoom] as int,
        doubleSingle: json[RoomFields.doubleSingle] as String,
        hotelBranch: json[RoomFields.hotelBranch] as String,
        price: json[RoomFields.price] as int,
      );

  Map<String, Object?> toJson() => {
        RoomFields.id: id,
        RoomFields.roomNum: roomNum,
        RoomFields.statusRoom: statusRoom,
        RoomFields.doubleSingle: doubleSingle,
        RoomFields.hotelBranch: hotelBranch,
        RoomFields.price: price,
      };
}
