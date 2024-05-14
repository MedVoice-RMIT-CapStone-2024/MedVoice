import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'nurse_note.dart';

class NurseNotePresenter extends Presenter {
  late Function(NurseNote) onLoadNurseNoteComplete;
  late Function onLoadNurseNoteError;

  NurseNotePresenter();

  Future<void> loadNurseNote() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/json/nurse_note.json');
      Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
      NurseNote nurseNote = NurseNote.fromJson(jsonResponse);
      onLoadNurseNoteComplete(nurseNote);
    } catch (e) {
      onLoadNurseNoteError();
      print('Error loading nurse note data: $e');
    }
  }

  @override
  void dispose() {
    // Dispose resources if needed
  }
}
