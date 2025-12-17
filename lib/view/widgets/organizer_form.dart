import 'package:flutter/material.dart';

class OrganizerForm extends StatefulWidget {
  final String category;
  final Map<String, dynamic>? initialData;

  const OrganizerForm({super.key, required this.category, this.initialData});

  @override
  State<OrganizerForm> createState() => _OrganizerFormState();
}

class _OrganizerFormState extends State<OrganizerForm> {
  final List<TextEditingController> _subEventControllers = [];
  final List<String> _divisions = ["Acara", "Inventory", "Security", "PR", "PDD"];
  final List<String> _selectedDivisions = [];
  final TextEditingController _customDivController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category == "Lomba") _subEventControllers.add(TextEditingController());
    // Logika Update: Isi data jika initialData ada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.initialData == null ? 'Buat' : 'Update'} ${widget.category}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField("Nama ${widget.category}"),
            Row(children: [
              Expanded(child: _buildField("Start Daftar")),
              const SizedBox(width: 15),
              Expanded(child: _buildField("End Daftar")),
            ]),
            _buildField("Hari H Acara / Pengmas"),
            
            if (widget.category != "Lomba") ...[
              const SizedBox(height: 15),
              const Text("Divisi yang Dicari:", style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(spacing: 8, children: _divisions.map((d) => FilterChip(label: Text(d), selected: _selectedDivisions.contains(d), onSelected: (s) => setState(() => s ? _selectedDivisions.add(d) : _selectedDivisions.remove(d)))).toList()),
              TextField(controller: _customDivController, decoration: InputDecoration(labelText: "Tambah Divisi Custom", suffixIcon: IconButton(icon: const Icon(Icons.add), onPressed: () { if(_customDivController.text.isNotEmpty){ setState(() => _divisions.add(_customDivController.text)); _customDivController.clear(); } }))),
              _buildField("Link WA Group"),
            ],

            if (widget.category == "Lomba") ...[
              _buildField("TM (Technical Meeting)"),
              _buildField("Prelim"),
              const Text("Sub-Event:", style: TextStyle(fontWeight: FontWeight.bold)),
              ..._subEventControllers.map((c) => Padding(padding: const EdgeInsets.only(top: 8), child: TextField(controller: c, decoration: const InputDecoration(border: OutlineInputBorder())))),
              TextButton.icon(onPressed: () => setState(() => _subEventControllers.add(TextEditingController())), icon: const Icon(Icons.add), label: const Text("Tambah Jenis Lomba")),
              _buildField("Biaya Pendaftaran"),
              _buildField("No Rekening"),
            ],

            _buildField("CP WhatsApp"),
            _buildField("CP Line"),
            _buildField("Link S&K (PDF)"),
            const SizedBox(height: 20),
            const Text("Upload Poster:"),
            Container(height: 150, width: double.infinity, decoration: BoxDecoration(border: Border.all(color: Colors.grey)), child: const Icon(Icons.add_a_photo)),
            const SizedBox(height: 30),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("SIMPAN"))),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label) => Padding(padding: const EdgeInsets.only(top: 15), child: TextFormField(decoration: InputDecoration(labelText: label, border: const OutlineInputBorder())));
}