import 'package:flutter/material.dart';
// Provider te AuthService de import hata ditte ne
// import 'package:provider/provider.dart';
// import 'package:aura/services/auth_service.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer widget hata ditta hai, hun eh sidha chalega

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: const Color(0xFFF4F6FA),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFF4F6FA),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Profile Photo te Naam wala Section ---
          Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade300,
                // Nakli (dummy) photo la ditti hai
                backgroundImage: const NetworkImage('https://www.gravatar.com/avatar/?d=mp'),
              ),
              const SizedBox(height: 16),
              Text(
                'AURA User', // Nakli (dummy) naam
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'user@aura.com', // Nakli (dummy) email
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),

          // --- Zaroori Jaankari wala Section ---
          _buildInfoTile(
            icon: Icons.height,
            label: 'Height',
            value: '175 cm',
          ),
          _buildInfoTile(
            icon: Icons.monitor_weight_outlined,
            label: 'Weight',
            value: '72 kg',
          ),
          _buildInfoTile(
            icon: Icons.cake_outlined,
            label: 'Date of Birth',
            value: 'Jan 1, 1995',
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 10),

          // --- "Edit Profile" Button ---
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Hun eh button kuch nahi karega
              },
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({required IconData icon, required String label, required String value}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade600),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Text(
        value,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }
}