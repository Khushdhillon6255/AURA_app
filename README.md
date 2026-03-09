🛡️ AURA - Personal Safety & Security App

AURA is a modern, feature-rich personal safety application built with Flutter and Firebase. It is designed to provide quick access to emergency features like SOS alerts, fake incoming calls, and secure location sharing.

✨ Key Features

Secure Authentication: Login and Sign-up system powered by Firebase Auth.

Email OTP Verification: Secure account creation using Email OTP verification (email_otp / EmailJS).

Interactive UI:

Dark mode themed UI with glowing effects.

Animated "Monkey Emoji" 🐵/🙈 that tracks the password field.

Custom Animated Bottom Navigation Bar.

Emergency SOS: A large, glowing SOS button with ripple animations to quickly trigger alerts.

Fake Call Generator: Simulates a realistic incoming call (with ringtone and vibration) to help users escape uncomfortable situations. Includes Accept/Decline actions and an active call timer.

Quick Actions: Grid-based quick action cards with hover and tap animations (Fake Call, Police, Share Location, Record).

🛠️ Tech Stack & Packages

Framework: Flutter (Dart)

Backend / Auth: Firebase Authentication, Firebase Core

State Management: setState (Flutter Native)

Notable Plugins:

firebase_auth & firebase_core: For user authentication.

pinput: For the sleek OTP input boxes.

email_otp: For sending verification codes.

animated_background: For the racing lines background effect on the Home Screen.

flutter_ringtone_player & vibration: For the Fake Call feature.

🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

Prerequisites

Flutter SDK (v3.0.0 or higher)

Dart SDK

Android Studio / VS Code

Active Firebase Project (You need to configure firebase_options.dart and add google-services.json).

Installation

Clone the repository:

git clone [https://github.com/yourusername/aura-app.git](https://github.com/yourusername/aura-app.git)
cd aura-app


Install dependencies:

flutter pub get


Firebase Setup:

Make sure your project is connected to Firebase.

For Android, place your google-services.json file in android/app/.

For Windows/Web, ensure firebase_options.dart is correctly configured via FlutterFire CLI.

Run the App:
To run the app on a connected mobile device or emulator:

flutter run


To run specifically on Windows (Desktop):

flutter run -d windows


🧹 Troubleshooting Commands

If you face any build errors (like Gradle mismatches or old cache issues), run these commands to clean the project:

flutter clean
flutter pub get
cd android
./gradlew clean   # Use 'gradlew clean' on Windows cmd/powershell
cd ..
flutter run


📱 Project Structure

lib/
┣ screens/
┃ ┣ login_screen.dart        # Login, Signup, OTP Verification & Monkey Animation
┃ ┣ home_content.dart        # SOS Button, Profile, Quick Action Grid
┃ ┣ fake_call_screen.dart    # Fake Incoming Call UI & Logic
┃ ┣ stats_screen.dart        # Statistics (Placeholder)
┃ ┣ notifications_screen.dart# Alerts (Placeholder)
┃ ┗ settings_screen.dart     # App Settings (Placeholder)
┣ firebase_options.dart      # Auto-generated Firebase config
┗ main.dart                  # App Entry Point & Custom Bottom Navigation Bar


🎨 UI Preview

(You can add screenshots of your app here by placing images in an assets/ folder and linking them like ![Home Screen](assets/home.png))

Developed with ❤️ using Flutter