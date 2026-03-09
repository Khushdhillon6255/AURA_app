import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// Eh class saara asli Bluetooth da kamm sambhaalegi
class BluetoothService extends ChangeNotifier {
  BluetoothDevice? connectedDevice;
  bool get isConnected => connectedDevice != null;
  StreamSubscription<BluetoothConnectionState>? _stateSubscription;

  // =======================================================
  // --- NAVA CODE START (Eh hissa add kitta gaya hai) ---
  // =======================================================

  // Eh FlutterBluePlus package de scan results nu aage bhejda hai
  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  // Eh function device scan karna shuru karda hai
  Future<void> startScan() async {
    try {
      // Pehla purana scan roko (je chal reha hai)
      await FlutterBluePlus.stopScan();
      // 5 second layi nava scan shuru karo
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    } catch (e) {
      debugPrint("ERROR starting scan: $e");
    }
  }

  // =======================================================
  // --- NAVA CODE END ---
  // =======================================================

  Future<void> connectToDevice(BluetoothDevice device) async {
    await disconnect();
    try {
      debugPrint("Connecting to ${device.platformName}...");
      await device.connect(timeout: const Duration(seconds: 15));
      debugPrint("Connected successfully!");
      connectedDevice = device;
      _stateSubscription = device.connectionState.listen((BluetoothConnectionState state) {
        if (state == BluetoothConnectionState.disconnected) {
          debugPrint("Device disconnected!");
          disconnect();
        }
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      debugPrint("ERROR: Failed to connect to device. Reason: $e");
      await disconnect();
    }
  }

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