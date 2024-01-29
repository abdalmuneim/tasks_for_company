const String tableBooking = 'booking';

class BookingFields {
  static final List<String> values = [
    id,
    guestName,
    guestNum,
    roomNum,
    hotelBranch,
    suit,
    startTime,
    daysNum,
    totalPrice
  ];

  static const String id = 'id';
  static const String guestName = 'guestName';
  static const String guestNum = 'guestNum';
  static const String hotelBranch = 'hotelBranch';
  static const String roomNum = 'roomNum';
  static const String suit = 'suite';
  static const String startTime = 'startTime';
  static const String daysNum = 'daysNum';
  static const String totalPrice = 'totalPrice';
}

class BookingModel {
  final int? id;
  final String guestName;
  final String guestNum;
  final String hotelBranch;
  final String roomNum;
  final bool suit;
  final DateTime startTime;
  final String daysNum;
  final double totalPrice;

  BookingModel({
    this.id,
    required this.guestName,
    required this.roomNum,
    required this.startTime,
    required this.daysNum,
    required this.guestNum,
    required this.hotelBranch,
    required this.suit,
    required this.totalPrice,
  });

  BookingModel copy({
    int? id,
    String? guestName,
    String? guestNum,
    String? hotelBranch,
    String? roomNum,
    bool? suit,
    DateTime? startTime,
    String? daysNum,
    double? totalPrice,
  }) =>
      BookingModel(
        id: id ?? this.id,
        guestName: guestName ?? this.guestName,
        hotelBranch: hotelBranch ?? this.hotelBranch,
        guestNum: guestNum ?? this.guestNum,
        roomNum: roomNum ?? this.roomNum,
        suit: suit ?? this.suit,
        startTime: startTime ?? this.startTime,
        daysNum: daysNum ?? this.daysNum,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  static BookingModel fromJson(Map<String, Object?> json) => BookingModel(
        id: json[BookingFields.id] as int,
        guestName: json[BookingFields.guestName] as String,
        hotelBranch: json[BookingFields.hotelBranch] as String,
        guestNum: json[BookingFields.guestNum] as String,
        roomNum: json[BookingFields.roomNum] as String,
        suit: json[BookingFields.suit] == 0,
        startTime: DateTime.parse(json[BookingFields.startTime] as String),
        daysNum: json[BookingFields.daysNum] as String,
        totalPrice: json[BookingFields.totalPrice] as double,
      );

  Map<String, Object?> toJson() => {
        BookingFields.id: id,
        BookingFields.guestName: guestName,
        BookingFields.guestNum: guestNum,
        BookingFields.hotelBranch: hotelBranch,
        BookingFields.roomNum: roomNum,
        BookingFields.suit: suit ? 1 : 0,
        BookingFields.startTime: startTime.toIso8601String(),
        BookingFields.daysNum: daysNum,
        BookingFields.totalPrice: totalPrice,
      };
}
