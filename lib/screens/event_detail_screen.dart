import 'package:flutter/material.dart';

// Detailed view of an event
// Optional callback for RSVP so HomeScreen can update past events
class EventDetailScreen extends StatelessWidget {
  final Map<String, String> event;
  final VoidCallback? onRSVP;

  EventDetailScreen({required this.event, this.onRSVP});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(event['title']!),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (event['image'] != null && event['image']!.isNotEmpty)
              Image.network(
                event['image']!,
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title']!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    event['date'] ?? '',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This is a detailed description of the event. Add more info like speakers, location, timing.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Trigger RSVP callback from HomeScreen and go back
                        if (onRSVP != null) onRSVP!();
                        Navigator.pop(context);
                      },
                      child: Text('RSVP'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
