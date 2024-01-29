import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'provider_rooms.dart';
import '../helper/print.dart';
import '../model/booking_model.dart';
import '../model/room_model.dart';
import '../services/database_helper_booking.dart';

class ProviderBooking extends ChangeNotifier {
  String? guestName;

  String? guestNum;

  bool _suite = false;

  bool get suite => _suite;

  double _totalPrice = 0;

  double get totalPrice => _totalPrice;

  getTotalPrice() {
    // _totalPrice = _totalPrice * int.parse(daysNum);
    printInDebug('total price up: $_totalPrice');
    for (String val in _selectedRooms) {
      final text = val.indexOf('Double');
      printInDebug('Index Of: $text');
      if (text > -1) {
        _totalPrice += 200;
      } else {
        _totalPrice += 100;
      }
    }
    if (_suite) {
      _totalPrice *= 2;
    } else {
      _totalPrice = _totalPrice;
    }

    printInDebug('total price: $_totalPrice');
    notifyListeners();
    return _totalPrice;
  }

  onSuitChang(value) {
    _totalPrice = 0.0;
    _suite = value;
    getTotalPrice();
    notifyListeners();
  }

  DateTime _startDate = DateTime.now();

  DateTime get startDate => _startDate;

  Future<void> selectedStartDate(picked) async {
    _startDate = picked;
    printInDebug(_startDate.toIso8601String());
    notifyListeners();
  }

  String getStartDateText() {
    final String text;
    text = DateFormat('dd/MM/yyyy').format(_startDate);
    printInDebug(text);
    return text;
  }

  String daysNum = '1';

  selectDaysNumber(String picked) async {
    daysNum = picked;
    _totalPrice *= double.parse(daysNum);
    notifyListeners();
  }

  onGuestNameChange(val) {
    notifyListeners();
    return guestName = val;
  }

  onGuestNuMChange(val) {
    notifyListeners();
    return guestNum = val;
  }

  List<String> _selectedRooms = [];

  List<String> get onRoomsChange => _selectedRooms;

  set onRoomsChange(val) {
    _totalPrice = 0.0;
    _selectedRooms = val;
    getTotalPrice();
    notifyListeners();
  }

  final List<String> _roomsNum = [];

  List<String> get roomsNum => _roomsNum;

  getRoomsNum() {
    for (var val in roomsAvailable) {
      if (val.doubleSingle == 'double') {
        _roomsNum.add('${val.roomNum} (Double)');
      } else {
        _roomsNum.add(val.roomNum);
      }
    }
    return _roomsNum;
  }

  var _hotelBranch = 'Hotel branches';

  String get onHotelBranchChange => _hotelBranch;

  set onHotelBranchChange(val) {
    _hotelBranch = val;
    notifyListeners();
  }

  final List<String> _items = [];

  List<String> get items => _items;

  List<String> getHotelBranches() {
    final Set<String> list =
        Set<String>.from(roomsAvailable.map((e) => e.hotelBranch));
    _items.add('Hotel branches');
    for (var val in list) {
      _items.add(val);
    }
    printInDebug('item: ${items.length}');
    notifyListeners();
    return _items;
  }

  final List<RoomModel> _roomsAvailable = [];

  UnmodifiableListView<RoomModel> get roomsAvailable =>
      UnmodifiableListView(_roomsAvailable);

  getAvailableRooms() async {
    final rooms = await ProviderRooms().getAllRooms();
    for (var val in rooms) {
      if (val.statusRoom == 0) {
        printInDebug('roomID: ${val.id}');
        _roomsAvailable.add(RoomModel(
          id: val.id,
          roomNum: val.roomNum,
          statusRoom: val.statusRoom,
          doubleSingle: val.doubleSingle,
          hotelBranch: val.hotelBranch,
          price: val.price,
        ));
      }
    }
    getHotelBranches();
    getRoomsNum();
    notifyListeners();
  }

  bool _haveBooked = false;

  bool get haveBooked => _haveBooked;

  onHaveBookedChang(bool val) {
    FocusManager.instance.primaryFocus?.unfocus();
    _totalPrice = 0.0;
    _haveBooked = val;
    getTotalPrice();
    final discounted = (_totalPrice * 95) / 100;
    if (_haveBooked) {
      _totalPrice = _totalPrice - discounted;
    } else {
      _totalPrice = _totalPrice + discounted;
    }
    notifyListeners();
  }

  String? id;

  onIDChange(val) {
    id = val;
  }

  createBooking(context) async {
    try {
      final booked = BookingModel(
        guestName: guestName!,
        roomNum: _selectedRooms.toString(),
        guestNum: guestNum!,
        hotelBranch: _hotelBranch,
        suit: _suite,
        startTime: _startDate,
        daysNum: daysNum,
        totalPrice: _totalPrice,
      );
      await DBHelper.instance.createBooking(booked);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Booked'),
      ));
      printInDebug('success add');
    } catch (e) {
      printInDebug('Error--> $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something wrong...'),
      ));
    }
    notifyListeners();
  }
}
