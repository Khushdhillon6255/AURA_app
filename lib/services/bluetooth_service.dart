import 'dart:async';
import 'package:flutter/material.dart'; // foundation di jagah material import karo
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService extends ChangeNotifier {
  BluetoothDevice? connectedDevice;
  bool get isConnected => connectedDevice != null;
  StreamSubscription<BluetoothConnectionState>? _stateSubscription;

  // Scan results nu aage bhejda hai
  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  // Device scan karna shuru karda hai
  Future<void> startScan() async {
    try {
      await FlutterBluePlus.stopScan();
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      debugPrint("ERROR starting scan: $e");
    }
  }

  // Device naal connect karda hai
  Future<void> connectToDevice(BluetoothDevice device) async {
    await disconnect(); // Pehlan purane connection nu disconnect karo
    try {
      debugPrint("Connecting to ${device.platformName}...");
      await device.connect(timeout: const Duration(seconds: 15));
      debugPrint("Connected successfully!");
      connectedDevice = device;

      _stateSubscription = device.connectionState.listen((BluetoothConnectionState state) {
        if (state == BluetoothConnectionState.disconnected) {
          debugPrint("Device disconnected!");
          disconnect(); // Auto-disconnect te clean-up
        }
        notifyListeners(); // UI nu update karo
      });

      notifyListeners(); // UI nu update karo
    } catch (e) {
      debugPrint("ERROR: Failed to connect to device. Reason: $e");
      await disconnect();
    }
  }

  // Device nu disconnect karda hai
  Future<void> disconnect() async {
    await _stateSubscription?.cancel();
    _stateSubscription = null;
    await connectedDevice?.disconnect();
    connectedDevice = null;
    debugPrint("Disconnected and cleaned up resources.");
    notifyListeners();
  }

  @override
  void dispose() {
    debugPrint("Bluetooth Service Disposed");
    disconnect();
    super.dispose();
  }
}