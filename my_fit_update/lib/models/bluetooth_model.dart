import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:my_fit_update/classes/bluetooth_device.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothModel extends ChangeNotifier {
  final _flutterReactiveBle = FlutterReactiveBle();
  StreamSubscription? _subscription;

  final List<String> _deviceIds = [];
  UnmodifiableListView<BluetoothDevice> get devices =>
      UnmodifiableListView(_devices);
  final List<BluetoothDevice> _devices = [];

  void startScanning() async {
    Map<Permission, PermissionStatus> statuses =
        await [
          Permission.location,
          Permission.bluetooth,
          Permission.bluetoothConnect,
          Permission.bluetoothScan,
        ].request();
    print(statuses);

    _deviceIds.clear();
    _devices.clear();
    notifyListeners();
    _subscription?.cancel();
    _subscription = _flutterReactiveBle
        .scanForDevices(withServices: [], scanMode: ScanMode.lowLatency)
        .listen(
          (device) {
            //code for handling results
            // debugPrint('device: ${device.name} ${device.id}');
            if (device.name.trim() != '' && !_deviceIds.contains(device.id)) {
              debugPrint(
                'deviceIds contains ${device.id}: ${_deviceIds.contains(device.id)}',
              );
              debugPrint('new device: ${device.name}');
              _deviceIds.add(device.id);
              _devices.add(BluetoothDevice(device, null));
              _devices.sort();
              notifyListeners();
            }
          },
          onError: (err) {
            //code for handling error
            debugPrint('error: ${err.toString()}');
          },
        );
  }

  Future<void> stopScanning() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  Stream<ConnectionStateUpdate> connect(String deviceId) {
    return _flutterReactiveBle.connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: 10),
    );
  }

  void connectAndUpdate(String deviceId) {
    _flutterReactiveBle
        .connectToDevice(
          id: deviceId,
          connectionTimeout: const Duration(seconds: 10),
        )
        .listen((event) {
          DeviceConnectionState status = event.connectionState;
          int index = _deviceIds.indexOf(deviceId);
          _devices[index].status = status;
          notifyListeners();
        });
  }

  Future<List<Service>> discoverServices(String deviceId) {
    _flutterReactiveBle.discoverAllServices(deviceId);
    return _flutterReactiveBle.getDiscoveredServices(deviceId);
  }

  Future<List<int>> getCharacteristicData(QualifiedCharacteristic c) {
    return _flutterReactiveBle.readCharacteristic(c);
  }

  Stream<List<int>> subscribeToCharacteristic(QualifiedCharacteristic c) {
    return _flutterReactiveBle.subscribeToCharacteristic(c);
  }

  Future<void> writeCharacteristicWithResponse(
    QualifiedCharacteristic c,
    List<int> data,
  ) {
    return _flutterReactiveBle.writeCharacteristicWithResponse(c, value: data);
  }

  Future<void> writeCharacteristic(QualifiedCharacteristic c, List<int> data) {
    return _flutterReactiveBle.writeCharacteristicWithResponse(c, value: data);
  }
}
