class EventModel {
  final String id;
  final String name;
  final String description;
  final String posterUrl;
  final String organization;

  final DateTime openRegDate;
  final DateTime closeRegDate;
  final DateTime eventDate;

  final List<String> benefits;
  final List<String> divisions;

  final String whatsapp;
  final String lineId;
  final String instagram;

  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.posterUrl,
    required this.organization,
    required this.openRegDate,
    required this.closeRegDate,
    required this.eventDate,
    required this.benefits,
    required this.divisions,
    required this.whatsapp,
    required this.lineId,
    required this.instagram,
    // required.this.quota,
  });

  factory EventModel.fromMap(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      name: data['name'],
      description: data['description'],
      posterUrl: data['posterUrl'],
      organization: data['organization'],
      openRegDate: DateTime.parse(data['openRegDate']),
      closeRegDate: DateTime.parse(data['closeRegDate']),
      eventDate: DateTime.parse(data['eventDate']),
      benefits: List<String>.from(data['benefits']),
      divisions: List<String>.from(data['divisions']),
      whatsapp: data['whatsapp'],
      lineId: data['lineId'],
      instagram: data['instagram'],
    );
  }
}
