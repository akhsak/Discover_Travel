import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/controller/bottom.dart';

class AdminBottomBar extends StatelessWidget {
  const AdminBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 240, 242),
      body: Consumer<BottomProvider>(
        builder: (context, value, child) =>
            value.adminScreens[value.adminCurrentIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(Icons.home, 'ᴴᵒᵐᵉ', 0, context),
            _BottomNavItem(Icons.add, 'ᴬᵈᵈᵖᵃᵍᵉ', 1, context),
            //  _BottomNavItem(Icons.person, 'Profile', 2, context),
          ],
        ),
      ),
    );
  }

  Widget _BottomNavItem(
      IconData icon, String label, int index, BuildContext context) {
    final bottomProvider = Provider.of<BottomProvider>(context);
    final isSelected = bottomProvider.adminCurrentIndex == index;
    final color = isSelected ? Colors.blue : Colors.black;

    return GestureDetector(
      onTap: () => bottomProvider.adminOnTap(index),
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
