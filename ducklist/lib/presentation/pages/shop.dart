import 'package:flutter/material.dart';
import '../widgets/shop/shop_preview.dart';
import '../widgets/shop/accessory_grid.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLight ? const Color(0xFFFFFBF0) : const Color(0xFF121212),
      appBar: AppBar(
        title: Text("Hello, Friend!", 
          style: TextStyle(color: isLight ? Colors.brown : Colors.white, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isLight ? Colors.brown : Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShopPreview(),
            const SizedBox(height: 20),
            Text("Accessories", 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: isLight ? Colors.black : Colors.white
              )
            ),
            const SizedBox(height: 15),
            const AccessoryGrid(),
          ],
        ),
      ),
    );
  }
}