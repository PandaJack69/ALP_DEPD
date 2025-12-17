import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:open_filex/open_filex.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final nameController = TextEditingController();
  final universityController = TextEditingController();
  final majorController = TextEditingController();
  final yearController = TextEditingController();
  final phoneController = TextEditingController();

  // Division dropdown
  String? selectedDivision;
  List<String> divisions = [
    "Inventory",
    "Event",
    "Food & Health",
    "PDD Design",
    "PDD Documentation",
    "Add Custom Division...",
  ];

  // Uploaded files
  PlatformFile? cvFile;
  PlatformFile? portfolioFile;

  // Pick file handler
  Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "jpg", "png", "jpeg"],
    );
    if (result != null) return result.files.first;
    return null;
  }

  // Add custom division dialog
  Future<void> _addCustomDivision() async {
    TextEditingController customCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Custom Division"),
        content: TextField(
          controller: customCtrl,
          decoration: const InputDecoration(labelText: "Division Name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (customCtrl.text.trim().isNotEmpty) {
                setState(() {
                  divisions.insert(
                    divisions.length - 1,
                    customCtrl.text.trim(),
                  );
                  selectedDivision = customCtrl.text.trim();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // GRADIENT BOX (SCROLLABLE)
                Container(
                  width: double.infinity,
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
                  padding: const EdgeInsets.symmetric(vertical: 180, horizontal: 20),
                  child: Column(
                    children: [
                      const Text(
                        "Leadership 101 Batch 1",
                        style: TextStyle(
                          fontSize: 85,
                          fontFamily: "VisueltPro",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Find Your Next Experience",
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: "VisueltPro",
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // FORM CARD (OVERLAPPING)
                Transform.translate(
                  offset: const Offset(0, -80),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Card(
                      color: Colors.white,
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                        child: Column(
                          children: [
                            // FORM HEADER
                            const Text(
                              "Registration Form",
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: "VisueltPro",
                                fontWeight: FontWeight.bold,
                                color: Color(0xff143952),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "This isn't just an event. It's the experience\neveryone will talk about.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff143952),
                                fontSize: 14,
                                fontFamily: "VisueltPro",
                              ),
                            ),
                            const SizedBox(height: 40),

                            // FORM CONTENT
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // FIRST ROW
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildInput("Your Name", nameController),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: buildInput("University", universityController),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),

                                  // SECOND ROW
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildInput("Major", majorController),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: buildInput("Year", yearController),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),

                                  // THIRD ROW
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildInput("Phone Number", phoneController),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(child: buildDivisionDropdown()),
                                    ],
                                  ),

                                  const SizedBox(height: 25),
                                  buildUploadBox(
                                    title: "Upload CV",
                                    file: cvFile,
                                    onPick: () async {
                                      final file = await pickFile();
                                      if (file != null) setState(() => cvFile = file);
                                    },
                                    onRemove: () {
                                      setState(() => cvFile = null);
                                    },
                                  ),

                                  const SizedBox(height: 25),

                                  buildUploadBox(
                                    title: "Upload Portfolio",
                                    file: portfolioFile,
                                    onPick: () async {
                                      final file = await pickFile();
                                      if (file != null) {
                                        setState(() => portfolioFile = file);
                                      }
                                    },
                                    onRemove: () {
                                      setState(() => portfolioFile = null);
                                    },
                                  ),

                                  const SizedBox(height: 40),

                                  // APPLY BUTTON
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xff3F054F),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 18),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Validate files
                                          if (cvFile == null) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("Please upload your CV"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }
                                          
                                          if (portfolioFile == null) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("Please upload your Portfolio"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }

                                          // SUBMIT LOGIC
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Form Submitted Successfully!"),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "Apply Now!",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontFamily: "VisueltPro",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // INPUT BUILDER
  Widget buildInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffA0025B),
            fontFamily: "VisueltPro",
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffA0025B), width: 2),
            ),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? "This field cannot be empty" : null,
        ),
      ],
    );
  }

  // DIVISION DROPDOWN
  Widget buildDivisionDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Division",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffA0025B),
            fontFamily: "VisueltPro",
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: selectedDivision,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffA0025B), width: 2),
            ),
          ),
          items: divisions.map((d) {
            return DropdownMenuItem(value: d, child: Text(d));
          }).toList(),
          onChanged: (value) {
            if (value == "Add Custom Division...") {
              _addCustomDivision();
            } else {
              setState(() => selectedDivision = value);
            }
          },
          validator: (value) =>
              value == null || value == "Add Custom Division..."
                  ? "Please select a division"
                  : null,
        ),
      ],
    );
  }

  // UPLOAD BOX
  Widget buildUploadBox({
    required String title,
    required PlatformFile? file,
    required VoidCallback onPick,
    required VoidCallback onRemove,
  }) {
    bool isImage = file != null &&
        (file.extension == "jpg" ||
            file.extension == "jpeg" ||
            file.extension == "png");

    bool isPDF = file != null && file.extension == "pdf";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffA0025B),
            fontFamily: "VisueltPro",
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 1),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              // When NO FILE uploaded
              if (file == null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Drag here or Click button below",
                        style: TextStyle(
                          fontFamily: "VisueltPro",
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff3F054F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: onPick,
                        child: const Text(
                          "Upload File",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "VisueltPro",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // If FILE exists
              if (file != null)
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (file.path != null) OpenFilex.open(file.path!);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isImage)
                          file.bytes != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    file.bytes!,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
                                )
                        else if (isPDF)
                          const Icon(
                            Icons.picture_as_pdf,
                            color: Colors.red,
                            size: 50,
                          )
                        else
                          const Icon(
                            Icons.insert_drive_file,
                            size: 50,
                            color: Colors.grey,
                          ),

                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            file.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "VisueltPro",
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // DELETE BUTTON
              if (file != null)
                Positioned(
                  right: 8,
                  top: 8,
                  child: InkWell(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.85),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}