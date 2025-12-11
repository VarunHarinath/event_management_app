import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

/// Screen to display both registered and past events
class PastEventsScreen extends StatelessWidget {
  // List of past events
  final List<Map<String, String>> pastEvents;

  // List of events the user has registered for
  final List<Map<String, String>> registeredEvents;

  /// Constructor allows passing both lists of events.
  /// registeredEvents is optional and defaults to empty list.
  const PastEventsScreen({
    required this.pastEvents,
    this.registeredEvents = const [],
    Key? key,
  }) : super(key: key);

  // ================= Helper to build a single event card =================
  Widget buildEventCard(BuildContext context, Map<String, String> event) {
    final title = event['title'] ?? 'No Title'; // Fallback title
    final date = event['date'] ?? 'No Date'; // Fallback date
    final image = event['image'] ?? ''; // Fallback image URL

    return GestureDetector(
      // Tap event navigates to event details page
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventDetailScreen(event: event)),
        );
      },
      child: Card(
        // Card UI styling
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        shadowColor: Colors.deepPurpleAccent.withOpacity(0.3),
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show image if available
            if (image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            // Event title and date
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= Helper to build a section (Registered or Past) =================
  Widget buildEventSection(
    BuildContext context,
    String title,
    List<Map<String, String>> events,
  ) {
    if (events.isEmpty) return SizedBox.shrink(); // Return empty if no events

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
          ),
          SizedBox(height: 12),
          // List of events inside this section
          ListView.builder(
            shrinkWrap: true, // Needed to embed ListView in Column
            physics:
                NeverScrollableScrollPhysics(), // Disable scrolling inside this ListView
            itemCount: events.length,
            itemBuilder: (context, index) =>
                buildEventCard(context, events[index]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ================= App Bar =================
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('My Events'),
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
      // ================= Body =================
      body: SingleChildScrollView(
        // Scrollable body to prevent overflow
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Show registered events section
            buildEventSection(context, 'Registered Events', registeredEvents),
            // Show past events section
            buildEventSection(context, 'Past Events', pastEvents),
          ],
        ),
      ),
    );
  }
}
