import 'package:flutter/material.dart';
import 'package:ducklist/main.dart'; 

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      decoration: BoxDecoration(color: isLight ? Colors.white : const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, mode, _) => SwitchListTile(
              title: const Text("Dark Mode"),
              secondary: const Icon(Icons.dark_mode_outlined),
              value: mode == ThemeMode.dark,
              onChanged: (val) => themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light,
            ),
          ),
          const Divider(height: 1),
          const ListTile(leading: Icon(Icons.person_outline), title: Text("Account Details"), trailing: Icon(Icons.chevron_right)),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text("Logout", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}