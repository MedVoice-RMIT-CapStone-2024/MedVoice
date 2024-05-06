import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/base_controller.dart';

class MedicalArchiveController extends BaseController {
  int currentTabIndex = 0;
  bool resetToggle = false;
  bool toggleEmptyData = false;
  List<RecordingInfo> sampleData = [];
  List<RecordingInfo> emptyDataTest = [];
  ThemeMode themeMode = ThemeMode.system;
  bool isDarkMode = false;

  @override
  void firstLoad() {
    sampleData = [
      RecordingInfo(
          recordingTitle: 'patient-0-zombie-symptoms.mp3',
          minuteDuration: 10,
          secondDuration: 30,
          recordingSize: 4.51,
          isToggle: false),
      RecordingInfo(
          recordingTitle: 'patient-with-lung-cancer.mp3',
          minuteDuration: 30,
          secondDuration: 24,
          recordingSize: 10.51,
          isToggle: false),
      RecordingInfo(
          recordingTitle: 'patient-suffering-from-RMIT-deadline.mp3',
          minuteDuration: 59,
          secondDuration: 30,
          recordingSize: 98.51,
          isToggle: false),
      RecordingInfo(
          recordingTitle: 'bald-patient.mp3',
          minuteDuration: 8,
          secondDuration: 12,
          recordingSize: 2.51,
          isToggle: false),
      RecordingInfo(
          recordingTitle: 'patient-symptoms-from-watching-too-much-TikTok.mp3',
          minuteDuration: 5,
          secondDuration: 49,
          recordingSize: 4.32,
          isToggle: false)
    ];
    isDarkMode = Theme.of(view.context).brightness == Brightness.dark;
  }

  @override
  void onListener() {}

  void onChooseRecord(int index) {
    sampleData[index].isToggle = !sampleData[index].isToggle!;
    debugPrint("the toggle bool data: ${sampleData[index].isToggle}");
    refreshUI();
  }

  bool handleDeleteItems() {
    int count = 0;
    for (var item in sampleData) {
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

  void toggleTheme(ThemeMode themeMode) {
    themeMode = themeMode;
    refreshUI();
  }

  void onDeleteRecordings() {
    List<RecordingInfo> itemsToKeep = [];
    for (var item in sampleData) {
      if (!item.isToggle!) {
        itemsToKeep.add(item);
      }
    }
    sampleData = List.from(itemsToKeep);
    resetToggle = !resetToggle;
    refreshUI();
  }
}

class RecordingInfo {
  String? recordingTitle = '';
  int? minuteDuration = 0;
  int? secondDuration = 0;
  double? recordingSize = 0.0;
  bool? isToggle = false;

  RecordingInfo.buildDefault();

  RecordingInfo(
      {this.recordingTitle,
      this.minuteDuration,
      this.secondDuration,
      this.recordingSize,
      this.isToggle});
}
