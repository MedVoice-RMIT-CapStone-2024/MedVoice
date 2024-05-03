import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/pages/home/user_profile/nurse_profile/nurse_profile_view.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../utils/global.dart';
import '../medical_archive/medical_archive_view.dart';
import '../recording_documentation/recording/recording_view.dart';
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
  void onStateCreated() {
    tabs = [
      // Adding your Views here, remember to position it the same as the index you assigned below
      const MedicalArchiveView(),
      RecordingView(),
      NurseProfileView(),
    ];
  }

  @override
  void onStateDestroyed() {}

  @override
  String appBarTitle() {
    return "";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    return _body(controller);
  }

  Widget _body(BaseController controller) {
    mMainController = controller as MainController;
    return Stack(children: [
      tabs![mMainController!.currentTabIndex],
      MediaQuery.of(context).orientation == Orientation.portrait
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: Theme.of(context).copyWith(
                    // sets the background color of the `BottomNavigationBar`
                    canvasColor: Colors.transparent,
                    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                    primaryColor: Colors.transparent),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        //offset: Offset(0, 4),
                        color: Colors.black.withOpacity(0.1), //edited
                        spreadRadius: 2,
                        blurRadius: 11 //edited
                        )
                  ]),
                  height: 80,
                  child: BottomNavigationBar(
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    onTap: onTapped,
                    backgroundColor: Colors.transparent,
                    currentIndex: mMainController!.currentTabIndex,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: [
                      // Add _tab([index], [asset location], [title underneath the icon]
                      _tab(0, "assets/main_assets/ic_medical_archive",
                          "Archive"),
                      _tab(
                          1, "assets/main_assets/ic_voice_recording", "Record"),
                      _tab(2, "assets/main_assets/ic_nurse_profile", "Profile"),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
      //     : Container(),
    ]);
  }

  BottomNavigationBarItem _tab(int index, String? imageAsset, String namePage) {
    int badgeNumber = -1;
    if (index == 0 || index == 1 || index == 3 || index == 4) {
      badgeNumber = 0;
    } else {
      // Future implementation
    }
    return BottomNavigationBarItem(
      icon: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                    imageAsset == "" ? null : AssetImage("${imageAsset!}.png"),
                    color: HexColor(Global.mColors["pink_1"].toString()),
                    size: 18,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    namePage,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: HexColor(Global.mColors["pink_1"].toString())
                          .withOpacity(0.6),
                    ),
                  )
                ],
              )),
          if (badgeNumber > 0)
            Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Center(
                  child: Text(
                    badgeNumber > 9 ? "9+" : badgeNumber.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
        ],
      ),
      activeIcon: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageIcon(
                    imageAsset == "" ? null : AssetImage("${imageAsset!}.png"),
                    color: HexColor(Global.mColors["pink_1"].toString()),
                    size: 22,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    namePage,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      color: HexColor(Global.mColors["pink_1"].toString()),
                    ),
                  )
                ],
              )),
          if (badgeNumber > 0)
            Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Center(
                  child: Text(
                    badgeNumber > 9 ? "9+" : badgeNumber.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
        ],
      ),
      label: "",
    );
  }
}
