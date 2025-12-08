import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

class PastEventsScreen extends StatelessWidget {
  final List<Map<String, String>> pastEvents;

  const PastEventsScreen({required this.pastEvents, Key? key})
    : super(key: key);

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
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: pastEvents.length,
          itemBuilder: (context, index) {
            final event = pastEvents[index];

            final title = event['title'] ?? 'No Title';
            final date = event['date'] ?? 'No Date';

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
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(date),
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
