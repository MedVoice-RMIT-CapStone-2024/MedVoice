// Creating and storing application's global variables

import 'package:flutter/cupertino.dart';

import '../../domain/entities/recording/recording_archive_info.dart';
import '../../domain/entities/recording_archive/recording_info.dart';

class Global {
  static bool isAppInForeground = true;

  // HexColor code sets
  static Map<String, String> mColors = {
    "red_1": "#E47272",
    "red_2": "#EA3838",
    "red_3": "#945959",
    "red_4": "#B66A6A",
    "red_5": "#E52A2D",
    "red_6": "#BC4343",
    "red_7": "#FFF3E8",
    "red_8": "#FB5D2B",
    "red_9": "#DB6060",
    "red_10": "#BB4343",
    "red_11": "#BB4A4A",
    "red_12": "#CF4040",
    "red_13": "#DB8F8F",
    "red_14": "#D75757",
    "blue_1": "#FF125C66",
    "blue_2": "#408289",
    "blue_3": "#B3125C66",
    "blue_4": "#FF214664",
    "blue_6": "#125C66",
    "blue_7": "#D8E6DB",
    "blue_8": "#387FEA",
    "blue_9": "#458FFF",
    "blue_10": "#E7F3FF",
    "blue_11": "#3D72DA",
    "blue_12": "#E5F6F6",
    "blue_13": "#198EFD",
    "blue_14": "#0D47A1",
    "blue_15": "#030E1E",
    "blue_16": "#030E1E",
    "blue_17": "#023179",
    "green": "#4CAF50",
    "green_2": "#125C66",
    "green_3": "#134E54",
    "green_4": "#2C9822",
    "green_5": "#4A7D21",
    "green_6": "#1C9B66",
    "green_7": "#3ACE64",
    "green_8": "#A5E6BA",
    "green_9": "#81F499",
    "yellow_1": "#FFBA9100",
    "yellow_2": "#EA8338",
    "yellow_3": "#856D18",
    "yellow_4": "#C79C6B",
    "yellow_5": "#FFF5DD",
    "black_1": "#FF979AA0",
    "black_2": "#FF686868",
    "black_3": "#80000000",
    "black_4": "#29000000",
    "black_5": "#FF323232",
    "black_6": "#646464",
    "black_7": "#33000000",
    "black_8": "#FF0A1811",
    "black_9": "#0A1811",
    "black_10": "#313131",
    "gray_1": "#66FFFFFF",
    "gray_2": "#FF494949",
    "gray_3": "#B3646464",
    "gray_5": "#BFFFFFFF",
    "gray_6": "#CCFFFFFF",
    "gray_7": "#FFD3E9E8",
    "gray_8": "#E2E2E2",
    "gray_9": "#E5E5E5",
    "gray_10": "#FF7B827E",
    "gray_11": "#FFB6B6B6",
    "gray_12": "#636363",
    "gray_13": "#F1F1F1",
    "gray_14": "#D9D9D9",
    "gray_15": "#F8F8F8",
    "gray_16": "#C1C4C9",
    "gray_17": "#2B2D42",
    "gray_18": "#3A3D59",
    "gray_19": "#C6CCD7",
    "brown_1": "#B8601F",
    "orange_1": "#FE724C",
    "white_1": "#D3D1D8",
    "white_2": "#FCFCFD",
    "white_3": "#F2EAEA",
    "white_4": "#EDF2F4",
    "white_5": "#8D99AE",
    "pink_1": "#EC4B8B",
    "pink_2": "#FBE8F2",
    "pink_3": "#E71569",
  };

  static int mTimeClick = 0;
  static bool isAvailableToClick() {
    debugPrint("clicked ${DateTime.now().millisecondsSinceEpoch - mTimeClick}");
    if (DateTime.now().millisecondsSinceEpoch - mTimeClick > 1000) {
      mTimeClick = DateTime.now().millisecondsSinceEpoch;
      return true;
    }
    return false;
  }

  static String mLang = "";
  static String appVersion = "";

  static List<RecordingInfo> sampleData = [
    RecordingInfo(
        recordingTitle: 'sample-fixed-data',
        isToggle: false,
        duration: 180,
        path: 'local_path'),
  ];

  static bool isDisableHttpLogging = false;

  static String bucketName = "medvoice_audio_bucket";
}
