// File: lib/model/custom_models.dart

class UserProfile {
  final String id;
  final String email;
  final String fullName;
  final String role; // 'admin', 'organizer', 'mahasiswa', 'siswa'
  final String? institution;

  UserProfile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.institution,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? 'No Name',
      role: json['role'] ?? 'mahasiswa',
      institution: json['institution'],
    );
  }
}

class EventData {
  final String id;
  final String title;
  final String description;
  final String organization;
  final String category; // 'event', 'lomba', 'pengmas'
  final DateTime? startRegDate;
  final int registrationsCount; // Untuk dashboard

  EventData({
    required this.id,
    required this.title,
    required this.description,
    required this.organization,
    required this.category,
    this.startRegDate,
    this.registrationsCount = 0,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'],
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? '',
      organization: json['organization_name'] ?? '-',
      category: json['category'] ?? 'event',
      startRegDate: json['start_reg_date'] != null 
          ? DateTime.parse(json['start_reg_date']) 
          : null,
      // Jika kita melakukan join count nanti
      registrationsCount: json['registrations_count'] ?? 0, 
    );
  }
}