import 'package:flutter/material.dart';

class RSVPFormDialog extends StatefulWidget {
  final Map<String, String> event;
  const RSVPFormDialog({required this.event, Key? key}) : super(key: key);

  @override
  _RSVPFormDialogState createState() => _RSVPFormDialogState();
}

class _RSVPFormDialogState extends State<RSVPFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> rsvpData = {
    'name': '',
    'email': '',
    'phone': '',
    'guests': '',
    'notes': '',
  };

  @override
  Widget build(BuildContext context) {
    final eventTitle = widget.event['title'] ?? 'Unnamed Event';

    return AlertDialog(
      title: Text('RSVP for $eventTitle'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your full name',
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter your name' : null,
                onSaved: (val) => rsvpData['name'] = val!.trim(),
              ),
              SizedBox(height: 8),

              // Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter your email' : null,
                onSaved: (val) => rsvpData['email'] = val!.trim(),
              ),
              SizedBox(height: 8),

              // Phone
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (val) => rsvpData['phone'] = val?.trim() ?? '',
              ),
              SizedBox(height: 8),

              // Number of Guests
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Number of Guests',
                  hintText: 'Enter number of guests',
                ),
                keyboardType: TextInputType.number,
                onSaved: (val) => rsvpData['guests'] = val?.trim() ?? '',
              ),
              SizedBox(height: 8),

              // Notes
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Notes (Optional)',
                  hintText: 'Any special requests or notes',
                ),
                onSaved: (val) => rsvpData['notes'] = val?.trim() ?? '',
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
              Navigator.pop(context, rsvpData);
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
