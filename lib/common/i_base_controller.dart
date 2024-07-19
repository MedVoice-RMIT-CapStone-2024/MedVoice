class IBaseController {
  void showLoadingProgress({String? loadingContent}) {}
  void hideLoadingProgress() {}
  void onListener() {}
  bool loadingState() {
    return false;
  }
}