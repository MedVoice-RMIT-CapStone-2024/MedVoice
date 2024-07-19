import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../app/assets/icon_assets.dart';
import '../app/utils/global.dart';
import '../app/utils/module_utils.dart';
import '../app/utils/router.dart';
import '../app/widgets/confirm_view.dart';
import '../app/widgets/theme_provider.dart';
import 'base_controller.dart';
import 'i_base_view.dart';

abstract class BaseStateView<Page extends clean.View,
        controller extends BaseController>
    extends clean.ViewState<Page, controller>
    with WidgetsBindingObserver
    implements IBaseView {
  final AppRouter _router = AppRouter();

  bool _isDelayed = false;
  Object? _mBackData;

  BaseStateView(controller mController) : super(mController) {
    mController.initView(this);
  }

  void setBackData(Object backData) {
    _mBackData = null;
    _mBackData = backData;
  }

  @override
  void onBackWithData(Object? data) {}

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  bool isKeepRetainViewMode() {
    return true;
  }

  String appBarTitle();

  @Deprecated("Please use onStateDestroyed() instead")
  @override
  void dispose() {
    onStateDestroyed();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Global.isAppInForeground = true;
        debugPrint("Test notification app in resumed");
        break;
      case AppLifecycleState.inactive:
        Global.isAppInForeground = false;
        debugPrint("Test notification app in inactive");
        break;
      case AppLifecycleState.paused:
        Global.isAppInForeground = false;
        debugPrint("Test notification app in paused");
        break;
      case AppLifecycleState.detached:
        debugPrint("Test notification app in detached");
        break;
    }
  }

  @Deprecated("Please use onStateCreated() instead")
  @override
  void initState() {
    Future.delayed(
        Duration(milliseconds: builderDelayTime()), () => onStateCreated());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  int builderDelayTime() {
    return 200;
  }

  @override
  bool isShowBackground() {
    return true;
  }

  @override
  void onStateCreated() {}

  @override
  void onStateDestroyed() {}

  @override
  bool get wantKeepAlive => isKeepRetainViewMode();

  @override
  bool isShowLoadingOpacity() {
    return true;
  }

  @override
  void popBackToNative() {}

  @override
  void popRegistrationSuccessBackToNative() {}

  @override
  void onBack({String? screenName}) {
    if (screenName != null) {
      Navigator.popUntil(context, ModalRoute.withName(screenName));
    } else {
      if (_mBackData == null) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context, _mBackData);
        /**
         * reset data after using
         */
        _mBackData = null;
      }
    }
  }

  @override
  bool isHideBackButton() {
    return false;
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }

  @override
  List<Widget>? rightMenu() {
    return null;
  }

  @override
  void pushScreen(String pageName,
      {bool isAllowBack = true, Object? arguments}) {
    CupertinoPageRoute? newScreen =
        _router.getRoute(RouteSettings(name: pageName, arguments: arguments));
    if (newScreen != null) {
      if (isAllowBack) {
        Navigator.push(context, newScreen).then((value) {
          onBackWithData(value);
        });
      } else {
        Navigator.pushAndRemoveUntil(context, newScreen, (route) => false)
            .then((value) => {onBackWithData(value)});
      }
    }
  }

  Widget get view =>
      clean.ControlledWidgetBuilder<controller>(builder: (context, controller) {
        ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
        Future.delayed(Duration(milliseconds: builderDelayTime()), () {
          if (!_isDelayed && mounted) {
            setState(() {
              _isDelayed = true;
            });
            controller.firstLoad();
          }
        });

        return WillPopScope(
            onWillPop: onBackPressed,
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ModalProgressHUD(
                  inAsyncCall: controller.loadingState(),
                  progressIndicator: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(color: Colors.white),
                          const SizedBox(height: 20),
                          Text(
                            controller.baseLoadingContent,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontFamily: 'Rubik'
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  opacity: isShowLoadingOpacity()
                      ? 0.3 // default value
                      : 0,
                  child: Container(
                    decoration: (isShowBackground())
                        ? BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                          )
                        : null,
                    child: Scaffold(
                      key: globalKey,
                      backgroundColor: Colors.transparent,
                      appBar: (isInitialAppbar() &&
                              MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                          ? AppBar(
                              backgroundColor:
                                  theme.primaryColor,
                              centerTitle: true,
                              title: Text(appBarTitle(),
                                  style: const TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                              leading: !isHideBackButton()
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: IconButton(
                                        onPressed: () {
                                          if (Global.isAvailableToClick()) {
                                            onBack();
                                          }
                                        },
                                        icon: Image.asset(IconAssets.icBack,
                                            width: 11, height: 16, color: theme.colorScheme.onSurface),
                                        alignment: Alignment.center,
                                      ),
                                    )
                                  : Container(),
                              elevation: 0,
                              actions: rightMenu(),
                        bottom: PreferredSize(
                          preferredSize: Size(MediaQuery.of(context).size.width, 1),
                          child: Divider(
                            color: Colors.black.withOpacity(0.1),
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                            )
                          : null,
                      body: (_isDelayed)
                          ? body(context, controller)
                          : Container(),
                    ),
                  ),
                )));
        // return body(context);
      });

  Widget body(BuildContext context, BaseController controller);

  @override
  void showErrorFromServer(String? key, {BuildContext? viewContext}) {
    Future.delayed(
      const Duration(microseconds: 200),
      () {
        ScaffoldMessenger.of(viewContext ?? context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            duration: const Duration(milliseconds: 3000),
            content: SizedBox(
              width: MediaQuery.of(viewContext ?? context).size.width,
              height: MediaQuery.of(viewContext ?? context).size.height,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: HexColor(Global.mColors['black_3'].toString()),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 11, 0, 11),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(IconAssets.icErrorServer,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
                            child: Text(
                              key!,
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Rubik',
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void showGeneralToast(String message) {
    Future.delayed(
      const Duration(microseconds: 500),
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message, style: const TextStyle(fontFamily: 'Rubik')),
          ),
        );
      },
    );
  }

  bool _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  bool isShowPopupAction = false;

  @override
  void showPopupWithAction(
    String message,
    String okButton, [
    VoidCallback? okCallback,
    String? title,
    String? cancelButton,
    VoidCallback? cancelCallback,
  ]) {
    if (_isThereCurrentDialogShowing(context)) {
      return;
    }
    isShowPopupAction = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: ConfirmView(
              title: title,
              message: message,
              titleButton: okButton,
              onPressEvent: () {
                Navigator.pop(context);
                if (okCallback != null) {
                  okCallback();
                }
              },
              titleSecondButton: cancelButton,
              onPressSecondEvent: () {
                Navigator.pop(context);
                if (cancelCallback != null) {
                  cancelCallback();
                }
              },
            ),
          );
        }).then((value) => {isShowPopupAction = false});
  }

  void showSaveRecordingPopup(
      String message,
      String okButton,
      String cancelButton,
      VoidCallback okCallback,
      VoidCallback cancelCallback,
      TextEditingController saveNameController,
      ) {
    ThemeData theme = Provider.of<ThemeProvider>(context, listen: false).themeData;
    if (_isThereCurrentDialogShowing(context)) {
      return;
    }
    isShowPopupAction = true;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(toSize(20))),
            backgroundColor: theme.colorScheme.background,
            elevation: 0,
            title: Text(message, style: TextStyle(fontSize: toSize(20), color: theme.colorScheme.onBackground, fontFamily: 'Rubik')),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  hintText: 'Enter your patient name here'),
              style: TextStyle(color: theme.colorScheme.onBackground),
              controller: saveNameController,
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: cancelCallback,
                        child: Container(
                          height: toSize(32),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            color: theme.colorScheme.surface
                              ),
                          child: Center(
                            child: Text(cancelButton, style: TextStyle(color: theme.colorScheme.onSurface, fontFamily: 'Rubik')),
                          ),
                        ),
                      )),
                  SizedBox(width: toSize(10)),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: okCallback,
                        child: Container(
                          height: toSize(32),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              color: theme.colorScheme.primary),
                          child: Center(child: Text(okButton, style: TextStyle(color: theme.colorScheme.onPrimary))),
                        ),
                      ))
                ],
              )
            ],
          );
        }).then((value) => {isShowPopupAction = false});
  }

  @override
  void showGenericPopup() {
    showPopupWithAction("An error has occurred, please try again later.", "Okay");
  }

  void onGeneralError(e) {
    if (e.toString().isEmpty) {
      showGenericPopup();
    } else {
      showErrorFromServer(e);
    }
  }
}
