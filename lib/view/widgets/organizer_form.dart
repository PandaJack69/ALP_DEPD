import 'dart:typed_data'; 
import 'package:alp_depd/model/custom_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
import 'package:image_picker/image_picker.dart'; 
import '../../viewmodel/database_provider.dart';
import 'custom_dialogs.dart'; // Karena satu folder (widgets), langsung panggil saja

class OrganizerForm extends StatefulWidget {
  final String category; 
  final EventModel? initialData; 

  const OrganizerForm({super.key, required this.category, this.initialData});

  @override
  State<OrganizerForm> createState() => _OrganizerFormState();
}

class _OrganizerFormState extends State<OrganizerForm> {
  late String _selectedCategory; 

  // Controllers
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _startRegController = TextEditingController();
  final _endRegController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _locationController = TextEditingController();
  
  // Kontak
  final _waController = TextEditingController();
  final _lineController = TextEditingController();
  
  // Khusus Lomba
  final _feeController = TextEditingController(); 
  final _subEventsController = TextEditingController(); // Untuk "Cabang Lomba"
  
  // Khusus Event & Pengmas (BARU DITAMBAHKAN)
  final _divisionsController = TextEditingController(); // Untuk "Divisi Kepanitiaan"

  DateTime? _startRegDate;
  DateTime? _endRegDate;
  DateTime? _eventDateObj;

  Uint8List? _selectedImageBytes; 
  String? _selectedFileExt;       
  String? _uploadedPosterUrl;     

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Default Category
    _selectedCategory = widget.category;
    if (!['Event', 'Lomba', 'Pengmas'].contains(_selectedCategory)) {
      _selectedCategory = 'Event';
    }

