import 'package:flutter/material.dart';

// Import the main screens of the app
import 'screens/home_screen.dart';
import 'screens/past_events_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/account_screen.dart';

void main() => runApp(EventManagementApp());
// The main() function is the entry point of the Flutter app.
// runApp() takes a widget and makes it the root of the widget tree.
// Here, EventManagementApp is the root widget of our app.

/// The root widget of the Event Management App.
/// Uses MaterialApp to provide material design structure, theming, and routing.
class EventManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management', // App title
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(
        // Primary color for app bars, buttons, etc.
        primaryColor: Colors.deepPurpleAccent,
        // Secondary (accent) color for floating buttons, highlights, etc.
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amberAccent,
        ),
      ),
      home: BottomNavScreen(), // Starting screen with bottom navigation
    );
  }
}

/// Main screen with bottom navigation bar to switch between main sections
class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0; // Tracks which tab is currently selected

  // Shared list to store past events
  // This list is passed to both HomeScreen and PastEventsScreen to keep data in sync
  final List<Map<String, String>> pastEvents = [];

  // List of all main screens for bottom navigation
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    // Initialize all screens once and pass the shared pastEvents list where needed
    _screens = [
      HomeScreen(pastEvents: pastEvents), // Upcoming events / home page
      PastEventsScreen(pastEvents: pastEvents), // Past events page
      ExploreScreen(), // Explore events page
      AccountScreen(), // User account/profile page
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Shows the current selected screen
      body: _screens[_currentIndex],

      // Bottom navigation bar to switch between sections
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlights the selected item
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Keeps all items visible
        showUnselectedLabels: true, // Show labels for all items
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Upcoming'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Past'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
        // When a tab is tapped, update the current index and rebuild UI
      ),
    );
  }
}
