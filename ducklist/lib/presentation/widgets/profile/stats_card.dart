import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, taskSnapshot) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('focus_sessions').snapshots(),
          builder: (context, focusSnapshot) {
            
            int completedTasks = 0;
            if (taskSnapshot.hasData) {
              completedTasks = taskSnapshot.data!.docs
                  .where((doc) => (doc.data() as Map<String, dynamic>)['isCompleted'] == true)
                  .length;
            }

            // Hitung sesi fokus
            int totalSessions = focusSnapshot.hasData ? focusSnapshot.data!.docs.length : 0;

            return Row(
              children: [
                Expanded(
                  child: _StatItem(
                    icon: Icons.check_circle_outline, 
                    label: "$completedTasks", 
                    sub: "Tasks"
                  )
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _StatItem(
                    icon: Icons.timer_outlined, 
                    label: "$totalSessions", 
                    sub: "Sessions"
                  )
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label, sub;
  const _StatItem({required this.icon, required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(sub, style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}