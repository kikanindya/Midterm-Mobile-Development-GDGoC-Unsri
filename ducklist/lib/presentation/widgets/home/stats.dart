import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({super.key});

  Future<void> _saveCoins(int coins) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('coins', coins);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        int doneCount = 0;
        int remainingCount = 0;

        if (snapshot.hasData) {
          for (var doc in snapshot.data!.docs) {
            var data = doc.data() as Map<String, dynamic>;
            if (data['isCompleted'] == true) {
              doneCount++;
            } else {
              remainingCount++;
            }
          }
          
          _saveCoins(doneCount * 10);
        }

        return Row(
          children: [
            Expanded(
              child: _StatCard(
                title: "Done",
                value: "$doneCount",
                icon: Icons.check_circle_outline,
                color: const Color(0xFFD4EDDA),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                title: "Remaining",
                value: "$remainingCount",
                icon: Icons.schedule,
                color: const Color(0xFFFFCC80),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                title: "Coins",
                value: "${doneCount * 10}",
                icon: Icons.monetization_on,
                color: const Color(0xFFFFF3CD),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}