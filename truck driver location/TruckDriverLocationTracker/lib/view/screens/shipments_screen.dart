import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:truckdriverlocationtracker/view/screens/track_screen.dart';
import 'package:workmanager/workmanager.dart';

import '../../core/provider/auth_provider.dart';
import '../../core/provider/get_add_shipments_provider.dart';
import '../../core/provider/track_location_provider.dart';
import '../../main.dart';
import '../widgets/Custom_button.dart';
import '../widgets/custom_pop.dart';
import '../widgets/custom_textformfild.dart';

class ShipmentsScreen extends StatefulWidget {
  const ShipmentsScreen({Key? key}) : super(key: key);

  @override
  State<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // We don't need it anymore since it will be executed in background
    //this._getUserPosition();

    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    Workmanager().registerPeriodicTask(
      "1",
      fetchBackground,
      frequency: const Duration(minutes: 30),
    );

    Provider.of<ShipmentProvider>(context, listen: false).getLocationTruck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shipmentProv = Provider.of<ShipmentProvider>(context);
    final authProv = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipments'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              CustomPOP().popDialog(
                context,
                title: Form(
                  key: _globalKey,
                  child: CustomTextFormFiled(
                    label: 'Shipment Id',
                    onSaved: (val) => shipmentProv.shipmentId = val,
                    onChanged: (val) => shipmentProv.onChangeShipmentId(val),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter Shipment Id';
                      }
                    },
                  ),
                ),
                desc: '',
                action: true,
                txtButton: 'Added',
                onPress: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (!_globalKey.currentState!.validate()) {
                    log('Error--> validate');
                  } else {
                    shipmentProv.addShipment(
                        uid: authProv.currentUser!.uid, diver: authProv.name!);
                    Navigator.of(context).pop();
                    await TrackLocationProvider().getCurrentLocation();
                  }
                },
              );
            },
            icon: const Icon(Icons.add, size: 30),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: shipmentProv.getShipments(
          uid: authProv.currentUser!.uid,
          driver: authProv.name!,
        ),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.docs;
            if (data.isNotEmpty) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final QueryDocumentSnapshot<Map<String, dynamic>> list =
                      data[index];
                  return shipmentCard(context, list, index + 1);
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No Shipment Now \n add ones',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            }
          } else {
            return CustomPOP().loadingWidget();
          }
        },
      ),
    );
  }

  shipmentCard(context, DocumentSnapshot document, int index) {
    final shipmentProv = Provider.of<ShipmentProvider>(context);
    final authProv = Provider.of<AuthProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TrackScreen(
                  isComplete: document['isCompleted'],
                  driverLocation: shipmentProv.currentLocation!,
                  shipmentLocation: LatLng(
                      double.parse(shipmentProv.getShipmentLocation().latitude),
                      double.parse(
                          shipmentProv.getShipmentLocation().longitude)),
                )));
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('$index'),
                Text(document['shipmentId']),
                document['isStart']
                    ? document['isCompleted']
                        ? const Text(
                            'Completed',
                            style: TextStyle(color: Colors.blue),
                          )
                        : const Text(
                            'Not Complete',
                            style: TextStyle(color: Colors.red),
                          )
                    : const Text('Start Now'),
              ],
            ),
            document['isStart']
                ? document['isCompleted']
                    ? const SizedBox()

                    // Button is Complete
                    : CustomButton(
                        'Completed',
                        color: Colors.blue,
                        onPress: () {
                          shipmentProv.completedShipment(
                            uid: authProv.currentUser!.uid,
                            diver: authProv.name!,
                            idShipment: document['shipmentId'],
                            timestamp: document['timestamp'],
                            createAt: document['createAt'],
                          );
                        },
                      )

                // Button is Start
                : CustomButton(
                    'Start',
                    color: Colors.blue,
                    onPress: () {
                      shipmentProv.startShipment(
                        context,
                        uid: authProv.currentUser!.uid,
                        diver: authProv.name!,
                        idShipment: document['shipmentId'],
                        timestamp: document['timestamp'],
                        createAt: document['createAt'],
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
