import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab1_flutter_dart_basics/pages/message_page.dart';
import 'package:lab1_flutter_dart_basics/pages/likes_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkTheme = true;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
      SharedPreferences.getInstance().then((sp) {
        sp.setBool('isDarkTheme', isDarkTheme);
      });
    });
  }

  _MyAppState() {
    SharedPreferences.getInstance().then((sp) {
      setState(() {
        isDarkTheme = sp.getBool('isDarkTheme') ?? true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Twits>(context, listen: false).update();
    return MaterialApp(
      title: 'Twitter clone',
      routes: {
        '/': (context) => App(toggleTheme: toggleTheme),
      },
      theme: ThemeData(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,

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
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

class App extends StatefulWidget {
  final Function toggleTheme;

  const App({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState(toggleTheme);
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  int _totalLikeCount = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Function toggleTheme;
  _AppState(this.toggleTheme);

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
        onClick: incrementTotalLikeCount),
    LibraryPage(),
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
              title: const Text('Change Theme'),
              onTap: () {
                toggleTheme();
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
