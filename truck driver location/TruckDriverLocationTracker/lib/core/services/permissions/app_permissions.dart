import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AskPermissions with ChangeNotifier {
  // Start with default permission status i.e denied
  PermissionStatus _locationStatus = PermissionStatus.denied;

  // Instantiate Firebase functions
  FirebaseFunctions functions = FirebaseFunctions.instance;

  // Create a LatLng type that'll be user location
  LatLng? _locationCenter;

  get locationStatus => _locationStatus;

  get locationCenter => _locationCenter as LatLng;

  askLocationPermission() async {
    // Request for permission
    final PermissionStatus status = await Permission.location.request();
    // change the location status
    _locationStatus = status;
    // notify listeners
    notifyListeners();
    log('Permission---->$_locationStatus');
    return status;
  }
}
