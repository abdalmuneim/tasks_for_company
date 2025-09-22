import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smartwatch BLE Connect',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SmartWatchBLEScreen(),
    );
  }
}

class SmartWatchBLEScreen extends StatefulWidget {
  const SmartWatchBLEScreen({super.key});

  @override
  State<SmartWatchBLEScreen> createState() => _SmartWatchBLEScreenState();
}

class _SmartWatchBLEScreenState extends State<SmartWatchBLEScreen> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  // Scanning state
  bool isScanning = false;

  // Connected device
  BluetoothDevice? connectedDevice;

  // List of discovered devices
  final List<BluetoothDevice> discoveredDevices = [];

  // Health data
  int steps = 0;
  double heartRate = 0.0;

  // Stream subscriptions
  StreamSubscription<List<ScanResult>>? scanSubscription;
  StreamSubscription<BluetoothConnectionState>? deviceStateSubscription;
  List<StreamSubscription>? characteristicSubscriptions = [];

  // Debug log
  List<String> debugLogs = [];

  // Service and characteristic map for the connected device
  Map<String, BluetoothService> discoveredServices = {};
  Map<String, Map<String, BluetoothCharacteristic>> discoveredCharacteristics =
      {};

  // Features available on the connected device
  Set<String> availableFeatures = {};

  // Common known services (short UUIDs)
  static const Map<String, String> knownServices = {
    '180d': 'Heart Rate Service',
    '180f': 'Battery Service',
    '1800': 'Generic Access',
    '1801': 'Generic Attribute',
    '1802': 'Immediate Alert',
    '1803': 'Link Loss',
    '1804': 'Tx Power',
    '1805': 'Current Time Service',
    '1806': 'Reference Time Update Service',
    '1807': 'Next DST Change Service',
    '1808': 'Glucose',
    '1809': 'Health Thermometer',
    '180a': 'Device Information',
    '181a': 'Environmental Sensing',
    '181b': 'Body Composition',
    '181c': 'User Data',
    '181d': 'Weight Scale',
    '181e': 'Bond Management',
    '181f': 'Continuous Glucose Monitoring',
    '1810': 'Blood Pressure',
    '1811': 'Alert Notification Service',
    '1812': 'Human Interface Device',
    '1813': 'Scan Parameters',
    '1814': 'Running Speed and Cadence',
    '1815': 'Automation IO',
    '1816': 'Cycling Speed and Cadence',
    '1818': 'Cycling Power',
    '1819': 'Location and Navigation',
    '1820': 'Internet Protocol Support',
    '1821': 'Indoor Positioning',
    '1822': 'Pulse Oximeter',
    '1826': 'Fitness Machine',
    '18a0': 'Activity Data (Custom)',
  };

  // Common known characteristics (short UUIDs)
  static const Map<String, String> knownCharacteristics = {
    '2a00': 'Device Name',
    '2a01': 'Appearance',
    '2a02': 'Peripheral Privacy Flag',
    '2a03': 'Reconnection Address',
    '2a04': 'Peripheral Preferred Connection Parameters',
    '2a05': 'Service Changed',
    '2a06': 'Alert Level',
    '2a07': 'Tx Power Level',
    '2a08': 'Date Time',
    '2a09': 'Day of Week',
    '2a19': 'Battery Level',
    '2a1c': 'Temperature Measurement',
    '2a1d': 'Temperature Type',
    '2a1e': 'Intermediate Temperature',
    '2a21': 'Measurement Interval',
    '2a22': 'Boot Keyboard Input Report',
    '2a23': 'System ID',
    '2a24': 'Model Number String',
    '2a25': 'Serial Number String',
    '2a26': 'Firmware Revision String',
    '2a27': 'Hardware Revision String',
    '2a28': 'Software Revision String',
    '2a29': 'Manufacturer Name String',
    '2a37': 'Heart Rate Measurement',
    '2a38': 'Body Sensor Location',
    '2a39': 'Heart Rate Control Point',
    '2a3f': 'Alert Status',
    '2a40': 'Ringer Control Point',
    '2a41': 'Ringer Setting',
    '2a42': 'Alert Category ID Bit Mask',
    '2a43': 'Alert Category ID',
    '2a44': 'Alert Notification Control Point',
    '2a45': 'Unread Alert Status',
    '2a46': 'New Alert',
    '2a47': 'Supported New Alert Category',
    '2a48': 'Supported Unread Alert Category',
    '2a49': 'Blood Pressure Feature',
    '2a4a': 'Blood Pressure Measurement',
    '2a4b': 'Intermediate Cuff Pressure',
    '2a4c': 'HR Measurement',
    '2a4d': 'SC Control Point',
    '2a4e': 'IDD Status Changed',
    '2a4f': 'IDD Status',
    '2a53': 'RSC Measurement',
    '2a54': 'RSC Feature',
    '2a55': 'SC Control Point',
    '2a56': 'Digital',
    '2a57': 'Analog',
    '2a58': 'Aggregate',
    '2a59': 'CSC Measurement',
    '2a5a': 'CSC Feature',
    '2a5b': 'Sensor Location',
    '2a5c': 'PLX Spot-Check Measurement',
    '2a5d': 'PLX Continuous Measurement',
    '2a5e': 'PLX Features',
    '2a63': 'Cycling Power Measurement',
    '2a64': 'Cycling Power Vector',
    '2a65': 'Cycling Power Feature',
    '2a66': 'Cycling Power Control Point',
    '2a67': 'Location and Speed',
    '2a68': 'Navigation',
    '2a69': 'Position Quality',
    '2a6a': 'LN Feature',
    '2a6b': 'LN Control Point',
  };

  // Connection status
  String connectionStatus = "Disconnected";

  @override
  void initState() {
    super.initState();
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((
      state,
    ) {
      _adapterState = state;
      log('Adapter state: $_adapterState');

      if (mounted) {
        setState(() {});
      }
    });
    _checkPermissions();
  }

  @override
  void dispose() {
    _cleanupConnections();
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  void addLog(String message) {
    setState(() {
      debugLogs.add("${DateTime.now().toString().split('.').first}: $message");
      if (debugLogs.length > 100) {
        debugLogs.removeAt(0);
      }
    });
    print(message);
  }

  Future<void> _checkPermissions() async {
    // Check platform
    if (Platform.isAndroid) {
      // For Android 12+
      await Permission.bluetoothScan.request();
      await Permission.bluetoothConnect.request();
      await Permission.location.request();
    }
    startScan();
  }

  void _cleanupConnections() {
    // Cancel scan subscription
    scanSubscription?.cancel();

    // Cancel device state subscription
    deviceStateSubscription?.cancel();

    // Cancel characteristic subscriptions
    if (characteristicSubscriptions != null) {
      for (var subscription in characteristicSubscriptions!) {
        subscription.cancel();
      }
    }
    characteristicSubscriptions = [];

    // Disconnect from device
    connectedDevice?.disconnect();
  }

  Future<void> startScan() async {
    setState(() {
      discoveredDevices.clear();
      isScanning = true;
      connectionStatus = "Scanning...";
    });

    // Check if Bluetooth is turned on
    if (_adapterState != BluetoothAdapterState.on) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Bluetooth is turned off')));
      setState(() {
        isScanning = false;
      });
      return;
    }

    // Start scanning
    try {
      scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        // Add only devices that aren't already in the list
        for (ScanResult result in results) {
          if (!discoveredDevices.contains(result.device) &&
              result.device.platformName.isNotEmpty) {
            setState(() {
              discoveredDevices.add(result.device);
            });
            addLog(
              'Found device: ${result.device.platformName} (${result.rssi} dBm)',
            );
          }
        }
      });

      // Start scanning
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 10),
        androidScanMode: AndroidScanMode.lowLatency,
      );

      // After scan completes
      setState(() {
        isScanning = false;
        connectionStatus = "Scan complete";
      });
      addLog('Scan complete. Found ${discoveredDevices.length} devices');
    } catch (e) {
      addLog('Error scanning: $e');
      setState(() {
        isScanning = false;
        connectionStatus = "Scan error";
      });
    }
  }

  Future<void> stopScan() async {
    if (isScanning) {
      FlutterBluePlus.stopScan();
      setState(() {
        isScanning = false;
        connectionStatus = "Scan stopped";
      });
      addLog('Scan stopped manually');
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    // First stop scanning if it's still going
    await stopScan();

    setState(() {
      connectedDevice = device;
      connectionStatus = "Connecting...";
      // Reset device-specific data
      discoveredServices.clear();
      discoveredCharacteristics.clear();
      availableFeatures.clear();
      steps = 0;
      heartRate = 0.0;
    });

    addLog('Connecting to ${device.platformName}...');

    try {
      // Connect to the device
      await device.connect(
        autoConnect: false,
        timeout: const Duration(seconds: 30),
      );

      setState(() {
        connectionStatus = "Connected";
      });
      addLog('Connected to ${device.platformName}');

      // Listen for connection state changes
      deviceStateSubscription = device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          setState(() {
            connectedDevice = null;
            connectionStatus = "Disconnected";
          });
          addLog('Device disconnected');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Device disconnected')));
        }
      });

      // Discover services
      addLog('Discovering services...');
      List<BluetoothService> services = await device.discoverServices();
      addLog('Found ${services.length} services');

      // Clear existing subscriptions
      if (characteristicSubscriptions != null) {
        for (var subscription in characteristicSubscriptions!) {
          subscription.cancel();
        }
      }
      characteristicSubscriptions = [];

      // Process discovered services
      await _processDiscoveredServices(services);

      // After services are processed, try to setup health monitoring
      _setupHealthMonitoring();
    } catch (e) {
      addLog('Error connecting: $e');
      setState(() {
        connectedDevice = null;
        connectionStatus = "Connection failed";
      });
    }
  }

  Future<void> _processDiscoveredServices(
    List<BluetoothService> services,
  ) async {
    for (BluetoothService service in services) {
      // Get short UUID for readability and mapping
      String shortUuid = _getShortUuid(service.uuid.toString());
      String serviceName = knownServices[shortUuid] ?? 'Unknown Service';

      addLog('Service: $shortUuid ($serviceName)');

      // Store the service
      discoveredServices[shortUuid] = service;
      discoveredCharacteristics[shortUuid] = {};

      // Map characteristics for each service
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        String charShortUuid = _getShortUuid(characteristic.uuid.toString());
        String charName =
            knownCharacteristics[charShortUuid] ?? 'Unknown Characteristic';

        addLog('  Characteristic: $charShortUuid ($charName)');

        // Store the characteristic
        discoveredCharacteristics[shortUuid]![charShortUuid] = characteristic;

        // Identify potential features based on known characteristics
        _identifyFeatureFromCharacteristic(shortUuid, charShortUuid, charName);
      }
    }

    // Log discovered features
    if (availableFeatures.isNotEmpty) {
      addLog('Discovered features: ${availableFeatures.join(', ')}');
    } else {
      addLog('No specific health features identified automatically');
    }
  }

  void _identifyFeatureFromCharacteristic(
    String serviceUuid,
    String charUuid,
    String charName,
  ) {
    // Heart Rate feature detection
    if (serviceUuid == '180d' || charName.toLowerCase().contains('heart')) {
      availableFeatures.add('heart_rate');
    }

    // Step Counter feature detection
    if (charName.toLowerCase().contains('step') ||
        charUuid == '2a56' || // Digital (sometimes used for steps)
        charUuid == '2a58') {
      // Aggregate
      availableFeatures.add('step_counter');
    }

    // Battery feature detection
    if (serviceUuid == '180f' || charName.toLowerCase().contains('battery')) {
      availableFeatures.add('battery');
    }

    // Activity data detection (various services may implement this)
    if (serviceUuid == '18a0' || charName.toLowerCase().contains('activity')) {
      availableFeatures.add('activity');
    }
  }

  void _setupHealthMonitoring() {
    addLog('Setting up health monitoring...');

    // Process services to determine which ones might provide health data
    // Heart Rate monitoring
    if (availableFeatures.contains('heart_rate')) {
      _setupHeartRateMonitoring();
    } else {
      addLog('Heart rate feature not detected, trying generic approach...');
      _tryGenericHeartRateMonitoring();
    }

    // Step counting
    if (availableFeatures.contains('step_counter')) {
      _setupStepCountMonitoring();
    } else {
      addLog('Step counter feature not detected, trying generic approach...');
      _tryGenericStepCountMonitoring();
    }

    // If no features were detected, try the brute force approach
    if (availableFeatures.isEmpty) {
      addLog(
        'No specific features detected, trying brute force characteristic discovery...',
      );
      _tryBruteForceCharacteristicDiscovery();
    }
  }

  void _setupHeartRateMonitoring() {
    // Standard Heart Rate Service (0x180D)
    if (discoveredServices.containsKey('180d')) {
      var hrService = discoveredServices['180d']!;

      // Try to find the Heart Rate Measurement characteristic (0x2A37)
      for (var characteristic in hrService.characteristics) {
        String charUuid = _getShortUuid(characteristic.uuid.toString());
        if (charUuid == '2a37') {
          addLog('Found standard Heart Rate Measurement characteristic');
          _setupCharacteristicNotification(characteristic, 'Heart Rate');
          return;
        }
      }
    }

    // Try other services that might contain heart rate data
    for (var serviceEntry in discoveredServices.entries) {
      // Check if any characteristic names suggest heart rate
      for (var charEntry
          in discoveredCharacteristics[serviceEntry.key]!.entries) {
        String charName = knownCharacteristics[charEntry.key] ?? '';
        if (charName.toLowerCase().contains('heart') ||
            charName.toLowerCase().contains('hr')) {
          addLog(
            'Found potential heart rate characteristic: ${charEntry.key} ($charName)',
          );
          _setupCharacteristicNotification(charEntry.value, 'Heart Rate');
          return;
        }
      }
    }

    addLog('Could not find a suitable heart rate characteristic');
  }

  void _setupStepCountMonitoring() {
    // Check common services that might contain step data
    // CSC Service (Cycling Speed and Cadence, sometimes used for steps)
    if (discoveredServices.containsKey('1816')) {
      var service = discoveredServices['1816']!;
      for (var characteristic in service.characteristics) {
        String charUuid = _getShortUuid(characteristic.uuid.toString());
        if (charUuid == '2a5b' || charUuid == '2a53') {
          // Sensor location or measurement
          addLog('Found potential step characteristic in CSC service');
          _setupCharacteristicNotification(characteristic, 'Steps');
          return;
        }
      }
    }

    // Running Speed and Cadence
    if (discoveredServices.containsKey('1814')) {
      var service = discoveredServices['1814']!;
      for (var characteristic in service.characteristics) {
        String charUuid = _getShortUuid(characteristic.uuid.toString());
        if (charUuid == '2a53') {
          // RSC Measurement
          addLog('Found potential step characteristic in RSC service');
          _setupCharacteristicNotification(characteristic, 'Steps');
          return;
        }
      }
    }

    // Look for characteristics that might contain step data based on name
    for (var serviceEntry in discoveredServices.entries) {
      for (var charEntry
          in discoveredCharacteristics[serviceEntry.key]!.entries) {
        String charName = knownCharacteristics[charEntry.key] ?? '';
        if (charName.toLowerCase().contains('step') ||
            charName.toLowerCase().contains('csc') ||
            charName.toLowerCase().contains('rsc') ||
            charName.toLowerCase().contains('measurement')) {
          addLog(
            'Found potential step characteristic: ${charEntry.key} ($charName)',
          );
          _setupCharacteristicNotification(charEntry.value, 'Steps');
          return;
        }
      }
    }

    // Activity service often contains step data
    if (discoveredServices.containsKey('18a0')) {
      for (var characteristic in discoveredServices['18a0']!.characteristics) {
        addLog(
          'Trying characteristic in Activity service: ${_getShortUuid(characteristic.uuid.toString())}',
        );
        _setupCharacteristicNotification(characteristic, 'Steps');
        return;
      }
    }

    addLog('Could not find a suitable step count characteristic');
  }

  void _tryGenericHeartRateMonitoring() {
    // Try all characteristics that support notify or indicate
    for (var serviceEntry in discoveredServices.entries) {
      for (var characteristic
          in discoveredServices[serviceEntry.key]!.characteristics) {
        if (characteristic.properties.notify ||
            characteristic.properties.indicate) {
          // If the service or characteristic has names suggesting heart rate
          String charUuid = _getShortUuid(characteristic.uuid.toString());
          String charName = knownCharacteristics[charUuid] ?? '';
          String serviceName = knownServices[serviceEntry.key] ?? '';

          if (serviceName.toLowerCase().contains('heart') ||
              charName.toLowerCase().contains('heart') ||
              serviceName.toLowerCase().contains('hr') ||
              charName.toLowerCase().contains('hr')) {
            addLog('Trying generic heart rate monitoring on: $charUuid');
            _setupCharacteristicNotification(characteristic, 'Heart Rate');
          }
        }
      }
    }
  }

  void _tryGenericStepCountMonitoring() {
    // Try all characteristics that support notify, indicate, or read
    for (var serviceEntry in discoveredServices.entries) {
      for (var characteristic
          in discoveredServices[serviceEntry.key]!.characteristics) {
        if (characteristic.properties.notify ||
            characteristic.properties.indicate ||
            characteristic.properties.read) {
          // If the service or characteristic has names suggesting step count
          String charUuid = _getShortUuid(characteristic.uuid.toString());
          String charName = knownCharacteristics[charUuid] ?? '';
          String serviceName = knownServices[serviceEntry.key] ?? '';

          if (serviceName.toLowerCase().contains('step') ||
              charName.toLowerCase().contains('step') ||
              serviceName.toLowerCase().contains('activity') ||
              charName.toLowerCase().contains('activity') ||
              serviceName.toLowerCase().contains('fitness') ||
              charName.toLowerCase().contains('fitness')) {
            addLog('Trying generic step monitoring on: $charUuid');
            _setupCharacteristicNotification(characteristic, 'Steps');
          }
        }
      }
    }
  }

  void _tryBruteForceCharacteristicDiscovery() {
    // As a last resort, try all characteristics that support notifications or read
    addLog('Attempting brute force discovery of health characteristics...');

    int count = 0;
    for (var serviceEntry in discoveredServices.entries) {
      for (var characteristic
          in discoveredServices[serviceEntry.key]!.characteristics) {
        // Skip the very common characteristics that are unlikely to be health data
        String charUuid = _getShortUuid(characteristic.uuid.toString());
        if (charUuid == '2a00' || charUuid == '2a01' || charUuid == '2a05') {
          continue; // Skip device name, appearance, and service changed
        }

        if (characteristic.properties.notify ||
            characteristic.properties.indicate) {
          addLog('Trying brute force notification on: $charUuid');
          _setupCharacteristicNotification(characteristic, 'Unknown');
          count++;
        } else if (characteristic.properties.read) {
          addLog('Trying brute force read on: $charUuid');
          _setupCharacteristicRead(characteristic, 'Unknown');
          count++;
        }

        // Limit to avoid overwhelming the device
        if (count >= 5) break;
      }
      if (count >= 5) break;
    }
  }

  Future<void> _setupCharacteristicNotification(
    BluetoothCharacteristic characteristic,
    String dataType,
  ) async {
    if (characteristic.properties.notify ||
        characteristic.properties.indicate) {
      try {
        await characteristic.setNotifyValue(true);
        addLog(
          'Enabled notifications for ${_getShortUuid(characteristic.uuid.toString())}',
        );

        final subscription = characteristic.lastValueStream.listen((value) {
          if (value.isNotEmpty) {
            _processCharacteristicData(characteristic, value, dataType);
          }
        });
        characteristicSubscriptions!.add(subscription);
      } catch (e) {
        addLog('Error setting up notifications: $e');

        // If notifications fail, try periodic reads if the characteristic supports it
        if (characteristic.properties.read) {
          _setupCharacteristicRead(characteristic, dataType);
        }
      }
    } else if (characteristic.properties.read) {
      _setupCharacteristicRead(characteristic, dataType);
    }
  }

  void _setupCharacteristicRead(
    BluetoothCharacteristic characteristic,
    String dataType,
  ) {
    // Schedule periodic reads for this characteristic
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (connectedDevice == null) {
        timer.cancel();
        return;
      }

      try {
        final value = await characteristic.read();
        if (value.isNotEmpty) {
          _processCharacteristicData(characteristic, value, dataType);
        }
      } catch (e) {
        addLog('Error reading characteristic: $e');
      }
    });
  }

  void _processCharacteristicData(
    BluetoothCharacteristic characteristic,
    List<int> data,
    String dataType,
  ) {
    // Get hex representation for logging
    String hexData = data
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join(' ');
    String charUuid = _getShortUuid(characteristic.uuid.toString());
    addLog('data type: $dataType, characteristic: $charUuid, data: $hexData');
    if (dataType == 'Heart Rate' || dataType == 'Unknown') {
      // Try to interpret as heart rate
      double hr = _parseHeartRate(data, characteristic.uuid.toString());
      if (hr > 30 && hr < 240) {
        // Reasonable heart rate range
        addLog('Heart Rate from $charUuid: $hr BPM ($hexData)');
        setState(() {
          heartRate = hr;
          if (dataType == 'Unknown') {
            availableFeatures.add('heart_rate');
          }
        });
      } else if (dataType == 'Unknown') {
        // Try as step count if heart rate parsing failed
        int potentialSteps = _parseGenericValue(data);
        if (potentialSteps > 0 && potentialSteps < 100000) {
          // Reasonable step range
          addLog('Potential Steps from $charUuid: $potentialSteps ($hexData)');
          setState(() {
            steps = potentialSteps;
            availableFeatures.add('step_counter');
          });
        }
      }
    }

    if (dataType == 'Steps' || dataType == 'Unknown') {
      // Try to interpret as step count
      int stepCount = _parseStepCount(data);
      if (stepCount > 0) {
        addLog('Steps from $charUuid: $stepCount ($hexData)');
        setState(() {
          steps = stepCount;
          if (dataType == 'Unknown') {
            availableFeatures.add('step_counter');
          }
        });
      }
    }
  }

  double _parseHeartRate(List<int> data, String uuid) {
    try {
      // Standard Heart Rate Measurement parsing according to Bluetooth SIG
      if (data.isEmpty) return 0;

      // Known Heart Rate characteristic (2A37)
      String charUuid = _getShortUuid(uuid.toString());
      if (charUuid == '2a37' && data.length >= 2) {
        int offset = 0;
        int flags = data[offset++];
        bool isUint16 = ((flags & 0x01) == 0x01);

        if (isUint16 && data.length >= 3) {
          // uint16 format
          return (data[offset] | (data[offset + 1] << 8)).toDouble();
        } else {
          // uint8 format
          return data[offset].toDouble();
        }
      }

      // Try various common formats for heart rate data

      // Format 1: Direct value in first byte if it's in reasonable HR range
      if (data[0] > 30 && data[0] < 240) {
        return data[0].toDouble();
      }

      // Format 2: Value in second byte (common in some devices)
      if (data.length >= 2 && data[1] > 30 && data[1] < 240) {
        return data[1].toDouble();
      }

      // Format 3: Little-endian 16-bit integer
      if (data.length >= 2) {
        int value = data[0] | (data[1] << 8);
        if (value > 30 && value < 240) {
          return value.toDouble();
        }
      }

      // Format 4: Big-endian 16-bit integer
      if (data.length >= 2) {
        int value = (data[0] << 8) | data[1];
        if (value > 30 && value < 240) {
          return value.toDouble();
        }
      }

      // Parse common patterns in the data
      for (int i = 0; i < data.length; i++) {
        if (data[i] > 30 && data[i] < 240) {
          return data[i].toDouble();
        }
      }
    } catch (e) {
      addLog('Error parsing heart rate: $e');
    }
    return 0.0;
  }

  int _parseStepCount(List<int> data) {
    try {
      if (data.isEmpty) return 0;

      // Try various common formats for step count data

      // Format 1: Direct value as uint8
      if (data[0] > 0) {
        return data[0];
      }

      // Format 2: Little-endian 16-bit integer
      if (data.length >= 2) {
        int value = data[0] | (data[1] << 8);
        if (value > 0 && value < 100000) {
          return value;
        }
      }

      // Format 3: Big-endian 16-bit integer
      if (data.length >= 2) {
        int value = (data[0] << 8) | data[1];
        if (value > 0 && value < 100000) {
          return value;
        }
      }

      // Format 4: 32-bit integer
      if (data.length >= 4) {
        int value =
            data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
        if (value > 0 && value < 100000) {
          return value;
        }
      }

      // Parse common patterns in the data
      for (int i = 0; i < data.length - 1; i++) {
        int value = data[i] | (data[i + 1] << 8);
        if (value > 0 && value < 100000) {
          return value;
        }
      }
    } catch (e) {
      addLog('Error parsing step count: $e');
    }
    return 0;
  }

  int _parseGenericValue(List<int> data) {
    try {
      // Try to extract a meaningful integer from the data
      if (data.isEmpty) return 0;

      // Try as single byte
      if (data[0] > 0) {
        return data[0];
      }

      // Try as 16-bit little-endian
      if (data.length >= 2) {
        return data[0] | (data[1] << 8);
      }

      // Try as 16-bit big-endian
      if (data.length >= 2) {
        return (data[0] << 8) | data[1];
      }

      // Try as 32-bit little-endian
      if (data.length >= 4) {
        return data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
      }
    } catch (e) {
      addLog('Error parsing generic value: $e');
    }
    return 0;
  }

  String _getShortUuid(String uuid) {
    // Extract the short (16-bit) UUID from a full UUID string
    // Full UUID format: 0000XXXX-0000-1000-8000-00805F9B34FB where XXXX is the short UUID

    // First, remove any dashes and make lowercase
    String cleanUuid = uuid.toLowerCase().replaceAll('-', '');

    // If UUID follows standard Bluetooth format
    if (cleanUuid.length == 32 &&
        cleanUuid.startsWith('0000') &&
        cleanUuid.substring(8) == '00001000800000805f9b34fb') {
      return cleanUuid.substring(4, 8);
    }

    // For non-standard UUIDs, just return the first 4-8 chars
    if (cleanUuid.length >= 8) {
      return cleanUuid.substring(0, 8);
    }

    return cleanUuid;
  }

  Future<void> disconnectFromDevice() async {
    if (connectedDevice != null) {
      try {
        await connectedDevice!.disconnect();
        setState(() {
          connectedDevice = null;
          connectionStatus = "Disconnected";
        });
        addLog('Disconnected from device');
      } catch (e) {
        addLog('Error disconnecting: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smartwatch BLE Data Fetch'),
        actions: [
          if (connectedDevice != null)
            IconButton(
              icon: const Icon(Icons.bluetooth_disabled),
              onPressed: disconnectFromDevice,
              tooltip: 'Disconnect',
            ),
        ],
      ),
      body: Column(
        children: [
          // Status bar
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blue.shade100,
            width: double.infinity,
            child: Text(
              'Status: $connectionStatus',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // Connected device info
          if (connectedDevice != null)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.watch, size: 30),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              connectedDevice?.platformName ?? "Unknown Device",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              connectedDevice?.remoteId.toString() ?? "",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HealthDataDisplay(
                        icon: Icons.directions_walk,
                        title: 'Steps',
                        value: steps.toString(),
                      ),
                      HealthDataDisplay(
                        icon: Icons.favorite,
                        title: 'Heart Rate',
                        value:
                            heartRate > 0
                                ? '${heartRate.toStringAsFixed(0)} BPM'
                                : 'No data',
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Device list
          Expanded(
            child:
                isScanning
                    ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Scanning for devices...'),
                        ],
                      ),
                    )
                    : connectedDevice == null && discoveredDevices.isEmpty
                    ? const Center(
                      child: Text('No devices found. Tap scan to begin.'),
                    )
                    : connectedDevice == null
                    ? ListView.builder(
                      itemCount: discoveredDevices.length,
                      itemBuilder: (context, index) {
                        return DeviceListTile(
                          device: discoveredDevices[index],
                          onTap:
                              () => connectToDevice(discoveredDevices[index]),
                        );
                      },
                    )
                    : ListView.builder(
                      itemCount: debugLogs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          child: Text(
                            debugLogs[index],
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton:
          connectedDevice == null
              ? FloatingActionButton(
                onPressed: isScanning ? stopScan : startScan,
                tooltip: isScanning ? 'Stop' : 'Scan',
                child: Icon(isScanning ? Icons.stop : Icons.search),
              )
              : null,
    );
  }
}

class DeviceListTile extends StatelessWidget {
  final BluetoothDevice device;
  final VoidCallback onTap;

  const DeviceListTile({super.key, required this.device, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        device.platformName.isNotEmpty ? device.platformName : 'Unknown Device',
      ),
      subtitle: Text(device.remoteId.toString()),
      leading: const Icon(Icons.watch),
      trailing: const Icon(Icons.bluetooth),
      onTap: onTap,
    );
  }
}

class HealthDataDisplay extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const HealthDataDisplay({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}
