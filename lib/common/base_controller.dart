import 'dart:io';
import 'dart:typed_data';

import 'package:feedback/feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

import 'base_state_view.dart';
import 'i_base_controller.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

abstract class BaseController extends Controller implements IBaseController {
  bool isLoading = false;
  String baseLoadingContent = 'Loading, please wait...';
  late BaseStateView view;

  void initView(BaseStateView pageView) {
    view = pageView;
    //handleNotificationOnForeground();
  }

  BaseStateView getView() {
    return view;
  }

  void firstLoad();

  @override
  void initListeners() {
    onListener();
  }

  @override
  void onResumed() {}

  @override
  void hideLoadingProgress() {
    isLoading = false;
    refreshUI();
  }

  @override
  void showLoadingProgress({String? loadingContent}) {
    isLoading = true;
    baseLoadingContent = loadingContent ?? 'Loading, please wait...';
    refreshUI();
  }

  @override
  bool loadingState() {
    return isLoading;
  }

  void submittingFeedback(BuildContext context) async {

    BetterFeedback.of(context).show((UserFeedback feedback) async {
      final screenshotFilePath = await writeImageToStorage(feedback.screenshot);
      final Email email = Email(
        body: feedback.text,
        subject: 'App Feedback',
        recipients: ['s3803566@rmit.edu.vn'],
        attachmentPaths: [screenshotFilePath],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
        debugPrint("Email sent successfully!");
      } catch (error) {
        debugPrint("Email sent failed!: ${error.toString()}");
        view.onGeneralError(error);
      }
    });
  }

  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }
}
