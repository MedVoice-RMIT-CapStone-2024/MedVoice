import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/assets/icon_assets.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

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
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: toSize(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: toSize(23)),
                Container(
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
                      SizedBox(width: toSize(12)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nurse name",
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface)),
                          const Spacer(),
                          Text("nurse_email@email.com",
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface)),
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
                        Text("QR Code",
                            style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: toSize(17))),
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
                  height: toSize(60),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: toSize(17), vertical: toSize(20)),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(toSize(10))),
                  child: Row(
                    children: [
                      Text("Dark Mode",
                          style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: toSize(17))),
                      const Spacer(),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, child) {
                          return Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) {
                              themeProvider.toggleTheme();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: toSize(17)),
                Container(
                  height: toSize(269),
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
                            Text("What's New",
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontSize: toSize(17))),
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
                            color:
                                theme.colorScheme.background.withOpacity(0.5)),
                      ),
                      SizedBox(height: toSize(5)),
                      Row(
                        children: [
                          Text("Version",
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: toSize(17))),
                          const Spacer(),
                          Text(
                            "1.0.0",
                            style: TextStyle(fontSize: toSize(17)),
                          )
                        ],
                      ),
                      SizedBox(height: toSize(5)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                        child: Divider(
                            color:
                                theme.colorScheme.background.withOpacity(0.5)),
                      ),
                      SizedBox(height: toSize(5)),
                      InkWell(
                        onTap: () {
                          pushScreen(Pages.terms);
                        },
                        child: Row(
                          children: [
                            Text("Terms of Service",
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontSize: toSize(17))),
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
                            color:
                                theme.colorScheme.background.withOpacity(0.5)),
                      ),
                      SizedBox(height: toSize(5)),
                      InkWell(
                        onTap: () {
                          pushScreen(Pages.privacy);
                        },
                        child: Row(
                          children: [
                            Text("Privacy Policy",
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontSize: toSize(17))),
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
                            color:
                                theme.colorScheme.background.withOpacity(0.5)),
                      ),
                      SizedBox(height: toSize(5)),
                      InkWell(
                        onTap: () {
                          pushScreen(Pages.signIn, isAllowBack: false);
                        },
                        child: Row(
                          children: [
                            Text("Sign out",
                                style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontSize: toSize(17),
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
