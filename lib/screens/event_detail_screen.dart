import 'package:flutter/material.dart';
import 'rsvp_form_dialog.dart';

class EventDetailScreen extends StatelessWidget {
  final Map<String, String> event;
  final VoidCallback? onRSVP;

  const EventDetailScreen({required this.event, this.onRSVP, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = event['title'] ?? 'No Title';
    final date = event['date'] ?? 'No Date';
    final time = event['time'] ?? '';
    final location = event['location'] ?? 'No Location';
    final organizer = event['organizer'] ?? 'No Organizer';
    final description = event['description'] ?? '';
    final image = event['image'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  "$date | $time",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(location, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(organizer, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            SizedBox(height: 16),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed:
                    onRSVP ??
                    () async {
                      final rsvp = await showDialog<Map<String, String>>(
                        context: context,
                        builder: (_) => RSVPFormDialog(event: event),
                      );
                      if (rsvp != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('RSVP submitted successfully!'),
                          ),
                        );
                      }
                    },
                child: Text('RSVP'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.deepPurpleAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
