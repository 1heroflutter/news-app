import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicBottombar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BasicBottombar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BasicBottombar> createState() => _BasicBottombarState();
}

class _BasicBottombarState extends State<BasicBottombar> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      selectedItemColor: theme.primaryColor,
      unselectedIconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.explore_outlined,
          ),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark_border_outlined,
          ),
          label: "Bookmark",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_outlined,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
