// For useful functions for any repetitive implementations

import 'package:intl/intl.dart' as MyFormat;
import 'constants.dart';

String formattedDate(String? formattedString, String dateFormat) {
  if (formattedString == null || formattedString == "") return "";

  DateTime? tempDate = DateTime.tryParse(formattedString);
  if (tempDate != null) {
    return MyFormat.DateFormat(dateFormat).format(tempDate.toLocal());
  }

  return MyFormat.DateFormat(dateFormat).format(DateTime.now().toLocal());
}

// Widget getNetworkImage(String? imageKey,
//     {String? accessToken, String? customUrlPath, double? width}) {
//   if (imageKey == null || imageKey.trim().isEmpty) {
//     return Container();
//   }
//   String accessTokenString = accessToken ?? "";
//   String imagePath = imageKey ?? "";
//   String currentPath = "$customUrlPath$imageKey";
//   if (customUrlPath == null) {
//     if (width != null) {
//       width = width * IMAGE_WIDTH_RATIO;
//     }
//     //currentPath = Global.convertMedia(imagePath, width?.round());
//   }
//
//   return FadeInImage(
//       fit: BoxFit.cover,
//       placeholder: const AssetImage(IconAssets.icLoading),
//       imageErrorBuilder: (context, error, stackTrace) {
//         return Image.asset(IconAssets.icWhite, fit: BoxFit.cover);
//       },
//       image: accessTokenString.isEmpty
//           ? NetworkImage(currentPath)
//           : NetworkImage(currentPath,
//           headers: {"Authorization": "Bearer " + accessTokenString}));
// }

// String getNetworkVideo(String url) {
//   if (url.isEmpty) return '';
//   return Global.convertVideoPath(url);
// }

/// Condition to check the email address
bool checkEmailAddress(String newEmail) {
  if (newEmail.isNotEmpty) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(newEmail);
  }
  return false;
}

/// stat reduction by 0.8
double toSize(double size) {
  return size * 0.95;
}

/// format date time to 'HH:mm, dd/MM/yyyy'
String formatDateTime(String dateTime) {
  return MyFormat.DateFormat(dateTimeFormat)
      .format(DateTime.parse((dateTime)).toLocal());
}

String formatTimeToHour(DateTime time) {
  return MyFormat.DateFormat('HH:mm').format(time.toLocal());
}

// String accentParser(String text) {
//   const String _vietnamese = 'aAeEoOuUiIdDyY';
//   final _vietnameseRegex = <RegExp>[
//     RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
//     RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
//     RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
//     RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
//     RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
//     RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
//     RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
//     RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
//     RegExp(r'ì|í|ị|ỉ|ĩ'),
//     RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
//     RegExp(r'đ'),
//     RegExp(r'Đ'),
//     RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
//     RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
//   ];
//   String result = text;
//   for (var i = 0; i < _vietnamese.length; ++i) {
//     result = result.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
//   }
//   return result;
// }

// final RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

final RegExp detectedHyperlink = RegExp(
    r"http[s]?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}(:[0-9]+)?(/[a-zA-Z0-9&%_./-~-]*)?");
