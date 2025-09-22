// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:my_fit_update/constants/shared_prefs_strings.dart';
import 'package:my_fit_update/models/bluetooth_model.dart';
import 'package:my_fit_update/models/home.dart';
import 'package:my_fit_update/models/user_model.dart';
import 'package:my_fit_update/pages/custom_tabs.dart';
import 'package:my_fit_update/pages/device_list.dart';
import 'package:my_fit_update/pages/home.dart';
import 'package:my_fit_update/utils/shared_prefs_utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    /*  MultiProvider(
      providers: [
        ChangeNotifierProvider<BluetoothModel>(create: (_) => BluetoothModel()),
        ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
      ],
      child: const */
    MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Sensors',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) => CustomTabs()),
    );
  }

  Widget _showPage(BuildContext context) {
    // var userModel = context.read<UserModel>();
    return FutureBuilder(
      future: SharedPrefsUtils.getString(SharedPrefsStrings.DEVICE_ID_KEY),
      builder: (context, futureSnapshot) {
        String? deviceId = futureSnapshot.data;
        if (deviceId == null) {
          return const CustomTabs();
        } else {
          var bluetoothModel = context.read<BluetoothModel>();
          return StreamBuilder(
            stream: bluetoothModel.connect(deviceId),
            builder: (__, streamSnapshot) {
              if (streamSnapshot.hasData) {
                ConnectionStateUpdate? connectionStateUpdate =
                    streamSnapshot.data;
                DeviceConnectionState state =
                    connectionStateUpdate?.connectionState ??
                    DeviceConnectionState.disconnected;
                if (state == DeviceConnectionState.connected) {
                  return ChangeNotifierProvider<HomeModel>(
                    create: (_) => HomeModel(),
                    child: const HomePage(),
                  );
                } else {
                  return const DeviceListPage();
                }
              }
              return const DeviceListPage();
            },
          );
        }
      },
    );
  }
}
