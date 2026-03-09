import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Activity Stats',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Cards
              Row(
                children: [
                  _buildStatCard(
                    context,
                    icon: Icons.directions_walk,
                    value: '8,530',
                    label: 'Steps',
                    color: Colors.orange.shade700,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    context,
                    icon: Icons.local_fire_department,
                    value: '350',
                    label: 'Kcal',
                    color: Colors.red.shade600,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatCard(
                    context,
                    icon: Icons.timeline,
                    value: '6.2 km',
                    label: 'Distance',
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    context,
                    icon: Icons.favorite,
                    value: '72 bpm',
                    label: 'Heart Rate',
                    color: Colors.pink.shade500,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Weekly Activity Chart
              const Text(
                'Weekly Steps',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBar('M', 0.6), // Monday 60%
                        _buildBar('T', 0.8), // Tuesday 80%
                        _buildBar('W', 0.5), // Wednesday 50%
                        _buildBar('T', 0.7), // Thursday 70%
                        _buildBar('F', 0.9), // Friday 90%
                        _buildBar('S', 0.4), // Saturday 40%
                        _buildBar('S', 0.75), // Sunday 75%
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for creating a stat card
  Widget _buildStatCard(BuildContext context, {required IconData icon, required String value, required String label, required Color color}) {
    return Expanded(
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for creating a bar in the chart
  Widget _buildBar(String day, double percentage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 100 * percentage, // Bar di height
          width: 20,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}