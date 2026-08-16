import 'package:flutter/material.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../domain/entities/recording/recording_detail.dart';
import '../../../../../domain/repositories/audio_repository/audio_repository.dart';
import 'recording_detail_presenter.dart';

class RecordingDetailController extends BaseController {
  final RecordingDetailPresenter _presenter;
  final String recordingId;

  RecordingDetail? detail;
  bool isDeleted = false;

  RecordingDetailController(this.recordingId, AudioRepository audioRepository)
      : _presenter = RecordingDetailPresenter(audioRepository) {
    onListener();
  }

  @override
  void firstLoad() {
    showLoadingProgress();
    _presenter.executeGetRecordingDetail(recordingId);
  }

  @override
  void onListener() {
    _presenter.onLoadDetailSucceed = (RecordingDetail response) {
      detail = response;
      hideLoadingProgress();
      refreshUI();
    };
    _presenter.onLoadDetailFailed = (e) {
      hideLoadingProgress();
      view.showErrorFromServer("Load recording failed: $e");
      refreshUI();
    };
    _presenter.onDeleteSucceed = () {
      isDeleted = true;
      hideLoadingProgress();
      // `true` tells the archive list to refetch.
      Navigator.pop(view.context, true);
    };
    _presenter.onDeleteFailed = (e) {
      hideLoadingProgress();
      view.showErrorFromServer("Delete recording failed: $e");
    };
  }

  void onDeleteRecording() {
    showLoadingProgress();
    _presenter.executeDeleteRecording(recordingId);
  }
}
