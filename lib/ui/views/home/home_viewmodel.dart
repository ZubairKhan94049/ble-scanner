import 'package:ble_scanner/app/app.bottomsheets.dart';
import 'package:ble_scanner/app/app.dialogs.dart';
import 'package:ble_scanner/app/app.locator.dart';
import 'package:ble_scanner/services/blescane_service.dart';
import 'package:ble_scanner/ui/common/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final BlescaneService blescaneService = locator<BlescaneService>();
  bool isLoading = false;

  //Start Scaning
  Future<void> startScanning() async {
    isLoading = true;
    notifyListeners();
    await blescaneService.scaneDevices();
    isLoading = false;
    notifyListeners();
  }

  // Stop Scanning
  Future<void> stopScanning() async {
    blescaneService.flutterBlue.stopScan();
  }

  //Connect to Device
  Future<void> connectToDevice(BluetoothDevice device) async {
    await stopScanning();
    await blescaneService.connectToDevice(device);
  }
}