    // Load Data jika Edit Mode
    if (widget.initialData != null) {
      final data = widget.initialData!;
      if (data.category.isNotEmpty) _selectedCategory = data.category; 

      _titleController.text = data.name;
      _descController.text = data.description;
      _uploadedPosterUrl = data.posterUrl; 
      _locationController.text = data.location;
      _feeController.text = data.fee;
      _waController.text = data.whatsapp;
      _lineController.text = data.lineId;
      
      // Load Array ke String (Join dengan koma)
      _subEventsController.text = data.subEvents.join(', ');
      _divisionsController.text = data.divisions.join(', '); // Load Divisi

      if (data.openRegDate != DateTime(0)) { 
        _startRegDate = data.openRegDate;
        _startRegController.text = DateFormat('yyyy-MM-dd').format(data.openRegDate);
      }
      if (data.closeRegDate != DateTime(0)) {
        _endRegDate = data.closeRegDate;
        _endRegController.text = DateFormat('yyyy-MM-dd').format(data.closeRegDate);
      }
      if (data.eventDate != DateTime(0)) {
        _eventDateObj = data.eventDate;
        _eventDateController.text = DateFormat('yyyy-MM-dd').format(data.eventDate);
      }
    }
  }

  Future<void> _pickPoster() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final ext = pickedFile.name.split('.').last;
      setState(() {
        _selectedImageBytes = bytes;
        _selectedFileExt = ext;
      });
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller, Function(DateTime) onPicked) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        onPicked(picked);
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // === LOGIC SIMPAN DATA ===
  // === LOGIC SIMPAN DATA (FULL CODE) ===
  Future<void> _saveData() async {
    // 1. VALIDASI UMUM
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama kegiatan harus diisi")),
      );
      return;
    }
    
    if (_descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Deskripsi kegiatan harus diisi")),
      );
      return;
    }

    // 2. VALIDASI KHUSUS LOMBA
    if (_selectedCategory == 'Lomba') {
      if (_feeController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Biaya pendaftaran harus diisi (isi 0 jika gratis)")),
        );
        return;
      }
      if (_subEventsController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cabang lomba (Sub Event) harus diisi")),
        );
        return;
      }
    }
    // 3. VALIDASI KHUSUS EVENT/PENGMAS
    else {
      if (_divisionsController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Divisi kepanitiaan harus diisi")),
        );
        return;
      }
    }

    // --- 4. TAMPILKAN POP-UP KONFIRMASI (FITUR BARU) ---
    // Cek apakah ini mode Edit atau Buat Baru
    bool isUpdate = widget.initialData != null;
    
    bool confirm = await showConfirmationDialog(
      context,
      title: isUpdate ? "Simpan Perubahan?" : "Publikasikan Kegiatan?",
      message: isUpdate 
          ? "Data kegiatan lama akan diperbarui dengan data baru ini."
          : "Kegiatan akan dipublikasikan dan dapat dilihat oleh semua pengguna.",
      confirmLabel: isUpdate ? "Simpan" : "Publish",
    );

    // Jika user pilih "Batal", hentikan proses di sini
    if (!confirm) return; 
    // ---------------------------------------------------

    // Mulai Loading
    setState(() => _isLoading = true);
    
    final provider = context.read<DatabaseProvider>();
    String? finalPosterUrl = _uploadedPosterUrl; 

    // 5. PROSES UPLOAD POSTER (JIKA ADA GAMBAR BARU)
    if (_selectedImageBytes != null && _selectedFileExt != null) {
      final newUrl = await provider.uploadEventPoster(
        _selectedImageBytes!, 
        _selectedFileExt!
      );
      
      if (newUrl != null) {
        finalPosterUrl = newUrl;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal upload poster, coba lagi.")),
        );
        setState(() => _isLoading = false);
        return;
      }
    }

    // 6. PERSIAPAN DATA ARRAY & FORMATTING
    String finalFee = "0"; 
    List<String> subEventsList = [];
    List<String> divisionsList = [];

    // Pecah string input user (dipisah koma) menjadi List
    if (_selectedCategory == 'Lomba') {
      finalFee = _feeController.text.isEmpty ? "0" : _feeController.text;
      subEventsList = _subEventsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    } else {
      // Event & Pengmas
      divisionsList = _divisionsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }

    String? error;
    
    // 7. PANGGIL FUNGSI DATABASE (ADD atau UPDATE)
    if (widget.initialData == null) {
      // MODE CREATE (BUAT BARU)
      error = await provider.addEvent(
        title: _titleController.text,
        category: _selectedCategory.toLowerCase(), // Simpan lowercase agar konsisten
        description: _descController.text,
        startReg: _startRegDate,
        endReg: _endRegDate,
        eventDate: _eventDateObj,
        posterUrl: finalPosterUrl,
        
        location: _locationController.text,
        fee: finalFee, 
        
        whatsapp: _waController.text,
        lineId: _lineController.text,
        
        divisions: divisionsList, // Masuk ke kolom 'divisions'
        subEvents: subEventsList, // Masuk ke kolom 'sub_events'
      );
    } else {
      // MODE UPDATE (EDIT DATA LAMA)
      error = await provider.updateEvent(
        eventId: widget.initialData!.id, // ID event yang diedit
        title: _titleController.text,
        category: _selectedCategory.toLowerCase(),
        description: _descController.text,
        startReg: _startRegDate,
        endReg: _endRegDate,
        eventDate: _eventDateObj,
        posterUrl: finalPosterUrl, // URL baru atau lama
        
        location: _locationController.text,
        fee: finalFee,
        
        whatsapp: _waController.text,
        lineId: _lineController.text,
        
        divisions: divisionsList,
        subEvents: subEventsList,
      );
    }

    setState(() => _isLoading = false);

    // 8. TAMPILKAN HASIL
    if (error == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berhasil disimpan!"), backgroundColor: Colors.green),
      );
      Navigator.pop(context); // Kembali ke dashboard
    } else if (mounted) {
      // Jika gagal, tampilkan error (bisa pakai dialog error juga di sini)
      await showErrorDialog(
        context,
        title: "Gagal Menyimpan",
        message: error ?? "Terjadi kesalahan yang tidak diketahui.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.initialData == null ? 'Buat' : 'Update'} Kegiatan"),
        backgroundColor: const Color(0xff123C52),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Jenis Kegiatan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff123C52))),
            const Divider(),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Event'),
                  value: 'Event',
                  groupValue: _selectedCategory,
                  activeColor: const Color(0xff3F054F),
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
                RadioListTile<String>(
                  title: const Text('Lomba (Competition)'),
                  value: 'Lomba',
                  groupValue: _selectedCategory,
                  activeColor: const Color(0xff3F054F),
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
                RadioListTile<String>(
                  title: const Text('Pengmas (Community Service)'),
                  value: 'Pengmas',
                  groupValue: _selectedCategory,
                  activeColor: const Color(0xff3F054F),
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text("Informasi Utama", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff123C52))),
            const Divider(),
            _buildField("Nama Kegiatan", controller: _titleController),
            _buildField("Deskripsi Lengkap", controller: _descController, maxLines: 4),
            
            const SizedBox(height: 20),
            
            const Text("Waktu Pelaksanaan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff123C52))),
            const Divider(),
            Row(children: [
              Expanded(child: _buildDateField("Mulai Pendaftaran", _startRegController, (d) => _startRegDate = d)),
              const SizedBox(width: 15),
              Expanded(child: _buildDateField("Tutup Pendaftaran", _endRegController, (d) => _endRegDate = d)),
            ]),
            _buildDateField("Hari H Kegiatan", _eventDateController, (d) => _eventDateObj = d),

            const SizedBox(height: 20),

            const Text("Detail Tambahan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff123C52))),
            const Divider(),
            _buildField("Lokasi (Ex: Universitas Ciputra)", controller: _locationController),
            
            // --- LOGIKA TAMPILAN DINAMIS ---
            
            // 1. JIKA LOMBA: Tampilkan Biaya & Sub Event
            if (_selectedCategory == 'Lomba') ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Khusus Lomba:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                    _buildField("Biaya Pendaftaran (Angka Saja)", controller: _feeController, hint: "Ex: 50000", inputType: TextInputType.number),
                    _buildField("Cabang Lomba / Sub Event (Pisahkan koma)", controller: _subEventsController, hint: "Ex: Basket, Futsal, Mobile Legends"),
                  ],
                ),
              ),
            ] 
            // 2. JIKA EVENT / PENGMAS: Tampilkan Divisi
            else ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Kebutuhan Panitia:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    _buildField("Divisi yang Dicari (Pisahkan koma)", controller: _divisionsController, hint: "Ex: Acara, PDD, Humas, Konsumsi"),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),

            const Text("Kontak Person", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff123C52))),
            const Divider(),
            _buildField("No. Whatsapp (Ex: 08123456789)", controller: _waController, inputType: TextInputType.phone),
            _buildField("ID Line", controller: _lineController),

            const SizedBox(height: 20),

            const Text("Poster Kegiatan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff123C52))),
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickPoster, 
              child: Container(
                height: 300, 
                width: double.infinity, 
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _buildPosterPreview(),
              ),
            ),
            const SizedBox(height: 5),
            const Center(child: Text("Klik kotak di atas untuk upload gambar", style: TextStyle(fontSize: 12, color: Colors.grey))),
            
            const SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity, 
              height: 55, 
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveData, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3F054F), 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Text("PUBLISH KEGIATAN", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildPosterPreview() {
    if (_selectedImageBytes != null) {
      return ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.memory(_selectedImageBytes!, fit: BoxFit.contain));
    } 
    else if (_uploadedPosterUrl != null && _uploadedPosterUrl!.isNotEmpty) {
      return ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(_uploadedPosterUrl!, fit: BoxFit.contain));
    }
    else {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload_outlined, size: 50, color: Colors.grey),
          SizedBox(height: 10),
          Text("Upload Poster (JPG/PNG)", style: TextStyle(color: Colors.grey)),
        ],
      );
    }
  }

  Widget _buildField(String label, {TextEditingController? controller, int maxLines = 1, String? hint, TextInputType? inputType}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label, 
          hintText: hint,
          alignLabelWithHint: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller, Function(DateTime) onPicked) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label, 
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: const Icon(Icons.calendar_month, color: Color(0xff3F054F)),
        ),
        onTap: () => _selectDate(context, controller, onPicked),
      ),
    );
  }
}