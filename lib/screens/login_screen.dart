// screens/login_screen.dart

import 'package:flutter/material.dart';

// Eh line sab ton jaruri hai. Is naal 'LoginScreen' ek asli Widget banegi.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Tuhada login screen da saara design is Scaffold de andar banega
    return Scaffold(
      backgroundColor: const Color(0xff12122c),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'AURA Security',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Ethe tusi email, password te login button da code paoge
            ElevatedButton(
              onPressed: () {
                // Login da function ethe likhna hai
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}