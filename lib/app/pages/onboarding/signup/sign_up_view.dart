import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/pages/onboarding/signup/sign_up_controller.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../assets/icon_assets.dart';
import '../../../utils/module_utils.dart';
import '../../../utils/pages.dart';
import '../../../widgets/small_text_field.dart';


class SignUpView extends clean.View {

  SignUpView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpView();
  }
}

class _SignUpView extends BaseStateView<SignUpView, SignUpController> {
  _SignUpView() : super(SignUpController());
  DateTime selectedDate = DateTime.now();

  @override
  bool isInitialAppbar() {
    return false;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    SignUpController _controller = controller as SignUpController;
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _controller.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: toSize(22)),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: toSize(120)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: toSize(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(ImageAssets.medVoiceCroppedLogo,
                                  height: toSize(55)),
                              SizedBox(height: toSize(30)),
                              Center(
                                child: Text("Create Account",
                                    style: TextStyle(
                                        color: theme.colorScheme.onBackground,
                                        fontSize: toSize(35),
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Rubik')),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: toSize(25)),
                        SmallTextField(
                            fillColor: theme.colorScheme.onPrimary,
                            labelText: "FIRST NAME",
                            showIconButton: false,
                            validator: _controller.validateName,
                            hint: "First name",
                            controller: _controller.fNameController),
                        SizedBox(height: toSize(5)),
                        SmallTextField(
                            fillColor: theme.colorScheme.onPrimary,
                            labelText: "LAST NAME",
                            showIconButton: false,
                            validator: _controller.validateName,
                            hint: "Last name",
                            controller: _controller.lNameController),
                        SizedBox(height: toSize(35)),
                        InkWell(
                          onTap: () {
                            if (_controller.submitForm()) {
                              pushScreen(Pages.info, isAllowBack: true);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: toSize(55),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius:
                                    BorderRadius.circular(toSize(10))),
                            child: Center(
                                child: Text("Continue",
                                    style: TextStyle(
                                        color: theme.colorScheme.onPrimary
                                            .withOpacity(0.9),
                                        fontFamily: 'Rubik',
                                        fontSize: toSize(17)))),
                          ),
                        ),
                        SizedBox(height: toSize(23)),
                        Center(
                          child: InkWell(
                            onTap: () {
                              pushScreen(Pages.signIn);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Already registered?",
                                  style: TextStyle(
                                      color: theme.colorScheme.onBackground,
                                      fontSize: toSize(15),
                                      fontFamily: 'Rubik'),
                                ),
                                SizedBox(width: toSize(5)),
                                Text("Log in here.",
                                    style: TextStyle(
                                        color: theme.colorScheme.primary,
                                        fontSize: toSize(15),
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w900))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: toSize(30))
                      ],
                    ),
                    Positioned(
                      top: toSize(60),
                      left: toSize(12),
                      child: InkWell(
                        onTap: () {
                          onBack();
                        },
                        child: Image.asset(
                          IconAssets.icBack,
                          width: toSize(20),
                          height: toSize(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
