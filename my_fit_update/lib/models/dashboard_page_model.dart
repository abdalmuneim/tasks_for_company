import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:my_fit_update/models/bluetooth_model.dart';
import 'package:my_fit_update/utils/bluetooth_utils.dart';
import 'package:my_fit_update/utils/miband_utils.dart';

class IdentifiedService {
  final Service service;
  final MiBandServices? miService;

  IdentifiedService(this.service, this.miService);

  factory IdentifiedService.fromService(Service service) {
    MiBandServices? miService;
    try {
      miService = MiBandServices.values.firstWhere(
        (element) => element.uuid == service.id.toString().trim().toLowerCase(),
      );
    } catch (e) {
      // Not a Mi Band service, which is fine
      debugPrint('Not a Mi Band service: ${service.id}');
    }
    return IdentifiedService(service, miService);
  }
}

class IdentifiedCharacteristic {
  final Characteristic characteristic;
  final MiBandServiceCharacteristics? miCharacteristic;
  QualifiedCharacteristic? qualifiedCharacteristic;

  IdentifiedCharacteristic(
    this.characteristic,
    this.miCharacteristic, [
    this.qualifiedCharacteristic,
  ]);

  factory IdentifiedCharacteristic.fromCharacteristic(
    Characteristic characteristic,
  ) {
    MiBandServiceCharacteristics? miCharacteristic;
    try {
      miCharacteristic = MiBandServiceCharacteristics.values.firstWhere(
        (element) =>
            element.uuid == characteristic.id.toString().trim().toLowerCase(),
      );
    } catch (e) {
      // Not a Mi Band characteristic, which is fine
      debugPrint('Not a Mi Band characteristic: ${characteristic.id}');
    }
    return IdentifiedCharacteristic(characteristic, miCharacteristic);
  }
}

class DashboardPageModel extends ChangeNotifier {
  // Standard Bluetooth Service UUIDs
  static const Map<String, String> _standardServices = {
    '00001800-0000-1000-8000-00805f9b34fb': 'Generic Access',
    '00001801-0000-1000-8000-00805f9b34fb': 'Generic Attribute',
    '00001802-0000-1000-8000-00805f9b34fb': 'Immediate Alert',
    '00001803-0000-1000-8000-00805f9b34fb': 'Link Loss',
    '00001804-0000-1000-8000-00805f9b34fb': 'Tx Power',
    '0000180f-0000-1000-8000-00805f9b34fb': 'Battery Service',
    '000018a0-0000-1000-8000-00805f9b34fb': 'Device Management'
  };

  // Standard Bluetooth Characteristic UUIDs
  static const Map<String, String> _standardCharacteristics = {
    '00002a00-0000-1000-8000-00805f9b34fb': 'Device Name',
    '00002a01-0000-1000-8000-00805f9b34fb': 'Appearance',
    '00002a05-0000-1000-8000-00805f9b34fb': 'Service Changed',
    '00002a06-0000-1000-8000-00805f9b34fb': 'Alert Level',
    '00002a07-0000-1000-8000-00805f9b34fb': 'Tx Power Level',
    '00002a19-0000-1000-8000-00805f9b34fb': 'Battery Level',
    '00002aa0-0000-1000-8000-00805f9b34fb': 'Device Settings',
    '00002aa1-0000-1000-8000-00805f9b34fb': 'Device Status',
    '00002aa2-0000-1000-8000-00805f9b34fb': 'Device Control',
    '00002abc-0000-1000-8000-00805f9b34fb': 'Alert Status'
  };

  String _getServiceName(String uuid, MiBandServices? miService) {
    uuid = uuid.toLowerCase();
    if (_standardServices.containsKey(uuid)) {
      return _standardServices[uuid]!;
    } else if (miService != null) {
      return miService.toString();
    }
    return 'Unknown Service ($uuid)';
  }

  String _getCharacteristicName(String uuid, MiBandServiceCharacteristics? miCharacteristic) {
    uuid = uuid.toLowerCase();
    if (_standardCharacteristics.containsKey(uuid)) {
      return _standardCharacteristics[uuid]!;
    } else if (miCharacteristic != null) {
      return miCharacteristic.toString();
    }
    return 'Unknown Characteristic ($uuid)';
  }
  //DashboardPageModel(this.bluetoothModel);

  //final BluetoothModel bluetoothModel;
  Timer? _timer;
  final List<Widget> _components = [];
  final List<Map<String, int>> _gyroData = [];
  UnmodifiableListView<Widget> get components =>
      UnmodifiableListView(_components);

  String? _deviceId;
  String get deviceId => _deviceId ?? '';
  String batteryLevel = '';
  Stream<List<int>>? batteryStream;

