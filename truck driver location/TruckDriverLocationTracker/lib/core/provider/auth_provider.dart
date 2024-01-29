import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/truckdriver_model.dart';
import '../../view/screens/shipments_screen.dart';
import '../services/truckdriverdata_firebase.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  String? name;
  String? phone;

  onChangeName(val) {
    name = val;
    log('name: $name');
    notifyListeners();
  }

  onChangePhone(val) {
    phone = val;
    log('phone: $phone');
    notifyListeners();
  }

  bool _isPushData = false;

  bool get isPushData => _isPushData;

  /// Authenticate with Firebase anonymously
  Future<User?>? authAnonymously(context) async {
    _isPushData = true;
    try {
      log("Signed in with temporary account.");
      if (currentUser == null) {
        log("---------------- 1 -----------------");
        final UserCredential userCredential = await _auth.signInAnonymously();
        await addTruckDriverToFirebase(userCredential.user!);
        log("---------------- 2 -----------------");
      } else {
        log("---------------- 3 -----------------");
      }
      log("---------------- 4 -----------------");

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ShipmentsScreen(),
      ));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          debugPrint("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          debugPrint("Unknown error.");
      }
      _isPushData = false;
    }
    log('isPush: $_isPushData');
    notifyListeners();
    return currentUser;
  }

  addTruckDriverToFirebase(User user) async {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat(' MMM d, yyyy');
    var formatTime = DateFormat('  EEEE, hh:mm:aa  ');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    String createAt = '$date' '$time';

    await FireStoreTruckDriverUser().addUserDataToFireStore(TruckDriverModel(
      uid: user.uid,
      name: name!,
      phone: phone!,
      createAt: createAt,
    ));
    notifyListeners();
  }
}
