import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/eventservice.dart';
import '../model/eventmodel.dart';

class EventDetailViewModel extends ChangeNotifier {
  final _service = EventService();

  EventModel? event;
  bool isLoading = true;

  Duration get countdown =>
      event!.eventDate.difference(DateTime.now());

  Future<void> fetchEvent(String id) async {
    event = await _service.getEventById(id);
    isLoading = false;
    notifyListeners();
  }
}


class AddEventViewModel extends ChangeNotifier {
  final _service = EventService();
  File? posterFile;
  bool isLoading = false;

  Future<void> pickPoster() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      posterFile = File(result.path);
      notifyListeners();
    }
  }

  Future<void> submitEvent(EventModel event) async {
    if (posterFile == null) return;

    isLoading = true;
    notifyListeners();

    final posterUrl = await _service.uploadPoster(posterFile!);

    final newEvent = EventModel(
      id: '',
      name: event.name,
      description: event.description,
      posterUrl: posterUrl, // 🔥 hasil upload
      organization: event.organization,
      openRegDate: event.openRegDate,
      closeRegDate: event.closeRegDate,
      eventDate: event.eventDate,
      benefits: event.benefits,
      divisions: event.divisions,
    );

    await _service.createEvent(event: newEvent);

    isLoading = false;
    notifyListeners();
  }
}
