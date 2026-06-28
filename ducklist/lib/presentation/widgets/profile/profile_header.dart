import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        double progress = 0.0;
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          int total = snapshot.data!.docs.length;
          int done = snapshot.data!.docs
              .where((doc) => (doc.data() as Map<String, dynamic>)['isCompleted'] == true)
              .length;
          progress = done / total;
        }

        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Lvl 8",
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text("Alex", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("Mastering the art of focus", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            // Bar yang disamakan dengan Waddle Meter
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress, // Sekarang dinamis mengikuti tugas
                minHeight: 12,
                backgroundColor: const Color(0xFFE0E0E0),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          ],
        );
      },
    );
  }
}