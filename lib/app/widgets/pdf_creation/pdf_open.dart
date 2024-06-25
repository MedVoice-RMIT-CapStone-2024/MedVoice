import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:med_voice/app/widgets/confirm_view.dart';
import 'package:med_voice/app/widgets/pdf_creation/pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart';

class PdfOpen {
  static Future saveDocument({
    required String name,
    required Document pdf,
    required BuildContext context,
  }) async {
    // var storagePermissionStatus = await Permission.storage.request();
    // PermissionStatus status = await Permission.manageExternalStorage.request();

    // if (status == PermissionStatus.denied ||
    //     status == PermissionStatus.permanentlyDenied) {
    //   if (Platform.isAndroid && status == PermissionStatus.denied) {
    //     debugPrint("Access denied status: ${status.name}");
    //     showDialog(
    //         context: context,
    //         barrierDismissible: false,
    //         builder: (BuildContext context) {
    //           return WillPopScope(
    //             onWillPop: () {
    //               return Future.value(false);
    //             },
    //             child: ConfirmView(
    //               title: null,
    //               message: "Please enable manage storage permission for PDF access",
    //               titleButton: "Settings",
    //               onPressEvent: () {
    //                 Navigator.pop(context);
    //                 openAppSettings();
    //               },
    //               titleSecondButton:
    //               "Cancel",
    //               onPressSecondEvent: () {
    //                 Navigator.pop(context);
    //               },
    //             ),
    //           );
    //         });
    //     return null;
    //   }
    // } else {
    //   debugPrint("Access status: ${status.name}");
      final bytes = await pdf.save();
        Directory? dir;
        if (Platform.isIOS) {
          dir = await getApplicationDocumentsDirectory();
        } else {
          dir = Directory('/storage/emulated/0/Download');
          if (!await dir.exists()) {
            dir = (await getExternalStorageDirectory());
          }
        }
        final file = File('${dir?.path ?? ""}/$name');
        await file.writeAsBytes(bytes);

        if (await File(file.path).exists()) {
          debugPrint("PATH: ${file.path}");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfViewerScreen(pdfFile: file),
            ),
          );
        }
    }
  }
// }