import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:my_fit_update/utils/bluetooth_utils.dart';

class GyroDataComponent extends StatelessWidget {
  const GyroDataComponent(this._gyroStream, this.ble, {super.key});
  final Stream<List<int>> _gyroStream;
  final FlutterReactiveBle ble;

  @override
  Widget build(BuildContext context) {
    // ble.writeCharacteristicWithoutResponse
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade200, Colors.white, Colors.grey.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(int.parse('bebebe', radix: 16) + 0xFF000000),
            // Shadow for bottom right corner
            offset: const Offset(10, 10),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(child: Center(child: Icon(Icons.abc_outlined))),
          Container(width: 1, height: 80, color: Colors.grey.shade800),
          Expanded(
            child: Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: StreamBuilder(
                  stream: _gyroStream,
                  builder: (context, snapshot) {
                    List<int>? values = snapshot.data;
                    debugPrint(values.toString());
                    List<Map<String, int>> hr = BluetoothUtils.getGyro(
                      values ?? [],
                    );
                    debugPrint('hr: $hr');
                    return Center(
                      child: Text(
                        (hr != -1) ? hr.toString() : '--',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
