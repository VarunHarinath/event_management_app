import 'package:flutter/material.dart';
import 'event_detail_screen.dart';
import 'rsvp_form_dialog.dart';

class HomeScreen extends StatefulWidget {
  final List<Map<String, String>> pastEvents;

  const HomeScreen({required this.pastEvents, Key? key}) : super(key: key);

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
      "description":
          "Hands-on workshop to learn Flutter and build beautiful mobile apps.",
      "image": "",
    },
  ];

  // Move RSVP'd event to past events safely
  void moveToPast(Map<String, String> event) {
    setState(() {
      events.remove(event);
      widget.pastEvents.add(event);
    });
  }

  // Handle RSVP dialog
  void handleRSVP(Map<String, String> event) async {
    final rsvp = await showDialog<Map<String, String>>(
      context: context,
      builder: (_) => RSVPFormDialog(event: event),
    );
    if (rsvp != null) moveToPast(event);
  }

  // Show add event form dialog
  Future<Map<String, String>?> _showAddEventDialog() async {
    final _formKey = GlobalKey<FormState>();
    String title = '';
    String date = '';
    String time = '';
    String location = '';
    String organizer = '';
    String description = '';
    String image = '';

    // Persistent controllers for date and time
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Event'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Enter title' : null,
                    onSaved: (val) => title = val!.trim(),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Location'),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Enter location' : null,
                    onSaved: (val) => location = val!.trim(),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Organizer'),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Enter organizer' : null,
                    onSaved: (val) => organizer = val!.trim(),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Enter description' : null,
                    onSaved: (val) => description = val!.trim(),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Image URL (optional)',
                    ),
                    onSaved: (val) => image = val?.trim() ?? '',
                  ),
                  SizedBox(height: 8),
                  // Date field
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        date = '${picked.year}-${picked.month}-${picked.day}';
                        dateController.text = date;
                      }
                    },
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Select date' : null,
                  ),
                  SizedBox(height: 8),
                  // Time field
                  TextFormField(
                    controller: timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        time = picked.format(context);
                        timeController.text = time;
                      }
                    },
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Select time' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(context, {
                    'title': title,
                    'date': date,
                    'time': time,
                    'location': location,
                    'organizer': organizer,
                    'description': description,
                    'image': image,
                  });
                }
              },
              child: Text('Add Event'),
            ),
          ],
        );
      },
    );
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newEvent = await _showAddEventDialog();
          if (newEvent != null) {
            setState(() {
              events.add(newEvent);
            });
          }
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

            final title = event['title'] ?? 'No Title';
            final date = event['date'] ?? 'No Date';
            final time = event['time'] ?? '';
            final location = event['location'] ?? 'No Location';
            final organizer = event['organizer'] ?? 'No Organizer';
            final description = event['description'] ?? '';
            final image = event['image'] ?? '';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EventDetailScreen(
                      event: event,
                      onRSVP: () => handleRSVP(event),
                    ),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 24),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.deepPurpleAccent.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (image.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.network(
                          image,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "$date | $time",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                location,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                organizer,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(description, style: TextStyle(fontSize: 14)),
                          SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => handleRSVP(event),
                              child: Text('RSVP'),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 14,
                                ),
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
