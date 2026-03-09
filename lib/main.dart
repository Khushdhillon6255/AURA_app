import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// --- IMPORTS ---
import 'firebase_options.dart';
import 'screens/login_screen.dart'; // Correct Import
import 'screens/home_content.dart';
import 'screens/stats_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aura App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xff12122c),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const MainScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const StatsScreen(),
    const NotificationsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _getSelectedColor(int index) {
    switch (index) {
      case 0: return Colors.yellowAccent;
      case 1: return Colors.lightBlueAccent;
      case 2: return Colors.lightGreenAccent;
      case 3: return Colors.pinkAccent;
      default: return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff12122c),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: const Color(0xff12122c),
            textTheme: Theme.of(context).textTheme.copyWith(
                bodySmall: TextStyle(color: _getSelectedColor(_selectedIndex))
            )
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          backgroundColor: const Color(0xff12122c).withOpacity(0.9),
          selectedItemColor: _getSelectedColor(_selectedIndex),
          unselectedItemColor: Colors.white38,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          elevation: 10,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home, color: _getSelectedColor(0)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart, color: _getSelectedColor(1)),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications_none_outlined),
              activeIcon: Icon(Icons.notifications, color: _getSelectedColor(2)),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings, color: _getSelectedColor(3)),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}