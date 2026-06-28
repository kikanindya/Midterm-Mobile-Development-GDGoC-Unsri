import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessoryGrid extends StatefulWidget {
  const AccessoryGrid({super.key});

  @override
  State<AccessoryGrid> createState() => _AccessoryGridState();
}

class _AccessoryGridState extends State<AccessoryGrid> {
  final List<Map<String, dynamic>> items = const [
    {"id": "hasTree", "name": "Oak Tree", "price": 100, "icon": Icons.park},
    {"id": "hasLotus", "name": "Lotus Flower", "price": 50, "icon": Icons.local_florist},
    {"id": "hasHouse", "name": "Duck House", "price": 200, "icon": Icons.house},
  ];

  int coins = 1000;
  Map<String, bool> inventory = {"hasTree": false, "hasLotus": false, "hasHouse": false};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      coins = prefs.getInt('coins') ?? 1000;
      for (var item in items) {
        inventory[item['id']] = prefs.getBool(item['id']) ?? false;
      }
    });
  }

  Future<void> _buyItem(String id, int price) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      coins -= price;
      inventory[id] = true;
    });
    await prefs.setInt('coins', coins);
    await prefs.setBool(id, true);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 15, mainAxisSpacing: 15,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        bool isOwned = inventory[items[i]['id']] ?? false;
        int price = items[i]['price'] as int;

        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(items[i]['icon'], size: 50, color: isOwned ? Colors.green : Colors.brown),
              Text(items[i]['name']),
              Text(isOwned ? "OWNED" : "$price Coins"),
              ElevatedButton(
                onPressed: (isOwned || coins < price) ? null : () => _buyItem(items[i]['id'], price),
                child: Text(isOwned ? "Purchased" : "Buy"),
              ),
            ],
          ),
        );
      },
    );
  }
}