import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/app/pages/onboarding/signup/info/info_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/widgets/password_strength.dart';
import 'package:med_voice/app/widgets/small_text_field.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';
import 'package:med_voice/data/repository_impl/nurse_data_control_repository_impl.dart';
import 'package:provider/provider.dart';

import '../../../../assets/icon_assets.dart';
import '../../../../assets/image_assets.dart';
import '../../../../utils/pages.dart';

const isFromOnBoardingParam = "isFromOnBoardingParam";

class InfoView extends clean.View {
  final bool isFromOnBoarding;
  InfoView({Key? key, required this.isFromOnBoarding}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InfoView();
  }
}

class _InfoView extends BaseStateView<InfoView, InfoController> {
  _InfoView() : super(InfoController(NurseDataControlRepositoryImpl()));

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
    InfoController _controller = controller as InfoController;
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
                            SizedBox(height: toSize(25)),
                            Center(
                              child: Text("Account information",
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
                        labelText: "EMAIL ADDRESS",
                        hint: "Email address",
                        showIconButton: false,
                        validator: _controller.validateEmail,
                        controller: _controller.emailController,
                      ),
                      SizedBox(height: toSize(5)),
                      ValueListenableBuilder<bool>(
                        valueListenable: _controller.obscureText,
                        builder: (context, obscureText, child) {
                          return SmallTextField(
                            fillColor: theme.colorScheme.onPrimary,
                            labelText: "PASSWORD",
                            hint: "Password",
                            iconButton: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: theme.colorScheme.onBackground,
                              ),
                              onPressed: _controller.togglePasswordVisibility,
                            ),
                            showIconButton: true,
                            iconColor: theme.colorScheme.background,
                            validator: _controller.validatePassword,
                            controller: _controller.passwordController,
                            obscureText: obscureText,
                            onChanged:
                                _controller.updatePasswordStrength, // Add this
                          );
                        },
                      ),
                      ValueListenableBuilder<PasswordStrength>(
                        valueListenable: _controller.passwordStrengthNotifier,
                        builder: (context, strength, child) {
                          return Padding(
                            padding: EdgeInsets.only(top: toSize(10)),
                            child: PasswordStrengthIndicator(
                              strength: strength.strength,
                              strengthLabel: strength.strengthLabel,
                              theme: theme,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: toSize(3)),
                      ValueListenableBuilder<bool>(
                        valueListenable: _controller.obscureText,
                        builder: (context, obscureText, child) {
                          return SmallTextField(
                            hint: "Re-enter your password",
                            fillColor: theme.colorScheme.onPrimary,
                            labelText: "CONFIRM PASSWORD",
                            iconButton: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: theme.colorScheme.onBackground,
                              ),
                              onPressed: _controller.togglePasswordVisibility,
                            ),
                            showIconButton: true,
                            validator: _controller.validateConfirmPassword,
                            controller: _controller.confirmPasswordController,
                            obscureText: obscureText,
                          );
                        },
                      ),
                      SizedBox(height: toSize(20)),
                      InkWell(
                        onTap: () {
                          _controller.submitForm();
                        },
                        child: Container(
                          height: toSize(55),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(toSize(10)),
                              color: theme.colorScheme.primary),
                          child: Center(
                              child: Text("Sign Up",
                                  style: TextStyle(
                                      color: theme.colorScheme.onPrimary
                                          .withOpacity(0.9),
                                      fontSize: toSize(17),
                                      fontFamily: 'Rubik'))),
                        ),
                      ),
                      SizedBox(height: toSize(20)),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (widget.isFromOnBoarding) {
                              pushScreen(Pages.signIn);
                            } else {
                              onBack();
                            }
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
                      SizedBox(height: toSize(20))
                    ],
                  ),
                  (!widget.isFromOnBoarding)
                      ? Positioned(
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
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
