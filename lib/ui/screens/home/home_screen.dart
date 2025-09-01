import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/home/tabs/category_tab.dart';
import 'package:movies_app/ui/screens/home/tabs/home_tab.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/profile_tab.dart';
import 'package:movies_app/ui/screens/home/tabs/search_tab.dart';
import 'package:movies_app/ui/utils/app_assets.dart';
import 'package:movies_app/ui/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeTab(),
    SearchTab(),
    CategoryTab(),
    ProfileTab(),
  ];
  void _onScreenTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: _screens[_selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 34, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.darkGrey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _onScreenTab(0);
                },
                child: Image.asset(
                  AppAssets.homeIcon,
                  color: _selectedIndex == 0
                      ? AppColors.yellow
                      : AppColors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  _onScreenTab(1);
                },
                child: Image.asset(
                  AppAssets.searchIcon,
                  color: _selectedIndex == 1
                      ? AppColors.yellow
                      : AppColors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  _onScreenTab(2);
                },
                child: Image.asset(
                  AppAssets.categoryIcon,
                  color: _selectedIndex == 2
                      ? AppColors.yellow
                      : AppColors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  _onScreenTab(3);
                },
                child: Image.asset(
                  AppAssets.profile,
                  color: _selectedIndex == 3
                      ? AppColors.yellow
                      : AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
