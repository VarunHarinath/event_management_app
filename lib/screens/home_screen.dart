import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> events = [
    {
      "title": "Flutter Workshop",
      "date": "Dec 10, 2025",
      "time": "10:00 AM - 4:00 PM",
      "location": "Online - Zoom",
      "organizer": "Flutter Devs",
      "description": "Hands-on workshop to learn Flutter and build apps.",
      "image": "",
    },
  ];

  void addEvent(Map<String, String> newEvent) {
    setState(() {
      events.add(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Upcoming Events'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newEvent = await showDialog<Map<String, String>>(
            context: context,
            builder: (_) => EventFormDialog(),
          );
          if (newEvent != null) addEvent(newEvent);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
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
                margin: EdgeInsets.only(bottom: 24),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: event['image']!.isNotEmpty
                          ? Image.network(
                              event['image']!,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(height: 180, color: Colors.grey.shade300),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event['title']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${event['date']} | ${event['time']!}",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            event['location']!,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            event['organizer']!,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 12),
                          Text(
                            event['description']!,
                            style: TextStyle(fontSize: 14),
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
    );
  }
}

// Event form dialog
class EventFormDialog extends StatefulWidget {
  @override
  _EventFormDialogState createState() => _EventFormDialogState();
}

class _EventFormDialogState extends State<EventFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> eventData = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Publish Event'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (val) => eventData['title'] = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date'),
                onSaved: (val) => eventData['date'] = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Time'),
                onSaved: (val) => eventData['time'] = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                onSaved: (val) => eventData['location'] = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Organizer'),
                onSaved: (val) => eventData['organizer'] = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (val) => eventData['description'] = val ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                onSaved: (val) => eventData['image'] = val ?? '',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _formKey.currentState!.save();
            Navigator.pop(context, eventData);
          },
          child: Text('Publish'),
        ),
      ],
    );
  }
}
