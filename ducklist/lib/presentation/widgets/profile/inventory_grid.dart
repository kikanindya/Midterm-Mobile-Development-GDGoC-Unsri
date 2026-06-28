import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventoryGrid extends StatefulWidget {
  const InventoryGrid({super.key});

  @override
  State<InventoryGrid> createState() => _InventoryGridState();
}

class _InventoryGridState extends State<InventoryGrid> {
  final List<Map<String, dynamic>> items = [
    {"id": "hasTree", "icon": Icons.park},
    {"id": "hasLotus", "icon": Icons.local_florist},
    {"id": "hasHouse", "icon": Icons.house},
  ];

  Map<String, bool> inventory = {"hasTree": false, "hasLotus": false, "hasHouse": false};

  @override
  void initState() {
    super.initState();
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var item in items) {
        inventory[item['id']] = prefs.getBool(item['id']) ?? false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadInventory(); 
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Inventory", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, 
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, i) {
            bool isOwned = inventory[items[i]['id']] ?? false;
            
            return Container(
              decoration: BoxDecoration(
                color: isLight ? Colors.white : const Color(0xFF1E1E1E), 
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                isOwned ? items[i]['icon'] : Icons.lock_outline, 
                size: 30, 
                color: isOwned ? (isLight ? Colors.brown : Colors.greenAccent) : Colors.grey,
              ),
            );
          },
        ),
      ],
    );
  }
}