  Future<void> _handleCharacteristic(
    IdentifiedCharacteristic characteristic,
    BluetoothModel bluetoothModel,
  ) async {
    if (characteristic.qualifiedCharacteristic == null) {
      return;
    }
    if (characteristic.miCharacteristic == null) return;
    switch (characteristic.miCharacteristic!) {
      case MiBandServiceCharacteristics.auth:
        break;
      case MiBandServiceCharacteristics.battery:
        await _handleBattery(
          characteristic.qualifiedCharacteristic!,
          bluetoothModel,
        );
        break;
      case MiBandServiceCharacteristics.steps:
        break;
      case MiBandServiceCharacteristics.heartRateMeasure:
        break;
      case MiBandServiceCharacteristics.heatRateControl:
        break;
      case MiBandServiceCharacteristics.sens:
        await _handleGyro(
          characteristic.qualifiedCharacteristic!,
          bluetoothModel,
        );
        break;
    }
  }

  Future<void> _handleBattery(
    QualifiedCharacteristic batteryCharacteristic,
    BluetoothModel bluetoothModel,
  ) async {
    List<int> values = await bluetoothModel.getCharacteristicData(
      batteryCharacteristic,
    );
    debugPrint('battery level data: ${values.toString()}');
    int batteryLevelInt = BluetoothUtils.getBatteryLevel(values);
    debugPrint('battery level: $batteryLevelInt');
    batteryLevel = batteryLevelInt.toString();
    notifyListeners();
  }

  Future<void> _handleGyro(
    QualifiedCharacteristic gyroCharacteristic,
    BluetoothModel bluetoothModel,
  ) async {
    await bluetoothModel.writeCharacteristicWithResponse(
      gyroCharacteristic,
      [0x01, 0x03, 0x19],
    );
    await bluetoothModel.writeCharacteristicWithResponse(
      gyroCharacteristic,
      [0x02],
    );

    bluetoothModel.subscribeToCharacteristic(gyroCharacteristic).listen(
      (event) {
        print("event!");
        _handleGyroData(event);
      },
    );

    _timer?.cancel(); // Cancel the previous timer if it exists
    _timer = Timer.periodic(const Duration(seconds: 12), (Timer t) async {
      print("pinging");
      await bluetoothModel.writeCharacteristicWithResponse(
        gyroCharacteristic,
        [0x16],
      );
    });
  }

  void _handleGyroData(List<int> event) {
    _gyroData.addAll(BluetoothUtils.getGyro(event));
    notifyListeners();
  }

