import 'package:flutter/material.dart';

class EventAdminPage extends StatefulWidget {
  const EventAdminPage({super.key});

  @override
  State<EventAdminPage> createState() => _EventAdminPageState();
}

class _EventAdminPageState extends State<EventAdminPage> {
  // Mock data for demonstration
  final List<Map<String, String>> _applicants = [
    {
      "name": "John Doe",
      "email": "john.doe@example.com",
      "division": "Event",
      "status": "Pending"
    },
    {
      "name": "Jane Smith",
      "email": "jane.smith@example.com",
      "division": "Sponsor & Public Relations",
      "status": "Pending"
    },
    {
      "name": "Peter Jones",
      "email": "peter.jones@example.com",
      "division": "Security & Health",
      "status": "Qualified"
    },
    {
      "name": "Mary Williams",
      "email": "mary.w@example.com",
      "division": "Inventory",
      "status": "Rejected"
    },
  ];

  void _updateStatus(int index, String status) {
    setState(() {
      _applicants[index]['status'] = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Applicant Management'),
        backgroundColor: const Color(0xFF3F054F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Applicants List",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Division')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: _applicants.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> applicant = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(Text(applicant['name']!)),
                      DataCell(Text(applicant['division']!)),
                      DataCell(
                        Text(
                          applicant['status']!,
                          style: TextStyle(
                            color: applicant['status'] == 'Qualified'
                                ? Colors.green
                                : applicant['status'] == 'Rejected'
                                    ? Colors.red
                                    : Colors.orange,
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => _updateStatus(index, 'Qualified'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              child: const Text('Qualify', style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _updateStatus(index, 'Rejected'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: const Text('Reject', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
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
