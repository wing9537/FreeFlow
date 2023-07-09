import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, this.currentIndex = 0});

  _onPageChange(index, context) {
    if (currentIndex != index) {
      Navigator.pushNamedAndRemoveUntil(context, Nav.path[index], (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => _onPageChange(index, context),
      items: const [
        BottomNavBarItem(icon: Icon(Icons.calendar_today_outlined)),
        BottomNavBarItem(icon: Icon(Icons.add_photo_alternate_outlined)),
        BottomNavBarItem(icon: Icon(Icons.photo_library_outlined)),
        BottomNavBarItem(icon: Icon(Icons.search_outlined)),
        BottomNavBarItem(icon: Icon(Icons.settings_outlined)),
      ],
    );
  }
}

class BottomNavBarItem extends BottomNavigationBarItem {
  const BottomNavBarItem({required super.icon, super.label = ""});
}
