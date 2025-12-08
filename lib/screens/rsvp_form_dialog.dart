import 'package:flutter/material.dart';

class RSVPFormDialog extends StatefulWidget {
  final Map<String, String> event;
  const RSVPFormDialog({required this.event, Key? key}) : super(key: key);

  @override
  _RSVPFormDialogState createState() => _RSVPFormDialogState();
}

class _RSVPFormDialogState extends State<RSVPFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> rsvpData = {'name': '', 'email': ''};

  @override
  Widget build(BuildContext context) {
    final eventTitle = widget.event['title'] ?? 'Unnamed Event';

    return AlertDialog(
      title: Text('RSVP for $eventTitle'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your full name',
              ),
              onSaved: (val) => rsvpData['name'] = val?.trim() ?? '',
            ),

            SizedBox(height: 12),

            // Email field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (val) => rsvpData['email'] = val?.trim() ?? '',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _formKey.currentState?.save();
            Navigator.pop(context, rsvpData);
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
