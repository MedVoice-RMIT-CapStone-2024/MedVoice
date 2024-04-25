import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../../common/base_controller.dart';
import '../../../../domain/entities/recording_archive/recording_info.dart';
import '../../../utils/global.dart';

class MedicalArchiveController extends BaseController {
  int currentTabIndex = 0;
  bool resetToggle = false;
  bool toggleEmptyData = false;
  List<RecordingInfo> emptyDataTest = [];

  @override
  void firstLoad() {}

  @override
  void onListener() {}

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

  void onDeleteRecordings() {
    List<RecordingInfo> itemsToKeep = [];
    for (var item in Global.sampleData) {
      if (!item.isToggle!) {
        itemsToKeep.add(item);
      } else {
        onDelete(item);
      }
    }
    Global.sampleData = List.from(itemsToKeep);
    resetToggle = !resetToggle;
    refreshUI();
  }

  Future<void> onDelete(RecordingInfo item) async {
    try {
      final file = File(item.path ?? "");
      if (await file.exists()) {
        await file.delete();
        refreshUI();
        debugPrint("File deleted successfully: ${item.path}");
      } else {
        debugPrint("File does not exist: ${item.path}");
      }
    } catch (e) {
      debugPrint("Failed to delete file: $e");
    }
  }
}
