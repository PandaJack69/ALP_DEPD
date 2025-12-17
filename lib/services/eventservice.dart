// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import '../model/eventmodel.dart';

// class EventService {
//   final _db = FirebaseFirestore.instance;
//   final _storage = FirebaseStorage.instance;

//   // ================= UPLOAD POSTER =================
//   Future<String> uploadPoster(File file) async {
//     final ref = _storage
//         .ref()
//         .child('event_posters/${DateTime.now().millisecondsSinceEpoch}.jpg');

//     await ref.putFile(file);
//     return await ref.getDownloadURL();
//   }

//   // ================= SAVE EVENT =================
//   Future<void> createEvent({
//     required EventModel event,
//   }) async {
//     await _db.collection('events').add({
//       'name': event.name,
//       'description': event.description,
//       'posterUrl': event.posterUrl,
//       'organization': event.organization,
//       'openRegDate': event.openRegDate.toIso8601String(),
//       'closeRegDate': event.closeRegDate.toIso8601String(),
//       'eventDate': event.eventDate.toIso8601String(),
//       'benefits': event.benefits,
//       'divisions': event.divisions,
//     });
//   }

//   // ================= GET EVENT =================
//   Future<EventModel> getEventById(String id) async {
//     final doc = await _db.collection('events').doc(id).get();
//     return EventModel.fromMap(doc.id, doc.data()!);
//   }
// }
