import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // User info fields
  String name = 'Varun Harinath';
  String email = 'varun@example.com';
  String phone = '123-456-7890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Account'),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            // Profile Card
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    email,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  SizedBox(height: 6),
                  Text(
                    phone,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showEditProfileDialog(),
                    icon: Icon(Icons.edit, size: 20),
                    label: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.deepPurpleAccent.withOpacity(0.4),
                      elevation: 6,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Stats / Info Section (Optional)
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoColumn('Registered', '5'),
                  _buildInfoColumn('Attended', '3'),
                  _buildInfoColumn('Events Left', '2'),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Logout Button
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.logout),
              label: Text(
                'Logout',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.redAccent.withOpacity(0.4),
                elevation: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Stats/Info
  Widget _buildInfoColumn(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurpleAccent,
          ),
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  // Edit Profile Dialog
  void _showEditProfileDialog() {
    final _formKey = GlobalKey<FormState>();
    String tempName = name;
    String tempEmail = email;
    String tempPhone = phone;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: tempName,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Enter name' : null,
                    onSaved: (val) => tempName = val!.trim(),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    initialValue: tempEmail,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Enter email' : null,
                    onSaved: (val) => tempEmail = val!.trim(),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    initialValue: tempPhone,
                    decoration: InputDecoration(labelText: 'Phone'),
                    onSaved: (val) => tempPhone = val!.trim(),
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
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {
                    name = tempName;
                    email = tempEmail;
                    phone = tempPhone;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
