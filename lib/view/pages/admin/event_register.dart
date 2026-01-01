import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'event_admin.dart';

class EventRegisterPage extends StatefulWidget {
  const EventRegisterPage({super.key});

  @override
  State<EventRegisterPage> createState() => _EventRegisterPageState();
}

class _EventRegisterPageState extends State<EventRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDivision;
  final List<String> _divisions = [
    'Event',
    'Sponsor & Public Relations',
    'Security & Health',
    'Inventory'
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission logic here
      // For now, we just navigate to the admin page

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Event registered successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EventAdminPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register New Event'),
        backgroundColor: const Color(0xFF3F054F),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create Your Event",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F054F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Fill in the details below to get started.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),

                  // Event Name
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Event Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.event),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter an event name' : null,
                  ),
                  const SizedBox(height: 20),

                  // Event Description
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Event Description",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 4,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter an event description'
                        : null,
                  ),
                  const SizedBox(height: 20),

                  // Event Poster
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Implement image picker logic
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload Event Poster/Image"),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Committee Number Requirement
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Committee Number Requirement",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.group),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) => value!.isEmpty
                        ? 'Please enter the number of committee members required'
                        : null,
                  ),
                  const SizedBox(height: 20),

                  // Committee Divisions Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedDivision,
                    decoration: const InputDecoration(
                      labelText: "Committee Divisions",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.workspaces),
                    ),
                    items: _divisions.map((String division) {
                      return DropdownMenuItem<String>(
                        value: division,
                        child: Text(division),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDivision = newValue;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a division' : null,
                  ),
                  const SizedBox(height: 40),

                  // Submit Button
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF3F054F)),
                    child: const Text("Register Event", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
