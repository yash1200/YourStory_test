import 'package:flutter/material.dart';
import 'package:intern_test/provider/AppProvider.dart';
import 'package:intern_test/ui/page1.dart';
import 'package:intern_test/ui/page2.dart';
import 'package:intern_test/ui/page3.dart';
import 'package:intern_test/ui/page4.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = [
    [Page1(), "Page 1", GlobalKey<NavigatorState>()],
    [Page2(), "Page 2", GlobalKey<NavigatorState>()],
    [Page3(), "Page 3", GlobalKey<NavigatorState>()],
    [Page4(), "Page 4", GlobalKey<NavigatorState>()],
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.navIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          provider.navIndex = index;
        },
        items: [
          for (var page in pages)
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              label: page[1],
            )
        ],
      ),
      body: Stack(
        children: [
          for (var page in pages)
            Offstage(
              offstage: page != pages[provider.navIndex],
              child: Navigator(
                key: page[2],
                initialRoute: '/',
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => page[0],
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
