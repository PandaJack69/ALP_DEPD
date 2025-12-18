import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb; // Digunakan untuk mendeteksi platform web
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../model/eventmodel.dart';

class RegistrationForm extends StatefulWidget {
  final EventModel event;

  const RegistrationForm({
    super.key,
    required this.event,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final universityController = TextEditingController();
  final majorController = TextEditingController();
  final yearController = TextEditingController();
  final phoneController = TextEditingController();

  String? selectedDivision;
  List<String> divisions = [
    "Inventory",
    "Event",
    "Food & Health",
    "PDD Design",
    "PDD Documentation",
    "Add Custom Division...",
  ];

  PlatformFile? cvFile;
  PlatformFile? portfolioFile;

  // Fungsi pick file diperbarui dengan withData: true agar bisa preview di Web
  Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "jpg", "png", "jpeg"],
      withData: true, // Sangat penting agar byte data terbaca untuk preview
    );
    if (result != null) return result.files.first;
    return null;
  }

  Future<void> _addCustomDivision() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Custom Division"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Division Name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  divisions.insert(
                    divisions.length - 1,
                    controller.text.trim(),
                  );
                  selectedDivision = controller.text.trim();
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    universityController.dispose();
    majorController.dispose();
    yearController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ================= HEADER =================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 180, horizontal: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff123C52),
                Color(0xff3F054F),
              ],
            ),
          ),
          child: Column(
            children: [
              Text(
                widget.event.name,
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                "Find Your Next Experience",
                style: TextStyle(
                  fontSize: 32,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // ================= FORM CARD =================
        Transform.translate(
          offset: const Offset(0, -80),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Registration Form",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff143952),
                        ),
                      ),
                      const SizedBox(height: 40),

                      Row(
                        children: [
                          Expanded(
                              child: buildInput("Your Name", nameController)),
                          const SizedBox(width: 15),
                          Expanded(
                              child: buildInput(
                                  "University", universityController)),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Expanded(
                              child: buildInput("Major", majorController)),
                          const SizedBox(width: 15),
                          Expanded(child: buildInput("Year", yearController)),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Row(
                        children: [
                          Expanded(
                              child: buildInput(
                                  "Phone Number", phoneController)),
                          const SizedBox(width: 15),
                          Expanded(child: buildDivisionDropdown()),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Upload CV dengan Preview
                      buildUploadBox(
                        title: "Upload CV (PDF/IMG)",
                        file: cvFile,
                        onPick: () async {
                          final file = await pickFile();
                          if (file != null) setState(() => cvFile = file);
                        },
                        onRemove: () => setState(() => cvFile = null),
                      ),
                      const SizedBox(height: 25),

                      // Upload Portfolio dengan Preview
                      buildUploadBox(
                        title: "Upload Portfolio (PDF/IMG)",
                        file: portfolioFile,
                        onPick: () async {
                          final file = await pickFile();
                          if (file != null) {
                            setState(() => portfolioFile = file);
                          }
                        },
                        onRemove: () => setState(() => portfolioFile = null),
                      ),
                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff3F054F),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          onPressed: _submitForm,
                          child: const Text(
                            "Apply Now!",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================= HELPERS =================

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (cvFile == null || portfolioFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please upload both CV and Portfolio"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Form Submitted Successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget buildInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xffA0025B))),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: (v) => v == null || v.isEmpty ? "Required" : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  // Dropdown dengan label "Division" yang jelas
  Widget buildDivisionDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Division",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xffA0025B))),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: selectedDivision,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
          items: divisions
              .map((d) => DropdownMenuItem(value: d, child: Text(d)))
              .toList(),
          onChanged: (value) {
            if (value == "Add Custom Division...") {
              _addCustomDivision();
            } else {
              setState(() => selectedDivision = value);
            }
          },
          validator: (v) =>
              v == null || v == "Add Custom Division..." ? "Required" : null,
        ),
      ],
    );
  }

  // Widget Upload Box dengan logika Preview Gambar dan Ikon PDF
  Widget buildUploadBox({
    required String title,
    required PlatformFile? file,
    required VoidCallback onPick,
    required VoidCallback onRemove,
  }) {
    bool isImage = false;
    if (file != null) {
      final ext = file.extension?.toLowerCase();
      isImage = ["jpg", "jpeg", "png"].contains(ext);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xffA0025B))),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              height: 250, // Ukuran diperbesar untuk preview
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade50,
              ),
              child: file == null
                  ? Center(
                      child: ElevatedButton.icon(
                        onPressed: onPick,
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Select File"),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: isImage
                          ? (kIsWeb
                              ? Image.memory(file.bytes!, fit: BoxFit.contain)
                              : Image.file(File(file.path!), fit: BoxFit.contain))
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.picture_as_pdf,
                                      size: 50, color: Colors.red),
                                  const SizedBox(height: 10),
                                  Text(file.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  Text("${(file.size / 1024).toStringAsFixed(1)} KB"),
                                ],
                              ),
                            ),
                    ),
            ),
            if (file != null)
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 18,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 18),
                    onPressed: onRemove,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}