import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math;
import 'fake_call_screen.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with TickerProviderStateMixin {
  late AnimationController _controller;
  String? _userName;
  String? _userPhoto;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  void _fetchUserData() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      // Je naam nahi hai taan "User" show hovega
      _userName = user?.displayName ?? "User";
      _userPhoto = user?.photoURL;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerSOS() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("SOS TRIGGERED! Sending Alerts..."), backgroundColor: Colors.red)
    );
  }

  void _featureNotImplemented(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$feature Coming Soon!"), backgroundColor: Colors.blue)
    );
  }

  void _startFakeCall() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Fake Call coming in 5 seconds... Lock your phone if needed."),
            backgroundColor: Colors.green
        )
    );

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FakeCallScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        behaviour: RacingLinesBehaviour(
          direction: LineDirection.Ltr,
          numLines: 20,
        ),
        vsync: this,
        child: Container(
          color: const Color(0xff12122c).withOpacity(0.95),
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER ROW START ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Greeting Text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Hello,", style: TextStyle(color: Colors.white70, fontSize: 16)),
                          Text(
                            _userName ?? "Guardian",
                            style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      // --- UPDATED PROFILE PICTURE LOGIC ---
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24, width: 2), // Outer white ring
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          // 1. BACKGROUND COLOR:
                          // Je photo hai taan transparent,
                          // Je photo nahi hai taan OrangeAccent (Taki Dark Blue background te dikhe)
                          backgroundColor: _userPhoto != null ? Colors.transparent : Colors.deepOrangeAccent,

                          // 2. IMAGE LOGIC:
                          backgroundImage: _userPhoto != null ? NetworkImage(_userPhoto!) : null,

                          // 3. TEXT FALLBACK LOGIC:
                          // Je photo nahi hai, taan Pehla Letter (Capital) dikhao
                          child: _userPhoto == null
                              ? Text(
                            // Naam da pehla letter chukko, je naam null hai ta 'U'
                            (_userName != null && _userName!.isNotEmpty)
                                ? _userName![0].toUpperCase()
                                : "U",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          )
                              : null,
                        ),
                      ),
                    ],
                  ),
                  // --- HEADER ROW END ---

                  const SizedBox(height: 30),

                  // SOS Button (Same as before)
                  Center(
                    child: GestureDetector(
                      onTap: _triggerSOS,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Ripple 1
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Container(
                                width: 100 + (_controller.value * 30),
                                height: 100 + (_controller.value * 30),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.withOpacity(0.3 - (_controller.value * 0.3)),
                                ),
                              );
                            },
                          ),
                          // Ripple 2 (Outer)
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Container(
                                width: 120 + (_controller.value * 40),
                                height: 120 + (_controller.value * 40),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.withOpacity(0.2 - (_controller.value * 0.2)),
                                ),
                              );
                            },
                          ),
                          // Main Button
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF4B4B), Color(0xFFFF0000)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(color: Colors.redAccent.withOpacity(0.6), blurRadius: 15, spreadRadius: 3)
                              ],
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.touch_app, size: 28, color: Colors.white),
                                  Text("SOS", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Center(child: Text("Tap for Emergency", style: TextStyle(color: Colors.white54))),

                  const SizedBox(height: 30),

                  const Text("Quick Actions", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.6,
                      children: [
                        FeatureCard(icon: Icons.call, label: "Fake Call", color: Colors.purpleAccent, onTap: _startFakeCall),
                        FeatureCard(icon: Icons.local_police, label: "Police", color: Colors.blueAccent, onTap: () => _featureNotImplemented("Police Locator")),
                        FeatureCard(icon: Icons.share_location, label: "Share Loc", color: Colors.orangeAccent, onTap: () => _featureNotImplemented("Live Location")),
                        FeatureCard(icon: Icons.record_voice_over, label: "Record", color: Colors.greenAccent, onTap: () => _featureNotImplemented("Audio Recording")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ... FeatureCard Class same rahegi ...
class FeatureCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isHovering = true),
        onTapUp: (_) => setState(() => _isHovering = false),
        onTapCancel: () => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: _isHovering
                ? LinearGradient(
              colors: [widget.color.withOpacity(0.6), widget.color.withOpacity(0.2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
            color: _isHovering ? null : Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovering ? widget.color : Colors.white.withOpacity(0.1),
              width: _isHovering ? 2 : 1,
            ),
            boxShadow: _isHovering
                ? [BoxShadow(color: widget.color.withOpacity(0.4), blurRadius: 15, spreadRadius: 1)]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, size: 28, color: widget.color),
              ),
              const SizedBox(height: 8),
              Text(
                  widget.label,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)
              ),
            ],
          ),
        ),
      ),
    );
  }
}