  void init(BluetoothModel bluetoothModel, String deviceIdTemp) async {
    debugPrint('inside init');
    _deviceId = deviceIdTemp;
    debugPrint('model deviceId: $deviceIdTemp');
    var services = await bluetoothModel.discoverServices(deviceIdTemp);
    debugPrint('# services found: ${services.length}');

    final identifiedServices = services
        .map((Service e) {
          debugPrint('service: ${e.id.toString().trim().toLowerCase()}');
          debugPrint(
            'characteristics: ${e.characteristics.map((e) => e.id.toString().trim().toLowerCase())}',
          );
          try {
            return IdentifiedService.fromService(e);
          } catch (e) {
            debugPrint('error: $e');
            return null;
          }
        })
        .whereType<IdentifiedService>()
        .toList();

    for (var identifiedService in identifiedServices) {
      debugPrint("identifiedService.miService: ${identifiedService.miService}");
      String serviceName = _getServiceName(
        identifiedService.service.id.toString(),
        identifiedService.miService,
      );
      _components.add(Text("Service: $serviceName"));

      for (var characteristic in identifiedService.service.characteristics) {
        try {
          final qualifiedCharacteristic = QualifiedCharacteristic(
            serviceId: identifiedService.service.id,
            characteristicId: characteristic.id,
            deviceId: deviceIdTemp,
          );
          debugPrint(
            "qualifiedCharacteristic: ${qualifiedCharacteristic.toString()}",
          );
          final identifiedCharacteristic =
              IdentifiedCharacteristic.fromCharacteristic(characteristic);
          identifiedCharacteristic.qualifiedCharacteristic =
              qualifiedCharacteristic;
          
          String characteristicName = _getCharacteristicName(
            characteristic.id.toString(),
            identifiedCharacteristic.miCharacteristic,
          );
          debugPrint(
            "characteristic: ${characteristic.id.toString().trim().toLowerCase()}",
          );
          _components.add(Text("--> $characteristicName"));
          
          await _handleCharacteristic(identifiedCharacteristic, bluetoothModel);
        } catch (e) {
          debugPrint('error: $e');
          continue;
        }
      }
    }
    debugPrint("_components.toString(): ${_components.toString()}");
    notifyListeners();
  }
}


    // for (var service in services) {
    //   var serviceUuid = service.id;
    //   var serviceIdStr = serviceUuid.toString().trim().toLowerCase();
    //   var characteristicIds = service.characteristics.map((e) => e.id);
    //   if (serviceIdStr.contains('183e')) {
    //     // physical activity monitor service
    //     debugPrint('found physical activity monitor service');
    //     for (var characteristicId in characteristicIds) {
    //       String characteristicIdStr = characteristicId.toString().trim();
    //       if (characteristicIdStr.contains('00002b40')) {
    //         // steps
    //         final characteristic = QualifiedCharacteristic(
    //           serviceId: serviceUuid,
    //           characteristicId: characteristicId,
    //           deviceId: deviceId,
    //         );
    //         try {
    //           int goalSteps = await SharedPrefsUtils.getInt(
    //                   SharedPrefsStrings.GOAL_STEPS_KEY) ??
    //               5000;
    //           _components.insert(
    //             0,
    //             StatusDataComponent(
    //               isMi: false,
    //               goalSteps: goalSteps,
    //               statusStream:
    //                   bluetoothModel.subscribeToCharacteristic(characteristic),
    //             ),
    //           );
    //           print('components steps: $_components');
    //         } catch (err) {
    //           debugPrint('steps error');
    //           debugPrint(err.toString());
    //         }
    //       } else if (characteristicIdStr.contains('00002b41')) {
    //         // sleep instantaneous data
    //         final characteristic = QualifiedCharacteristic(
    //           serviceId: serviceUuid,
    //           characteristicId: characteristicId,
    //           deviceId: deviceId,
    //         );
    //         _components.add(SleepComponent(
    //           bluetoothModel.subscribeToCharacteristic(characteristic),
    //           isSummaryData: false,
    //         ));
    //       } else if (characteristicIdStr.contains('00002b42')) {
    //         // sleep summary data
    //         final characteristic = QualifiedCharacteristic(
    //           serviceId: serviceUuid,
    //           characteristicId: characteristicId,
    //           deviceId: deviceId,
    //         );
    //         _components.add(SleepComponent(
    //           bluetoothModel.subscribeToCharacteristic(characteristic),
    //           isSummaryData: true,
    //         ));
    //       }
    //     }
    //   } else if (serviceIdStr.contains('180d')) {
    //     // heart rate service
    //     debugPrint('found heart rate service');
    //     for (var characteristicId in characteristicIds) {
    //       String characteristicIdStr = characteristicId.toString().trim();
    //       if (characteristicIdStr.contains('00002a37')) {
    //         // heart rate measurement
    //         final characteristic = QualifiedCharacteristic(
    //           serviceId: serviceUuid,
    //           characteristicId: characteristicId,
    //           deviceId: deviceId,
    //         );
    //         // _components.add(HeartRateComponent(
    //         //     bluetoothModel.subscribeToCharacteristic(characteristic)));
    //         print('components hr: $_components');
    //       }
    //     }
    //   } else if (serviceIdStr.contains('180f')) {
    //     // battery service
    //     debugPrint('found battery service');
    //     for (var characteristicId in characteristicIds) {
    //       String characteristicIdStr = characteristicId.toString().trim();
    //       if (characteristicIdStr.contains('00002a19')) {
    //         // battery level
    //         final characteristic = QualifiedCharacteristic(
    //           serviceId: serviceUuid,
    //           characteristicId: characteristicId,
    //           deviceId: deviceId,
    //         );
    //         try {
    //           List<int> values =
    //               await bluetoothModel.getCharacteristicData(characteristic);
    //           debugPrint('battery level data: ${values.toString()}');
    //           int batteryLevelInt = BluetoothUtils.getBatteryLevel(values);
    //           debugPrint('battery level: $batteryLevelInt');
    //           batteryLevel = batteryLevelInt.toString();
    //         } catch (err) {
    //           debugPrint('battery level error');
    //           debugPrint(err.toString());
    //         }
    //       }
    //     }
    //     // } else if (serviceIdStr.contains('fee0')) {
    //   } else if (serviceIdStr == MiBandServices.hardware.uuid) {
    //     debugPrint('found mi band Hardware service');
    //     for (var characteristicId in characteristicIds) {
    //       String characteristicIdStr = characteristicId.toString().trim();
    //       if (characteristicIdStr == MiBandServiceCharacteristics.sens.uuid) {
    //         final characteristic = QualifiedCharacteristic(
    //           serviceId: serviceUuid,
    //           characteristicId: characteristicId,
    //           deviceId: deviceId,
    //         );
    //         // _components.add(GyroDataComponent(
    //         //     bluetoothModel.subscribeToCharacteristic(characteristic)));
    //         print('component gyro: $characteristic');
    //       }
    //     }
    //   } else {
    //     // debugPrint('other service: $serviceIdStr');
    //   }
    // }