import 'package:flutter/cupertino.dart';

class IBaseView {
  void onStateCreated() {}

  void onStateDestroyed() {}

  bool isInitialAppbar() {
    return true;
  }

  bool isKeepRetainViewMode() {
    return true;
  }

  bool isHideBackButton() {
    return false;
  }

  bool isShowBackground() {
    return true;
  }

  bool isShowLoadingOpacity() {
    return true;
  }

  List<Widget>? rightMenu() {
    return null;
  }

  int builderDelayTime() {
    return 0;
  }

  void pushScreen(String newScreen) {}

  Future<bool> onBackPressed() async {
    return false;
  }

  void onBack() {}

  void onBackWithData(Object data) {}

  void popBackToNative() {}

  void popRegistrationSuccessBackToNative() {}

  void showErrorFromServer(String? key) {}

  void showGenericPopup() {}

  void showGeneralToast(String message) {}

  void showPopupWithAction(String message, String okButton,
      [VoidCallback? okCallback,
        String? title,
        String? cancelButton,
        VoidCallback? cancelCallback]) {}

  bool isShowFeedbackFeature() {
    return false;
  }
}