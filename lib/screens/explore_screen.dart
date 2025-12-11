import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

/// Explore screen shows categorized events and allows searching
class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Sample categorized events data
  // Each category has a list of events with title, date, and optional image
  final Map<String, List<Map<String, String>>> categorizedEvents = {
    "Workshops": [
      {"title": "Flutter Basics", "date": "Dec 12, 2025", "image": ""},
      {"title": "AI in Practice", "date": "Dec 20, 2025", "image": ""},
    ],
    "Conferences": [
      {"title": "TechCon 2026", "date": "Jan 5, 2026", "image": ""},
      {"title": "Global Dev Meet", "date": "Jan 20, 2026", "image": ""},
    ],
    "Hackathons": [
      {"title": "24h Hackathon", "date": "Feb 20, 2026", "image": ""},
      {"title": "AI Challenge", "date": "Mar 2, 2026", "image": ""},
    ],
    "Tech Meetups": [
      {"title": "Flutter Meetup", "date": "Mar 10, 2026", "image": ""},
      {"title": "Open Source Community", "date": "Mar 15, 2026", "image": ""},
    ],
  };

  // Query string for search input
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with gradient background
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Explore Events'),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // ================= Search Field =================
            TextField(
              decoration: InputDecoration(
                hintText: 'Search events...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => query = val),
            ),
            SizedBox(height: 16),

            // ================= Event Categories =================
            Expanded(
              child: ListView(
                children: categorizedEvents.entries.map((entry) {
                  final category = entry.key; // e.g., "Workshops"
                  // Filter events based on search query
                  final events = entry.value
                      .where(
                        (e) => (e['title'] ?? '').toLowerCase().contains(
                          query.toLowerCase(),
                        ),
                      )
                      .toList();

                  if (events.isEmpty) return SizedBox.shrink(); // Skip empty

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category title
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Horizontal scrollable event cards
                      SizedBox(
                        height: 180,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: events.length,
                          separatorBuilder: (_, __) => SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final event = events[index];
                            final title = event['title'] ?? 'No Title';
                            final date = event['date'] ?? 'No Date';
                            final image = event['image'] ?? '';

                            return GestureDetector(
                              onTap: () {
                                // Navigate to event details
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EventDetailScreen(event: event),
                                  ),
                                );
                              },
                              child: Container(
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink.shade400,
                                      Colors.pink.shade200,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Event image or placeholder
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: image.isNotEmpty
                                          ? Image.network(
                                              image,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              height: 100,
                                              color: Colors.grey.shade300,
                                              child: Icon(
                                                Icons.event,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                    // Event title and date
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            date,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
