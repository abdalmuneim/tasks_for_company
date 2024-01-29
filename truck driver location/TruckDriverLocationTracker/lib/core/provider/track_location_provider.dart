import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:truckdriverlocationtracker/const.dart';

class TrackLocationProvider with ChangeNotifier {
  final Completer<GoogleMapController> _controller = Completer();

  Completer<GoogleMapController> get controller => _controller;

  GoogleMapController? _newGoogleMapController;

  GoogleMapController? get newGoogleMapController => _newGoogleMapController;

  PolylinePoints? polylinePoints = PolylinePoints();
  final List<LatLng> _polyLineCoordinates = [];

  List<LatLng> get polyLineCoordinates =>
      _polyLineCoordinates; // used its when enable Billing
  Set<Polyline> _polylines = {};

  Set<Polyline> get polylines => _polylines; // used its when enable Billing

  LocationData? _currentLocation;

  LocationData? get currentLocation => _currentLocation;

  Future<LocationData?>? getCurrentLocation() async {
    Location location = Location();
    await location
        .getLocation()
        .then((location) => _currentLocation = location);
    log('Current location: $_currentLocation');

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((LocationData newLoc) {
      _currentLocation = newLoc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              )),
        ),
      );
    });
    notifyListeners();
    return _currentLocation;
  }

  getPolylinePoints({
    required LatLng shipmentLocation,
    required LatLng driverLocation,
  }) async {
    /// used it if enable Billing
/////////////////////////////////////////////////////////////////////////////////////
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      androidMapKey,
      PointLatLng(driverLocation.latitude, driverLocation.longitude),
      PointLatLng(shipmentLocation.latitude, shipmentLocation.longitude),
      // PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      travelMode: TravelMode.driving,
    );
    log('result.status: ${result.status}');

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      log('Error draw Rout: ${result.errorMessage}');
    }
/////////////////////////////////////////////////////////////////////////////////////

    /// add list location manually
    if (currentLocation != null) {
      polyLineCoordinates
          .add(LatLng(currentLocation!.latitude!, currentLocation!.longitude!));
      polyLineCoordinates.add(shipmentLocation);
      polyLineCoordinates
          .add(LatLng(currentLocation!.latitude!, currentLocation!.longitude!));
    } else {
      log('Error--> Current position is null');
    }
    notifyListeners();
  }
}
