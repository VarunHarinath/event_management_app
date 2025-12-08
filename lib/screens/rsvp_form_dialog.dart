import 'package:flutter/material.dart';

class RSVPFormDialog extends StatefulWidget {
  final Map<String, String> event;
  RSVPFormDialog({required this.event});

  @override
  _RSVPFormDialogState createState() => _RSVPFormDialogState();
}

class _RSVPFormDialogState extends State<RSVPFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> rsvpData = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('RSVP for ${widget.event['title']}'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (val) => rsvpData['name'] = val ?? '',
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onSaved: (val) => rsvpData['email'] = val ?? '',
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
            _formKey.currentState!.save();
            Navigator.pop(context, rsvpData);
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
