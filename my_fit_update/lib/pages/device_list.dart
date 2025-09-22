import 'package:flutter/material.dart';
import 'package:my_fit_update/classes/bluetooth_device.dart';
import 'package:my_fit_update/constants/shared_prefs_strings.dart';
import 'package:my_fit_update/models/bluetooth_model.dart';
import 'package:my_fit_update/models/home.dart';
import 'package:my_fit_update/pages/home.dart';
import 'package:my_fit_update/utils/navigation_utils.dart';
import 'package:my_fit_update/utils/shared_prefs_utils.dart';
import 'package:provider/provider.dart';

class DeviceListPage extends StatelessWidget {
  const DeviceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MiBand BLE Raw Hardware'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Consumer<BluetoothModel>(
                  builder:
                      (_, bluetoothModel, __) => ListView.builder(
                        itemCount: bluetoothModel.devices.length,
                        itemBuilder:
                            (context, index) => getListItem(
                              bluetoothModel.devices[index],
                              context,
                              bluetoothModel,
                            ),
                      ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<BluetoothModel>(
                    context,
                    listen: false,
                  ).startScanning();
                },
                child: const Text('Start Scanning'),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<BluetoothModel>(
                    context,
                    listen: false,
                  ).stopScanning();
                },
                child: const Text('Stop Scanning'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getListItem(
    BluetoothDevice device,
    BuildContext context,
    BluetoothModel model,
  ) {
    final name = device.device.name;
    String status = device.status?.name ?? "UNKNOWN";
    return ListTile(
      title: Text(name),
      subtitle: Text(status),
      onTap: () async {
        if (status.toLowerCase().trim() != 'connected') {
          model.stopScanning();
          model.connectAndUpdate(device.device.id);
        } else {
          await SharedPrefsUtils.setString(
            SharedPrefsStrings.DEVICE_ID_KEY,
            device.device.id,
          );
          await SharedPrefsUtils.setString(
            SharedPrefsStrings.DEVICE_NAME_KEY,
            device.device.name,
          );
          if (context.mounted) {
            NavigationUtils.pushReplacement(
              context,
              ChangeNotifierProvider<HomeModel>(
                create: (context) => HomeModel(),
                child: const HomePage(),
              ),
            );
          }
        }
      },
    );
  }
}
