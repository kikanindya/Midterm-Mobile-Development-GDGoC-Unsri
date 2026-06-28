import 'package:flutter/material.dart';
// Jika masih error, gunakan full path: import 'package:NAMA_PROJECT_KAMU/widgets/profile/...';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/stats_card.dart';
import '../widgets/profile/inventory_grid.dart';
import '../widgets/profile/settings_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Scaffold(
      backgroundColor: isLight ? const Color(0xFFFFFBF0) : const Color(0xFF121212),
      appBar: AppBar(
        title: Text("Profile", 
          style: TextStyle(
            color: isLight ? Colors.brown : Colors.white, 
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isLight ? Colors.brown : Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 25),
            const StatsCard(),
            const SizedBox(height: 25),
            const InventoryGrid(),
            const SizedBox(height: 25),
            const SettingsList(),
          ],
        ),
      ),
    );
  }
}