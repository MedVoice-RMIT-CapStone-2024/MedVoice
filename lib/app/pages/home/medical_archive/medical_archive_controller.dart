import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:med_voice/app/pages/home/medical_archive/medical_archive_presenter.dart';
import 'package:flutter/material.dart';

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
  ThemeMode themeMode = ThemeMode.system;
  bool isDarkMode = false;
  List<String> dataReturn = [];
  RecordingArchiveInfo? dataLinks;
  List<DisplayArchive> mappedData = [];

  MedicalArchiveController(audioRepository) : _presenter = MedicalArchivePresenter(audioRepository) {
    onListener();
  }

  @override
  void firstLoad() {
    onLoadRecordingArchive();
    isDarkMode = Theme.of(view.context).brightness == Brightness.dark;
  }

  @override
  void onListener() {
    _presenter.onLoadRecordingArchiveSucceed = (RecordingArchiveInfo response) {
      dataLinks = response;
      debugPrint("load archives info success");
      if (dataLinks != null) {
        onExtractInformation(dataLinks!);
      }
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

  void toggleTheme(ThemeMode themeMode) {
    themeMode = themeMode;
    refreshUI();
  }

  void onExtractInformation(RecordingArchiveInfo data) {
    DisplayArchive itemHolder;
    for (int i = 0; i < data.mUrls.length; i++) {
      itemHolder = extractFileNameAndDate(data.mUrls[i]);
      mappedData.add(itemHolder);
      debugPrint('name: ${mappedData[i].patientName}, date created: ${mappedData[i].dateCreated}');
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

  DisplayArchive extractFileNameAndDate(String url) {
    DisplayArchive extractedItem = DisplayArchive.buildDefault();

    const pattern = r'https:\/\/storage\.googleapis\.com\/medvoice_audio_bucket\/audios\/(.*?)patient_(.*?)date_(.*?)fileID_(.*?)(?:\.mp3|\.m4a)';

    final regExp = RegExp(pattern);

    final match = regExp.firstMatch(url);

    if (match != null) {
      final fileName = match.group(1);
      final dateCreated = match.group(2);
      final audioId = match.group(3);
      final userId = match.group(4);

      return extractedItem = DisplayArchive(fileName!.replaceAll(RegExp(r'[-_]'), ' '), reformatDateString(dateCreated!), audioId!, userId!);
    } else {
      return extractedItem;
    }
  }

  String reformatDateString(String dateString) {
    DateTime dateTime = DateFormat('yyyy-MM-dd_HH-mm-ss').parse(dateString);

    String formattedDate = DateFormat('d/M/yyyy, HH:mm').format(dateTime);

    return formattedDate;
  }
}

class DisplayArchive {
  String patientName = '';
  String dateCreated = '';
  String audioId = '';
  String userId = '';

  DisplayArchive(this.patientName, this.dateCreated, this.audioId, this.userId);

  DisplayArchive.buildDefault();
}
