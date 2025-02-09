import 'package:adhicine/pages/home_page.dart';
import 'package:adhicine/pages/add_medicine_page.dart';
import 'package:adhicine/pages/report_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllTabs extends StatefulWidget {
  const AllTabs({super.key});

  @override
  State<AllTabs> createState() => _AllTabsState();
}

class _AllTabsState extends State<AllTabs> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    ReportPage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddMedicineScreen()));
        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(CupertinoIcons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.house_fill,
                    color: _selectedIndex == 0
                        ? const Color.fromARGB(255, 69, 118, 230)
                        : Colors.grey),
                onPressed: () => _onTabSelected(0),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: Icon(CupertinoIcons.chart_bar_fill,
                    color: _selectedIndex == 1
                        ? Color.fromARGB(255, 69, 118, 230)
                        : Colors.grey),
                onPressed: () => _onTabSelected(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
