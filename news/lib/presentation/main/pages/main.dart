import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/common/widgets/appbar/basic_appbar.dart';
import 'package:news/common/widgets/bottombar/basic_bottombar.dart';
import 'package:news/presentation/bookmark/pages/bookmark.dart';
import 'package:news/presentation/explore/pages/explore_page.dart';
import 'package:news/presentation/home/pages/home_page.dart';
import 'package:news/presentation/setupUserProfile/pages/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  int _currentIndex = 0;
  Widget _buildPage(int index) {
    switch (index) {
      case 0: return HomePage();
      case 1: return ExplorePage();
      case 2: return BookmarkPage();
      case 3: return ProfilePage();
      default: return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BasicBottombar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      body: _buildPage(_currentIndex),
    );
  }

}
