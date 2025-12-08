import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/past_events_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/account_screen.dart';

void main() => runApp(EventManagementApp());

// Entry point for the app. Wraps everything inside MaterialApp and sets the theme.
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
      ),
      home: BottomNavScreen(), // Main bottom navigation screen
    );
  }
}

// Handles the bottom navigation and switching between main sections
class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  // Shared list of past events; accessible to both Home and Past Events screens
  final List<Map<String, String>> pastEvents = [];

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Initialize all screens once with the shared pastEvents list
    _screens = [
      HomeScreen(pastEvents: pastEvents),
      PastEventsScreen(pastEvents: pastEvents),
      ExploreScreen(),
      AccountScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Show current screen
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
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
