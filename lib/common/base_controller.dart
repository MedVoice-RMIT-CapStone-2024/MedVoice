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
}