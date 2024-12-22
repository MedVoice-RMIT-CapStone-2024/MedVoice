import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/data/repository_impl/nurse_data_control_repository_impl.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/base_state_view.dart';
import '../../../../../assets/icon_assets.dart';
import '../../../../../utils/global.dart';
import '../../../../../utils/pages.dart';
import '../../../../../widgets/theme_provider.dart';
import '../change_nurse_email/change_nurse_email_view.dart';
import '../change_nurse_password/change_nurse_password_view.dart';
import 'nurse_profile_detail_controller.dart';

class NurseProfileDetailView extends clean.View {
  const NurseProfileDetailView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NurseProfileDetailView();
  }
}

class _NurseProfileDetailView extends BaseStateView<NurseProfileDetailView,
    NurseProfileDetailController> {
  _NurseProfileDetailView()
      : super(NurseProfileDetailController(NurseDataControlRepositoryImpl()));

  NurseProfileDetailController? _controller;

  @override
  String appBarTitle() {
    return toText("profileDetailProfileDetail");
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    _controller = controller as NurseProfileDetailController;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
          child: Column(
            children: [
              SizedBox(height: toSize(23)),
              Container(
                height: toSize(161),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: toSize(20), vertical: toSize(20)),
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(toSize(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(toText("profileDetailAccountID"),
                            style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: toSize(15),
                                fontFamily: 'Rubik')),
                        const Spacer(),
                        Text(Global.userCredentials.id.toString(),
                            style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: toSize(15),
                                fontFamily: 'Rubik')),
                      ],
                    ),
                    SizedBox(height: toSize(5)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: theme.colorScheme.background.withOpacity(0.5)),
                    ),
                    SizedBox(height: toSize(5)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          pushScreen(Pages.changeNurseEmail, arguments: {
                            nurseEmailItemRequest: Global.userCredentials
                          });
                        },
                        child: Row(
                          children: [
                            Text(toText("profileDetailChangeEmailAddress"),
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontSize: toSize(15),
                                    fontFamily: 'Rubik')),
                            const Spacer(),
                            RotatedBox(
                              quarterTurns: 2,
                              child: SizedBox(
                                height: toSize(10),
                                width: toSize(10),
                                child: Image.asset(IconAssets.icBack,
                                    color: theme.colorScheme.onSurface),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: toSize(5)),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                    //   child: Divider(
                    //       color: theme.colorScheme.background.withOpacity(0.5)),
                    // ),
                    // SizedBox(height: toSize(5)),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: InkWell(
                    //     onTap: () {
                    //       // TODO: Push screen to edit password
                    //       pushScreen(Pages.changeNursePassword, arguments: {
                    //         nursePasswordItemRequest: Global.userCredentials
                    //       });
                    //     },
                    //     child: Row(
                    //       children: [
                    //         Text("Change password",
                    //             style: TextStyle(
                    //                 color: theme.colorScheme.onSurface,
                    //                 fontSize: toSize(15),
                    //                 fontFamily: 'Rubik')),
                    //         const Spacer(),
                    //         RotatedBox(
                    //           quarterTurns: 2,
                    //           child: SizedBox(
                    //             height: toSize(10),
                    //             width: toSize(10),
                    //             child: Image.asset(IconAssets.icBack,
                    //                 color: theme.colorScheme.onSurface),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: toSize(5)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: toSize(8)),
                      child: Divider(
                          color: theme.colorScheme.background.withOpacity(0.5)),
                    ),
                    SizedBox(height: toSize(5)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          showPopupWithAction(
                              toText("nurseProfileDetailsDeletePopUp"),
                              toText("nurseProfileDetailsDeletePopUpConfirm"), () {
                            // TODO: Implement delete function
                            _controller?.onDeleteNurseAccount();
                          }, toText("nurseProfileDetailsDeletePopUpTitle"), toText("nurseProfileDetailsDeletePopUpCancel"), () {});
                        },
                        child: Row(
                          children: [
                            Text(toText("profileDetailDeleteAccount"),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: toSize(15),
                                    fontFamily: 'Rubik')),
                            const Spacer(),
                            RotatedBox(
                              quarterTurns: 2,
                              child: SizedBox(
                                height: toSize(10),
                                width: toSize(10),
                                child: Image.asset(IconAssets.icBack,
                                    color: theme.colorScheme.onSurface),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  pushScreen(Pages.signIn, isAllowBack: false);
                },
                child: Container(
                  height: toSize(60),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: toSize(17), vertical: toSize(18)),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      border: Border.all(color: theme.colorScheme.surface),
                      borderRadius: BorderRadius.circular(toSize(10))),
                  child: Center(
                    child: Text(toText("profileDetailSignOut"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: toSize(15),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Rubik')),
                  ),
                ),
              ),
              SizedBox(height: toSize(30)),
            ],
          ),
        ),
      ),
    );
  }
}
