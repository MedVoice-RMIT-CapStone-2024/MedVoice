import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
as clean;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/widgets/pdf_creation/pdf_view_controller.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';

class PdfViewerScreen extends clean.View {
  final File pdfFile;
  const PdfViewerScreen({Key? key, required this.pdfFile}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PdfViewerScreen();
  }
}

class _PdfViewerScreen extends BaseStateView<PdfViewerScreen, PdfViewerScreenController> {
  _PdfViewerScreen() : super(PdfViewerScreenController());

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "PDF Document";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme = Provider.of<ThemeProvider>(context, listen: false).themeData;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(toSize(10)),
          child: PDFView(
            filePath: widget.pdfFile.path,
          ),
        ),
      ),
    );
  }
}
