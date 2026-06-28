import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPreview extends StatefulWidget {
  const ShopPreview({super.key});

  @override
  State<ShopPreview> createState() => _ShopPreviewState();
}

class _ShopPreviewState extends State<ShopPreview> {
  int coins = 0;
  Map<String, bool> ownedItems = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      coins = prefs.getInt('coins') ?? 0;
      ownedItems = {
        "hasTree": prefs.getBool('hasTree') ?? false,
        "hasLotus": prefs.getBool('hasLotus') ?? false,
        "hasHouse": prefs.getBool('hasHouse') ?? false,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(); // Update data setiap build

    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Stack(
            children: [
              if (ownedItems["hasTree"]!) const Positioned(top: 20, left: 20, child: Icon(Icons.park, size: 50, color: Colors.green)),
              if (ownedItems["hasLotus"]!) const Positioned(bottom: 20, right: 20, child: Icon(Icons.local_florist, size: 50, color: Colors.pink)),
              if (ownedItems["hasHouse"]!) const Positioned(bottom: 20, left: 40, child: Icon(Icons.house, size: 70, color: Colors.brown)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text("💰 $coins", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }
}