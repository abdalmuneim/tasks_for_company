import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:truckdriverlocationtracker/view/widgets/custom_pop.dart';

import '../../model/shipment_model.dart';
import '../../view/screens/track_screen.dart';
import '../services/get_add_shipments_firebase.dart';
import '../services/permissions/app_permissions.dart';

class ShipmentProvider with ChangeNotifier {
  String? shipmentId;
  bool isCompleted = false;
  bool isStart = false;
  LatLng? _currentLocation;

  LatLng? get currentLocation => _currentLocation;

  onChangeShipmentId(val) {
    shipmentId = val;
    notifyListeners();
  }

  LocationModel getShipmentLocation() {
    LocationModel shipmentLocation =
        LocationModel(latitude: '30.044344', longitude: '31.235703');

    return shipmentLocation;
  }

  addShipment({
    required String uid,
    required String diver,
  }) async {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat(' MMM d, yyyy');
    var formatTime = DateFormat('  EEEE, hh:mm:aa  ');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    String createAt = '$date' '$time';

    isCompleted = false;
    isStart = false;

    await GetAndAddShipmentsFirebase().addShipmentFirebase(ShipmentModels(
      uid: uid,
      driver: diver,
      shipmentId: shipmentId!,
      shipmentLocation: getShipmentLocation(),
      createAt: createAt,
      timestamp: dbTimeKey.millisecondsSinceEpoch.toString(),
      isCompleted: isCompleted,
      isStart: isStart,
    ));
  }

  startShipment(
    context, {
    required String uid,
    required String diver,
    required String idShipment,
    required String timestamp,
    required String createAt,
  }) async {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat(' MMM d, yyyy');
    var formatTime = DateFormat('  EEEE, hh:mm:aa  ');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    String updateAt = '$date' '$time';

    isCompleted = false;
    isStart = true;

    // Create Dialog loading while get and push current location to firebase
    CustomPOP().loadingDialog(context);

    // Get Driver Location
    final LatLng? driverLocation = await getLocationTruck();
    log('current position: $driverLocation');

    /// Add Current driver location to firebase
    await GetAndAddShipmentsFirebase().updateShipmentFirebase(ShipmentModels(
      uid: uid,
      driver: diver,
      shipmentId: idShipment,
      shipmentLocation: getShipmentLocation(),
      createAt: createAt,
      timestamp: timestamp,
      updateAt: updateAt,
      driverLocation: LocationModel(
          latitude: driverLocation.toString(),
          longitude: driverLocation.toString()),
      isCompleted: isCompleted,
      isStart: isStart,
    ));

    Navigator.of(context).pop();

    final shipLoc = getShipmentLocation();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TrackScreen(
              isComplete: isCompleted,
              shipmentLocation: LatLng(double.parse(shipLoc.latitude),
                  double.parse(shipLoc.longitude)),
              driverLocation:
                  LatLng(driverLocation!.latitude, driverLocation.longitude),
            )));
  }

  completedShipment({
    required String uid,
    required String diver,
    required String idShipment,
    required String timestamp,
    required String createAt,
  }) async {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat(' MMM d, yyyy');
    var formatTime = DateFormat('  EEEE, hh:mm:aa  ');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    String updateAt = '$date' '$time';

    isCompleted = true;
    isStart = true;

    /// Add Current driver location to firebase
    await GetAndAddShipmentsFirebase().updateShipmentFirebase(ShipmentModels(
      uid: uid,
      driver: diver,
      shipmentId: idShipment,
      shipmentLocation: getShipmentLocation(),
      createAt: createAt,
      timestamp: timestamp,
      updateAt: updateAt,
      isCompleted: isCompleted,
      isStart: isStart,
    ));
  }

  Future<LatLng?>? getLocationTruck() async {
    LocationData? position;
    try {
      await AskPermissions().askLocationPermission();
      await Location().getLocation().then((value) => position = value);
      _currentLocation = LatLng(position!.latitude!, position!.longitude!);
    } catch (e) {
      log('Error--> $e');
    }
    log("current Location: $_currentLocation");
    notifyListeners();
    return _currentLocation;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getShipments(
      {required String uid, required String driver}) {
    final data = GetAndAddShipmentsFirebase().getShipmentsFirebase(uid, driver);
    log("All data: ${data.first}");
    return data;
  }
}
