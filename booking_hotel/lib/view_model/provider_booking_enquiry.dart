import 'package:booking_hotel/helper/print.dart';
import 'package:booking_hotel/model/booking_model.dart';
import 'package:booking_hotel/services/database_helper_booking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderBookingEnquiry extends ChangeNotifier {
  final List<BookingModel> _booking = [];

  List<BookingModel> get booking => _booking;

  getOneBook(int id) async {
    _booking.clear();
    final BookingModel singleBook = await DBHelper.instance.readBooking(id);
    _booking.add(singleBook);
    printInDebug('Data: $_booking');
    notifyListeners();
  }

  getAllBooks() async {
    _booking.clear();
    printInDebug('Data: $_booking');
    final List<BookingModel> allBook = await DBHelper.instance.readAllBooking();
    for (var val in allBook) {
      _booking.add(val);
    }
    printInDebug('Data: $_booking');
    notifyListeners();
  }

  String? id;

  onIDChang(value, context) {
    id = value;
    try {
      printInDebug('ID: $id');
      getOneBook(int.parse(id!));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('NoT Fond'),
      ));
    }
    notifyListeners();
  }
}
