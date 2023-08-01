import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/setting');
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("location=${GoRouterState.of(context).location}");
    }
    if (GoRouterState.of(context).location.contains("/home")) {
      _selectedIndex = 0;
    } else if (GoRouterState.of(context).location.contains("/setting")) {
      _selectedIndex = 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
      ),
      body: SafeArea(child: widget.child),
      bottomNavigationBar: SizedBox(
        height: 58,
        child: BottomNavigationBar(
          //selectedItemColor: KColor.PRIMARY_COLOR,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (int idx) => _onItemTapped(idx, context),
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}
