import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/pages/home/user_profile/nurse_profile/nurse_profile_view.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/module_utils.dart';
import '../../../utils/shared_preferences.dart';
import '../../../widgets/theme_provider.dart';
import '../medical_archive/medical_archive_view.dart';
import '../recording/recording/recording_view.dart';
import '../recording/recording_android/recording_android_view.dart';
import 'main_controller.dart';

class MainView extends clean.View {
  const MainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainView();
  }
}

class _MainView extends BaseStateView<MainView, MainController> {
  _MainView() : super(MainController());

  MainController? mMainController;

  @override
  bool isInitialAppbar() {
    return false;
  }

  List<Widget>? tabs;

  onTapped(int index) {
    mMainController!.currentTabIndex = index;
    mMainController!.refreshUI();
  }

  @override
  void onStateCreated() async {
    tabs = [
      // Adding your Views here, remember to position it the same as the index you assigned below
      const MedicalArchiveView(),
      (Platform.isIOS) ? RecordingView() : const RecordingAndroidView(),
      NurseProfileView(),
    ];
    if (await SharedPreferencesHelper().getBoolValue(
        SharedData.APP_FIRST_INSTALL.toString(),
        defaultValue: true)) {
      createTutorial();
      Future.delayed(Duration.zero, showTutorial);
      SharedPreferencesHelper()
          .setBoolValue(SharedData.APP_FIRST_INSTALL.toString(), false);
      mMainController?.refreshUI();
    }
    super.onStateCreated();
  }

  @override
  void onStateDestroyed() {}

  @override
  String appBarTitle() {
    return "";
  }

  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyNavigation1 = GlobalKey();
  GlobalKey keyNavigation2 = GlobalKey();
  GlobalKey keyNavigation3 = GlobalKey();

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.red,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        debugPrint("finish");
      },
      onClickTarget: (target) {
        debugPrint('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        debugPrint("target: $target");
        debugPrint(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        debugPrint('onClickOverlay: $target');
      },
      onSkip: () {
        debugPrint("skip");
        return true;
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "keyNavigation",
        targetPosition: TargetPosition(
            const Size(0, 0),
            Offset(MediaQuery.of(context).size.width * 1.25,
                MediaQuery.of(context).size.height * 1.25)),
        focusAnimationDuration: const Duration(seconds: 5),
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: toSize(300),
                      height: toSize(200),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(toSize(25))),
                      child: ClipRRect(
                          child: Image.asset(ImageAssets.imgMedVoiceLogo))),
                  SizedBox(height: toSize(30)),
                  Text(
                    "Welcome to Medvoice",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Rubik',
                        fontSize: toSize(25),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 1.75)
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyNavigation1",
        targetPosition: TargetPosition(
            const Size(40, 40),
            Offset(MediaQuery.of(context).size.width * 0.115,
                MediaQuery.of(context).size.height * 0.92)),
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const Text(
                    "Storing/Viewing patients' audio items you have recorded",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: toSize(50))
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyNavigation2",
        keyTarget: keyNavigation2,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Recording new patient audios",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: toSize(50))
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyNavigation3",
        keyTarget: keyNavigation3,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "View/Adjust your profiling",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: toSize(50))
                ],
              );
            },
          ),
        ],
      ),
    );
    return targets;
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    return _body(controller, theme);
  }

  Widget _body(BaseController controller, ThemeData theme) {
    mMainController = controller as MainController;
    return Stack(children: [
      tabs![mMainController!.currentTabIndex],
      MediaQuery.of(context).orientation == Orientation.portrait
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: Colors.transparent,
                    primaryColor: Colors.transparent),
                child: Container(
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                            //offset: Offset(0, 4),
                            color: Colors.black.withOpacity(0.1), //edited
                            spreadRadius: 2,
                            blurRadius: 11 //edited
                            )
                      ],
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  height: 82,
                  child: BottomNavigationBar(
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    onTap: onTapped,
                    currentIndex: mMainController!.currentTabIndex,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: [
                      // Add _tab([index], [asset location], [title underneath the icon]
                      _tab(0, "assets/main_assets/ic_medical_archive",
                          "Archive", theme, keyNavigation1),
                      _tab(1, "assets/main_assets/ic_voice_recording", "Record",
                          theme, keyNavigation2),
                      _tab(2, "assets/main_assets/ic_nurse_profile", "Profile",
                          theme, keyNavigation3),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
      //     : Container(),
    ]);
  }

  BottomNavigationBarItem _tab(int index, String? imageAsset, String namePage,
      ThemeData theme, Key? key) {
    return BottomNavigationBarItem(
      icon: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Column(
                key: key,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                    imageAsset == "" ? null : AssetImage("${imageAsset!}.png"),
                    color: theme.colorScheme.secondary,
                    size: 18,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    namePage,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: theme.colorScheme.secondary.withOpacity(0.7),
                    ),
                  )
                ],
              )),
        ],
      ),
      activeIcon: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Column(
                key: key,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                    imageAsset == "" ? null : AssetImage("${imageAsset!}.png"),
                    color: theme.colorScheme.onSecondary,
                    size: 22,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    namePage,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      color: theme.colorScheme.onSecondary,
                    ),
                  )
                ],
              )),
        ],
      ),
      label: "",
    );
  }
}
