import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/past_events_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/account_screen.dart';

void main() => runApp(EventManagementApp());

class EventManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amberAccent,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      home: BottomNavScreen(),
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(), // Upcoming Events
    PastEventsScreen(), // Past Events
    ExploreScreen(), // Explore/Search
    AccountScreen(), // Profile/Account
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Upcoming'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Past'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
