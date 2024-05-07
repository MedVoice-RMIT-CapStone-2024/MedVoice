import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/assets/icon_assets.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../utils/global.dart';
import '../../../../utils/module_utils.dart';
import '../../../../utils/pages.dart';
import 'nurse_profile_controller.dart';

class NurseProfileView extends clean.View {
  NurseProfileView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NurseProfileView();
  }
}

class _NurseProfileView
    extends BaseStateView<NurseProfileView, NurseProfileController> {
  _NurseProfileView() : super(NurseProfileController());

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return "Profile";
  }

  @override
  bool isHideBackButton() {
    return true;
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    NurseProfileController _controller = controller as NurseProfileController;

    ThemeMode themeMode = ThemeMode.system;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    void toggleTheme(ThemeMode themeMode) {
      setState(() {
        themeMode = themeMode;
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: toSize(23)),
              Container(
                height: toSize(88),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: toSize(17), vertical: toSize(20)),
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(toSize(15))),
                child: Row(
                  children: [
                    Container(
                      height: toSize(48),
                      width: toSize(48),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7)),
                    ),
                    SizedBox(width: toSize(12)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nurse name",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary)),
                        Spacer(),
                        Text("nurse_email@email.com",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary)),
                      ],
                    ),
                    const Spacer(),
                    RotatedBox(
                      quarterTurns: 2,
                      child: SizedBox(
                        height: toSize(24),
                        width: toSize(24),
                        child: Image.asset(IconAssets.icBack,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.3)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: toSize(88),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: toSize(17), vertical: toSize(20)),
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(toSize(15))),
                child: InkWell(
                  onTap: () {
                    pushScreen(Pages.myQR);
                  },
                  child: Row(
                    children: [
                      Text("QR Code",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontSize: toSize(17))),
                      const Spacer(),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SizedBox(
                          height: toSize(24),
                          width: toSize(24),
                          child: Image.asset(IconAssets.icBack,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.3)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: toSize(17)),
              Container(
                height: toSize(260),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: toSize(17), vertical: toSize(20)),
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(toSize(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("What's New",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: toSize(17))),
                        const Spacer(),
                        RotatedBox(
                          quarterTurns: 2,
                          child: SizedBox(
                            height: toSize(24),
                            width: toSize(24),
                            child: Image.asset(IconAssets.icBack,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.3)),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.1)),
                    ),
                    Row(
                      children: [
                        Text("Version",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: toSize(17))),
                        const Spacer(),
                        Text(
                          "1.0.0",
                          style: TextStyle(fontSize: toSize(17)),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.1)),
                    ),
                    Row(
                      children: [
                        Text("Terms of Service",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: toSize(17))),
                        const Spacer(),
                        RotatedBox(
                          quarterTurns: 2,
                          child: SizedBox(
                            height: toSize(24),
                            width: toSize(24),
                            child: Image.asset(IconAssets.icBack,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.3)),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.1)),
                    ),
                    Row(
                      children: [
                        Text("Privacy Policy",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: toSize(17))),
                        const Spacer(),
                        RotatedBox(
                          quarterTurns: 2,
                          child: SizedBox(
                            height: toSize(24),
                            width: toSize(24),
                            child: Image.asset(IconAssets.icBack,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.3)),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.1)),
                    ),
                    Row(
                      children: [
                        Text("Privacy Policy",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: toSize(17))),
                        const Spacer(),

                        Switch(
                          value: isDarkMode,
                          onChanged: (isOn) {
                            isOn
                                ? toggleTheme(ThemeMode.dark)
                                : toggleTheme(ThemeMode.light);
                          },
                        ),

                        // RotatedBox(
                        //   quarterTurns: 2,
                        //   child: SizedBox(
                        //     height: toSize(24),
                        //     width: toSize(24),
                        //     child: Image.asset(IconAssets.icBack,
                        //         color: Theme.of(context)
                        //             .colorScheme
                        //             .onPrimary
                        //             .withOpacity(0.3)),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: toSize(100)),
                child: InkWell(
                  onTap: () {
                    pushScreen(Pages.signIn, isAllowBack: false);
                  },
                  child: Container(
                      height: toSize(64),
                      width: toSize(335),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(toSize(10)),
                          color: HexColor(Global.mColors['pink_1'].toString())),
                      child: Center(
                          child: Text("Sign out",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontSize: toSize(20))))),
                ),
              ),
            ],
          )),
    );
  }
}
