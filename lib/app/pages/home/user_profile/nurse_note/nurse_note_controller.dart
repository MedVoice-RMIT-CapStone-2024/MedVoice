import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:med_voice/common/base_controller.dart';
import 'nurse_note.dart';

class NurseNoteController extends BaseController {
  bool isShowStartButton = false;
  Timer? timer;
  NurseNote? nurseNote;

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
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {}

  void onLoadNurseNoteComplete(NurseNote note) {
    nurseNote = note;
    refreshUI(); // Notify the view
  }

  void onLoadNurseNoteError() {
    // Handle error
  }
}
