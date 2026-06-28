import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/home/task_item.dart';
import '../widgets/app_header.dart';
import '../widgets/home/stats.dart';
import '../widgets/home/duck.dart';
import '../widgets/home/focus_mode.dart';
import '../widgets/home/talk.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showTaskDetail(BuildContext context, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(data['title'] ?? 'No Title'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deskripsi: ${data['description'] ?? 'Tidak ada'}"),
            const SizedBox(height: 10),
            Text("Kategori: ${data['category'] ?? '-'}"),
            Text("Status: ${data['isCompleted'] == true ? 'Selesai' : 'Belum Selesai'}"),
            Text("Prioritas: ${data['priority'] ?? 'Medium'}"),
            Text("Deadline: ${data['date'] ?? 'Tidak ada'}"),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Tutup")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // HAPUS Scaffold dari sini agar tidak menabrak BottomNav di MainPage
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(),
            const DailyPepTalk(),
            const HomeStats(),
            const HomeDuck(),
            const Text("Today's Journey", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const HomeFocusMode(),
            
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                
                var docs = snapshot.data!.docs.toList();
                
                docs.sort((a, b) {
                  bool aDone = (a.data() as Map<String, dynamic>)['isCompleted'] ?? false;
                  bool bDone = (b.data() as Map<String, dynamic>)['isCompleted'] ?? false;
                  if (aDone == bDone) return 0;
                  return aDone ? 1 : -1;
                });

                return Column(
                  children: docs.map((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    bool isDone = data['isCompleted'] ?? false;

                    return Opacity(
                      opacity: isDone ? 0.5 : 1.0,
                      child: HomeTaskItem(
                        key: ValueKey(doc.id),
                        title: data['title'] ?? 'No Title',
                        detail: "${data['category']} | ${data['time'] ?? ''}",
                        icon: Icons.task_alt,
                        isCompleted: isDone,
                        priority: data['priority'] ?? 'Medium',
                        onToggle: () => doc.reference.update({'isCompleted': !isDone}),
                        onDelete: () => doc.reference.delete(),
                        onTap: () => _showTaskDetail(context, data),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 100), // Memberi ruang agar konten tidak tertutup navigasi
          ],
        ),
      ),
    );
  }
}