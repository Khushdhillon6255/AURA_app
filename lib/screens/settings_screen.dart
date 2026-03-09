import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

// --- FIX: Maine LoginScreen da import hata ditta hai taaki error na aave ---

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? deviceName;
  String? deviceVersion;
  String? deviceIdentifier;

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isWindows) {
        final WindowsDeviceInfo windowsInfo = await deviceInfoPlugin.windowsInfo;
        setState(() {
          deviceName = windowsInfo.computerName;
          deviceVersion = 'Windows ${windowsInfo.displayVersion}';
          deviceIdentifier = windowsInfo.deviceId;
        });
      } else if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = '${androidInfo.brand} ${androidInfo.model}';
          deviceVersion = 'Android ${androidInfo.version.release}';
          deviceIdentifier = androidInfo.id;
        });
      }
    } catch (e) {
      debugPrint('Failed to get device info: $e');
    }
  }

  // --- LOGOUT FUNCTION (Simple Version) ---
  void _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        // Hunn eh Login page te nahi jayega, bas message dikhayega
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged out successfully! (Restart app to login again)'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  // --- ABOUT DIALOG ---
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1e1e2d),
          title: const Text("About Aura", style: TextStyle(color: Colors.white)),
          content: const Text(
            "Aura is a smart safety app designed to protect users with features like SOS, Real-time tracking, and Smartwatch integration.\n\nVersion: 1.0.0",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          actions: [
            TextButton(
              child: const Text("Close", style: TextStyle(color: Colors.blueAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff12122c),
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xff12122c),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Device Info Card
            Card(
              color: Colors.white.withOpacity(0.1),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone_android, color: Colors.blueAccent),
                ),
                title: Text(
                  deviceName ?? 'Loading Device Info...',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  '${deviceVersion ?? ''}',
                  style: const TextStyle(fontSize: 12, color: Colors.white60),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Options List
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: Colors.white70),
                    title: const Text('About App', style: TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white38),
                    onTap: _showAboutDialog,
                  ),
                  Divider(height: 1, indent: 50, color: Colors.white.withOpacity(0.1)),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.redAccent),
                    title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
                    onTap: _handleLogout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}