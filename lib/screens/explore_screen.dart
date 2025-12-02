import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<Map<String, String>> allEvents = [
    {
      "title": "Workshops",
      "date": "Where you find other creatord",
      "image":
          "https://placehold.co/400x400.png?text=Flutter+Workshop&bg=6200ee&fg=ffffff",
    },
    {
      "title": "Conferences",
      "date": "This is where you present your paper (Research)",
      "image":
          "https://placehold.co/400x400.png?text=AI+Conference&bg=03dac5&fg=000000",
    },
    {
      "title": "Hackathons",
      "date": "Unleash Your self",
      "image":
          "https://placehold.co/400x400.png?text=Music+Fest&bg=ff0266&fg=ffffff",
    },
    {
      "title": "Tech Meetups",
      "date": "I love this part",
      "image":
          "https://placehold.co/400x400.png?text=Tech+Meetup&bg=ffab00&fg=000000",
    },
  ];

  String query = "";

  @override
  Widget build(BuildContext context) {
    final filteredEvents = allEvents
        .where((e) => e['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
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
          elevation: 4,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search events...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
            ),
            SizedBox(height: 16),

            Expanded(
              child: GridView.builder(
                itemCount: filteredEvents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];

                  final gradientColors = [
                    [Colors.pink.shade400, Colors.pink.shade200],
                    [Colors.deepPurple.shade400, Colors.deepPurple.shade200],
                    [Colors.teal.shade400, Colors.teal.shade200],
                    [Colors.orange.shade400, Colors.orange.shade200],
                  ];

                  final colors = gradientColors[index % gradientColors.length];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventDetailScreen(event: event),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              event['date']!,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
