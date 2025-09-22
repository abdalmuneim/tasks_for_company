import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BluetoothDevice implements Comparable {
  final DiscoveredDevice device;
  DeviceConnectionState? status;

  BluetoothDevice(this.device, this.status);

  @override
  int compareTo(other) {
    if (other is BluetoothDevice) {
      if ((status == null) && (other.status == null)) {
        // equal
        return 0;
      }
      if (status == null) {
        // this comes before other
        return -1;
      }

      if (other.status == null) {
        // other comes before this
        return 1;
      }

      // compare status in alphabetical order
      return status!.name.compareTo(other.status!.name);
    }
    return -1;
  }
}
