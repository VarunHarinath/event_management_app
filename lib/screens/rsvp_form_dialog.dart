import 'package:flutter/material.dart';

/// This widget shows an RSVP form inside a dialog for a specific event.
/// Users can enter their details to RSVP for the event.
class RSVPFormDialog extends StatefulWidget {
  // The event for which the RSVP is being made
  final Map<String, String> event;

  const RSVPFormDialog({required this.event, Key? key}) : super(key: key);

  @override
  _RSVPFormDialogState createState() => _RSVPFormDialogState();
}

class _RSVPFormDialogState extends State<RSVPFormDialog> {
  // Key to uniquely identify the form and allow validation
  final _formKey = GlobalKey<FormState>();

  // Map to store all the user input for RSVP
  final Map<String, String> rsvpData = {
    'name': '',
    'email': '',
    'phone': '',
    'guests': '',
    'notes': '',
  };

  @override
  Widget build(BuildContext context) {
    // Get the event title, fallback if none
    final eventTitle = widget.event['title'] ?? 'Unnamed Event';

    return AlertDialog(
      title: Text('RSVP for $eventTitle'), // Dialog title showing event name
      content: SingleChildScrollView(
        // Allows scrolling if the keyboard or content overflows
        child: Form(
          key: _formKey, // Associate the form key
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Makes the column as small as possible
            children: [
              // ================= Name Field =================
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your full name',
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter your name' : null,
                // Save value to rsvpData map when form is submitted
                onSaved: (val) => rsvpData['name'] = val!.trim(),
              ),
              SizedBox(height: 8),

              // ================= Email Field =================
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

              // ================= Phone Field =================
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
                // Phone is optional, so no validator
                onSaved: (val) => rsvpData['phone'] = val?.trim() ?? '',
              ),
              SizedBox(height: 8),

              // ================= Number of Guests =================
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Number of Guests',
                  hintText: 'Enter number of guests',
                ),
                keyboardType: TextInputType.number,
                onSaved: (val) => rsvpData['guests'] = val?.trim() ?? '',
              ),
              SizedBox(height: 8),

              // ================= Notes Field (Optional) =================
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
      // ================= Dialog Buttons =================
      actions: [
        // Cancel button: closes the dialog without saving
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text('Cancel'),
        ),

        // Submit button: validates and saves the form, then closes dialog
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save(); // Save all fields into rsvpData
              Navigator.pop(
                context,
                rsvpData,
              ); // Return the data to parent screen
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
