import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

class PastEventsScreen extends StatelessWidget {
  final List<Map<String, String>> pastEvents = [
    {
      "title": "Past Flutter Workshop",
      "date": "Nov 10, 2025",
      "image":
          "https://placehold.co/400x400.png?text=Past+Flutter+Workshop&bg=bb86fc&fg=000000",
    },
    {
      "title": "Past AI Conference",
      "date": "Nov 15, 2025",
      "image":
          "https://placehold.co/400x400.png?text=Past+AI+Conference&bg=03dac5&fg=000000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Past Events'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 4,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: pastEvents.length,
          itemBuilder: (context, index) {
            final event = pastEvents[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EventDetailScreen(event: event),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: Image.network(
                    event['image']!,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    event['title']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(event['date']!),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
