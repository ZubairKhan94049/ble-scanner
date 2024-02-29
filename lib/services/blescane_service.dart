import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class BlescaneService {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  Future<void> scaneDevices() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        await flutterBlue.startScan(timeout: const Duration(seconds: 10));
        await flutterBlue.stopScan();
      }
    }
  }

  //Connect to Device
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
  }

  Stream<List<ScanResult>> getDevices() {
    return flutterBlue.scanResults;
  }
}
