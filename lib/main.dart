import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab1_flutter_dart_basics/pages/likes_page.dart';
import 'package:provider/provider.dart';
import './models/twits.dart';
import './pages/main_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Twits(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Twits>(context, listen: false).update();
    return MaterialApp(
      title: 'Twitter clone',
      theme: ThemeData(
        brightness: Brightness.dark,

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.white12,
          ).copyWith(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.white10,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  int _totalLikeCount = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void incrementTotalLikeCount() {
    setState(() {
      _totalLikeCount++;
    });
  }

  List get indexToPageMap => [
    MainPage(incrementLikeCounter: incrementTotalLikeCount),
    Text('Not implemented'),
    LikesPage(
        totalLikeClicks: _totalLikeCount,
        onClick: incrementTotalLikeCount
    ),
    Text('Not implemented'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: SvgPicture.asset(
          'resources/images/Twitter_bird_logo.svg',
          semanticsLabel: 'Twitter Logo',
          fit: BoxFit.contain,
        ),
        title: Text(
          'Twitter',
          style: TextStyle(
              fontFamily: 'YouTubeSans',
              fontWeight: FontWeight.w700,
              color: Colors.blue,
              fontSize: 32,
              letterSpacing: -2),
        ),
        titleSpacing: -3,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('In development')));
            },
          ),
          IconButton(
            onPressed: _openEndDrawer,
            icon: CircleAvatar(
              radius: 20,
              backgroundImage:
              AssetImage('resources/images/default-avatar.png'),
            ),
          )
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.white),
            activeIcon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined, color: Colors.white),
            activeIcon: Icon(Icons.search,color: Colors.white),
            label: 'Actual',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined, color: Colors.white),
            activeIcon: Icon(Icons.notifications,color: Colors.white),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline, color: Colors.white),
            activeIcon: Icon(Icons.mail, color: Colors.white),
            label: 'Message',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('My Account'),
            ),
            ListTile(
              title: const Text('My Profile'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('In development')));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings and configurations...'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('In development')));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
      body: indexToPageMap.elementAt(_selectedIndex),
    );
  }
}
