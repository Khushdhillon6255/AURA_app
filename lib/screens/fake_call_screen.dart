import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class FakeCallScreen extends StatefulWidget {
  const FakeCallScreen({super.key});

  @override
  State<FakeCallScreen> createState() => _FakeCallScreenState();
}

class _FakeCallScreenState extends State<FakeCallScreen> {
  bool _isCallAccepted = false;
  Timer? _timer;
  int _seconds = 0;
  String _callDuration = "00:00";

  final FlutterRingtonePlayer _ringtonePlayer = FlutterRingtonePlayer();

  @override
  void initState() {
    super.initState();
    _startRinging();
  }

  void _startRinging() async {
    _ringtonePlayer.playRingtone(looping: true);

    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(pattern: [500, 1000, 500, 1000], repeat: 0);
    }
  }

  void _stopRinging() {
    _ringtonePlayer.stop();
    Vibration.cancel();
  }

  void _acceptCall() {
    _stopRinging();
    setState(() {
      _isCallAccepted = true;
    });
    _startTimer();
  }

  void _declineCall() {
    _stopRinging();
    Navigator.pop(context);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        int min = _seconds ~/ 60;
        int sec = _seconds % 60;
        _callDuration =
        "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
      });
    });
  }

  @override
  void dispose() {
    _stopRinging();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1C2E),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black87,
                Color(0xff0F1C2E),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 60),

              Column(
                children: [
                  Text(
                    _isCallAccepted ? _callDuration : "Incoming Call...",
                    style: const TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child:
                    Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Dad (Home)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Text(
                    "+91 98765 43210",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ],
              ),

              const Spacer(),

              Padding(
                padding:
                const EdgeInsets.only(bottom: 50, left: 30, right: 30),
                child: _isCallAccepted
                    ? _buildEndCallButton()
                    : _buildIncomingButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIncomingButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: _declineCall,
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.call_end,
                    color: Colors.white, size: 35),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Decline",
                style: TextStyle(color: Colors.white70, fontSize: 16))
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: _acceptCall,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 1.0, end: 1.1),
                duration: const Duration(milliseconds: 800),
                builder: (context, scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.call,
                      color: Colors.white, size: 35),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Accept",
                style: TextStyle(color: Colors.white70, fontSize: 16))
          ],
        ),
      ],
    );
  }

  Widget _buildEndCallButton() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _declineCall,
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call_end,
                  color: Colors.white, size: 38),
            ),
          ),
          const SizedBox(height: 12),
          const Text("End Call",
              style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }
}
