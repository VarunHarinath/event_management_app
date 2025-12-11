import 'package:flutter/material.dart';
import 'rsvp_form_dialog.dart';

/// Screen that shows detailed information about a single event.
/// Includes title, date, time, location, organizer, description, and an RSVP button.
class EventDetailScreen extends StatelessWidget {
  // Event data passed from the previous screen
  final Map<String, String> event;

  // Optional callback for RSVP action
  final VoidCallback? onRSVP;

  // Constructor requires event; onRSVP is optional
  const EventDetailScreen({required this.event, this.onRSVP, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract data from event map, provide defaults if missing
    final title = event['title'] ?? 'No Title';
    final date = event['date'] ?? 'No Date';
    final time = event['time'] ?? '';
    final location = event['location'] ?? 'No Location';
    final organizer = event['organizer'] ?? 'No Organizer';
    final description = event['description'] ?? '';
    final image = event['image'] ?? '';

    return Scaffold(
      // AppBar with gradient background
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
            // Show event image if available
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

            // Event title
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(height: 12),

            // Event date and time
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

            // Event location
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(location, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            SizedBox(height: 8),

            // Event organizer
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(organizer, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            SizedBox(height: 16),

            // Event description
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),

            // ================= RSVP Button =================
            Center(
              child: ElevatedButton(
                onPressed:
                    onRSVP ??
                    () async {
                      // Default RSVP behavior if no callback is provided
                      final rsvp = await showDialog<Map<String, String>>(
                        context: context,
                        builder: (_) => RSVPFormDialog(event: event),
                      );
                      if (rsvp != null) {
                        // Show confirmation if RSVP is submitted
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
