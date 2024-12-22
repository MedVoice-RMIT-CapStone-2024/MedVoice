import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/assets/icon_assets.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../common/base_controller.dart';
import '../../../../../common/base_state_view.dart';
import '../../../../../data/repository_impl/nurse_data_control_repository_impl.dart';
import '../../../../utils/global.dart';
import '../../../../utils/module_utils.dart';
import '../../../../utils/pages.dart';
import 'nurse_profile_controller.dart';

class NurseProfileView extends clean.View {
  const NurseProfileView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NurseProfileView();
  }
}

class _NurseProfileView
    extends BaseStateView<NurseProfileView, NurseProfileController> {
  _NurseProfileView()
      : super(NurseProfileController(NurseDataControlRepositoryImpl()));

  ThemeData? theme;

  @override
  bool isInitialAppbar() {
    return true;
  }

  @override
  String appBarTitle() {
    return toText("nurseProfileProfile");
  }

  @override
  bool isHideBackButton() {
    return true;
  }

  @override
  bool isShowFeedbackFeature() {
    return true;
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    NurseProfileController _controller = controller as NurseProfileController;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: toSize(23)),
              InkWell(
                onTap: () {
                  pushScreen(Pages.nurseProfileDetail);
                },
                child: Container(
                  height: toSize(90),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: toSize(17), vertical: toSize(20)),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(toSize(10))),
                  child: Row(
                    children: [
                      Container(
                        height: toSize(48),
                        width: toSize(48),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7)),
                      ),
                      SizedBox(width: toSize(14)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              (Global.userCredentials.email != null &&
                                      Global.userCredentials.email!.isNotEmpty)
                                  ? Global.userCredentials.email!
                                  : "N/A",
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontFamily: 'Montserrat',
                                  fontSize: toSize(17),
                                  fontWeight: FontWeight.w500)),
                          const Spacer(),
                          Text(
                              (Global.userCredentials.id != null &&
                                      Global.userCredentials.id!.isNotEmpty)
                                  ? "User ID: ${Global.userCredentials.id!}"
                                  : "N/A",
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontFamily: 'Montserrat')),
                        ],
                      ),
                      const Spacer(),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SizedBox(
                          height: toSize(20),
                          width: toSize(20),
                          child: Image.asset(IconAssets.icBack,
                              color: theme.colorScheme.onSurface),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: toSize(60),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: toSize(17), vertical: toSize(20)),
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(toSize(10))),
                child: InkWell(
                  onTap: () {
                    pushScreen(Pages.myQR);
                  },
                  child: Row(
                    children: [
                      Text(toText("nurseProfileQRCode"),
                          style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: toSize(17),
                              fontFamily: 'Montserrat')),
                      const Spacer(),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SizedBox(
                          height: toSize(20),
                          width: toSize(20),
                          child: Image.asset(IconAssets.icBack,
                              color: theme.colorScheme.onSurface),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: toSize(17)),
              Container(
                height: toSize(120),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: toSize(17), vertical: toSize(20)),
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(toSize(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(toText("nurseProfileDarkMode"),
                            style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: toSize(17),
                                fontFamily: 'Montserrat')),
                        const Spacer(),
                        Consumer<ThemeProvider>(
                          builder: (context, themeProvider, child) {
                            return SizedBox(
                              height: toSize(10),
                              child: Switch(
                                value: themeProvider.isDarkMode,
                                onChanged: (value) {
                                  themeProvider.toggleTheme();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: toSize(5)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: theme.colorScheme.background.withOpacity(0.5)),
                    ),
                    SizedBox(height: toSize(5)),
                    Row(
                      children: [
                        Text(toText("nurseProfileBioAuth"),
                            style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: toSize(17),
                                fontFamily: 'Montserrat')),
                        const Spacer(),
                        SizedBox(
                          height: toSize(10),
                          child: Switch(
                            value: _controller.toggleBioAuth,
                            onChanged: (value) {
                              if (!_controller.toggleBioAuth) {
                                _controller.onTurningOnBioAuth();
                              } else {
                                _controller.onTurningOffBioAuth();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: toSize(17)),
              Container(
                height: toSize(240),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: toSize(17), vertical: toSize(20)),
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(toSize(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        pushScreen(Pages.chatBot);
                      },
                      child: Row(
                        children: [
                          Text(toText("nurseProfileAssistBot"),
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: toSize(17),
                                  fontFamily: 'Montserrat')),
                          const Spacer(),
                          RotatedBox(
                            quarterTurns: 2,
                            child: SizedBox(
                              height: toSize(20),
                              width: toSize(20),
                              child: Image.asset(IconAssets.icBack,
                                  color: theme.colorScheme.onSurface),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: toSize(5)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: theme.colorScheme.background.withOpacity(0.5)),
                    ),
                    SizedBox(height: toSize(5)),
                    Row(
                      children: [
                        Text(toText("nurseProfileVersion"),
                            style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: toSize(17),
                                fontFamily: 'Montserrat')),
                        const Spacer(),
                        Text(
                          "2.0.0",
                          style: TextStyle(
                              fontSize: toSize(17), fontFamily: 'Montserrat'),
                        )
                      ],
                    ),
                    SizedBox(height: toSize(5)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: theme.colorScheme.background.withOpacity(0.5)),
                    ),
                    SizedBox(height: toSize(5)),
                    InkWell(
                      onTap: () {
                        pushScreen(Pages.terms);
                      },
                      child: Row(
                        children: [
                          Text(toText("nurseProfileTermsOfService"),
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: toSize(17),
                                  fontFamily: 'Montserrat')),
                          const Spacer(),
                          RotatedBox(
                            quarterTurns: 2,
                            child: SizedBox(
                              height: toSize(20),
                              width: toSize(20),
                              child: Image.asset(IconAssets.icBack,
                                  color: theme.colorScheme.onSurface),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: toSize(5)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: theme.colorScheme.background.withOpacity(0.5)),
                    ),
                    SizedBox(height: toSize(5)),
                    InkWell(
                      onTap: () {
                        pushScreen(Pages.privacy);
                      },
                      child: Row(
                        children: [
                          Text(toText("nurseProfilePrivacyPolicy"),
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: toSize(17),
                                  fontFamily: 'Montserrat')),
                          const Spacer(),
                          RotatedBox(
                            quarterTurns: 2,
                            child: SizedBox(
                              height: toSize(20),
                              width: toSize(20),
                              child: Image.asset(IconAssets.icBack,
                                  color: theme.colorScheme.onSurface),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
