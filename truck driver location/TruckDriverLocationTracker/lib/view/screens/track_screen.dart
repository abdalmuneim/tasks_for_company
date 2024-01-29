import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/provider/track_location_provider.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen(
      {Key? key, required this.shipmentLocation, required this.driverLocation, required this.isComplete})
      : super(key: key);
  final LatLng shipmentLocation;
  final LatLng driverLocation;
  final bool isComplete;

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  @override
  void initState() {
    setCustomMarkIcon(widget.isComplete);
    context.read<TrackLocationProvider>().getCurrentLocation();
    context.read<TrackLocationProvider>().getPolylinePoints(
          shipmentLocation: widget.shipmentLocation,
          driverLocation: widget.driverLocation,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TrackLocationProvider read = context.read<TrackLocationProvider>();
    TrackLocationProvider watch = context.watch<TrackLocationProvider>();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Track order'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () async {
                    await read.getCurrentLocation();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ]),
          body: watch.currentLocation == null
              ? const Center(
                  child: Text("Loading..."),
                )
              : GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(watch.currentLocation!.latitude!,
                          watch.currentLocation!.longitude!),
                      zoom: 14.5),
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  tiltGesturesEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  // polylines: trackProvider.polylines.values, // used its when enable Billing
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('rout'),
                      color: Colors.blue,
                      points: watch.polyLineCoordinates,
                      width: 5,
                    )
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('current location'),
                      position: LatLng(
                          context
                              .watch<TrackLocationProvider>()
                              .currentLocation!
                              .latitude!,
                          context
                              .watch<TrackLocationProvider>()
                              .currentLocation!
                              .longitude!),
                      // icon: currentLocationIcon,
                    ),
                    Marker(
                      markerId: const MarkerId('current location'),
                      position: LatLng(widget.driverLocation.latitude,
                          widget.driverLocation.longitude),
                      icon: driverStartLocationIcon,
                    ),
                    Marker(
                      markerId: const MarkerId('shipment'),
                      position: widget.shipmentLocation,
                      icon: shipmentIcon,
                    ),
                  },
                  onMapCreated: (mapController) {
                    read.controller.complete(mapController);
                  },
                )),
    );
  }

  BitmapDescriptor shipmentIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor driverStartLocationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  setCustomMarkIcon(bool isComplete) async {
    isComplete
        ? shipmentIcon = await BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/shipmentdone.png.png')
        : shipmentIcon = await BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/destination.png');
    driverStartLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/destination.png');
    currentLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/shipment.png');
  }
}
