import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/bottom.dart';

class UserBottomScreen extends StatelessWidget {
  UserBottomScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomProvider>(
        builder: (context, value, child) => value.screens[value.currentIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(Icons.home, 'ᴴᵒᵐᵉ', 0, context),
            _BottomNavItem(Icons.favorite, 'ʷⁱˢʰˡⁱˢᵗ', 1, context),
            _BottomNavItem(Icons.notifications, 'ⁿᵒᵗⁱᶠⁱᶜᵃᵗⁱᵒⁿ', 2, context),
            _BottomNavItem(Icons.person, 'ᴾʳᵒᶠᶦˡᵉ', 3, context),
          ],
        ),
      ),
    );
  }

  Widget _BottomNavItem(
      IconData icon, String label, int index, BuildContext context) {
    final bottomProvider = Provider.of<BottomProvider>(context);
    final isSelected = bottomProvider.currentIndex == index;
    final color = isSelected ? Colors.blue : Colors.black;

    return GestureDetector(
      onTap: () => bottomProvider.onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
