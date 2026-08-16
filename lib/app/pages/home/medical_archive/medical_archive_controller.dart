import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_voice/app/pages/home/medical_archive/medical_archive_presenter.dart';

import '../../../../common/base_controller.dart';
import '../../../../domain/entities/recording/recording_list.dart';
import '../../../../domain/entities/recording/recording_summary.dart';

class MedicalArchiveController extends BaseController {
  final MedicalArchivePresenter _presenter;
  List<RecordingSummary> recordings = [];
  bool isDarkMode = false;

  MedicalArchiveController(audioRepository)
      : _presenter = MedicalArchivePresenter(audioRepository) {
    onListener();
  }

  @override
  void firstLoad() {
    onLoadRecordings();
    isDarkMode = Theme.of(view.context).brightness == Brightness.dark;
  }

  @override
  void onListener() {
    _presenter.onLoadRecordingsSucceed = (RecordingList response) {
      recordings = response.recordings;
      debugPrint("loaded ${recordings.length} recordings");
      hideLoadingProgress();
      refreshUI();
    };
    _presenter.onLoadRecordingsFailed = (e) {
      debugPrint("load recordings failed");
      hideLoadingProgress();
      view.showErrorFromServer("Load recordings failed: $e");
      refreshUI();
    };
  }

  void onLoadRecordings() {
    showLoadingProgress();
    _presenter.executeListRecordings();
  }

  /// `created_at` is ISO-8601 from the server; fall back to the raw string so a
  /// format change upstream degrades to "unformatted" rather than a crash.
  String formatCreatedAt(String createdAt) {
    final DateTime? parsed = DateTime.tryParse(createdAt);
    if (parsed == null) return createdAt;
    return DateFormat('d/M/yyyy, HH:mm').format(parsed.toLocal());
  }
}
