import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/pages/home/medical_archive/medical_archive_presenter.dart';

import '../../../../common/base_controller.dart';
import '../../../../domain/entities/recording/recording_archive_info.dart';
import '../../../../domain/entities/recording_archive/recording_info.dart';
import '../../../utils/global.dart';

class MedicalArchiveController extends BaseController {
  MedicalArchivePresenter _presenter;
  int currentTabIndex = 0;
  bool resetToggle = false;
  bool toggleEmptyData = false;
  List<RecordingInfo> emptyDataTest = [];
  List<String> dataReturn = [];
  RecordingArchiveInfo? dataLinks;

  MedicalArchiveController(audioRepository) : _presenter = MedicalArchivePresenter(audioRepository) {
    onListener();
  }

  @override
  void firstLoad() {
    onLoadRecordingArchive();
  }

  @override
  void onListener() {
    _presenter.onLoadRecordingArchiveSucceed = (RecordingArchiveInfo response) {
      dataLinks = response;
      debugPrint("load archives info success");
      hideLoadingProgress();
    };
    _presenter.onLoadRecordingArchiveFailed = (e) {
      debugPrint("load archives info failed");
      hideLoadingProgress();
      view.showErrorFromServer("load archives info failed: $e");
    };
    _presenter.onCompleted = () {};
  }

  void onLoadRecordingArchive() {
    showLoadingProgress();
    _presenter.executeGetRecordingArchive();
  }

  void onChooseRecord(int index) {
    Global.sampleData[index].isToggle = !Global.sampleData[index].isToggle!;
    debugPrint("the toggle bool data: ${Global.sampleData[index].isToggle}");
    refreshUI();
  }

  bool handleDeleteItems() {
    int count = 0;
    for (var item in Global.sampleData) {
      if (item.isToggle == true) {
        count++;
      }
    }
    if (count > 0) {
      return true;
    } else {
      return false;
    }
  }

  // void onDeleteRecordings() {
  //   List<RecordingInfo> itemsToKeep = [];
  //   for (var item in Global.sampleData) {
  //     if (!item.isToggle!) {
  //       itemsToKeep.add(item);
  //     } else {
  //       onDelete(item);
  //     }
  //   }
  //   Global.sampleData = List.from(itemsToKeep);
  //   resetToggle = !resetToggle;
  //   refreshUI();
  // }
}
