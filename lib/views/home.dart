import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spendy/views/transactions.dart';
import 'package:spendy/views/add.dart';
import 'package:spendy/views/settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          TransactionsScreen(),
          AddTransactionScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent, // Отключаем эффект всплеска
            highlightColor: Colors.transparent, // Отключаем эффект подсветки
          ),
          child: BottomNavigationBar(
            currentIndex: _tabController.index,
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            enableFeedback: false, // Убираем вибрацию
            selectedFontSize: 14,
            unselectedFontSize: 12,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            items: [
              _buildNavItem(CupertinoIcons.list_bullet, "Transactions", 0),
              _buildNavItem(CupertinoIcons.plus_circle_fill, "Add", 1),
              _buildNavItem(CupertinoIcons.gear, "Settings", 2),
            ],
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    bool isSelected = _tabController.index == index;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(
                  (0.2 * 255).toInt(), 63, 81, 181) // Пример цвета indigo[400]
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: isSelected ? 28 : 24),
      ),
      label: label,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
