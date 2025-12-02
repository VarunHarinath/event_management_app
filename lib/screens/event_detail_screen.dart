import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final Map<String, String> event;
  EventDetailScreen({required this.event});

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
          elevation: 4,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    event['date']!,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This is a detailed description of the event. You can add more information here about speakers, location, timing, and other relevant details.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
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
