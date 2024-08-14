import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;

import 'package:med_voice/app/pages/onboarding/login/sign_in_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';

import '../../../assets/image_assets.dart';
import '../../../utils/pages.dart';
import '../../../widgets/small_text_field.dart';
import '../signup/sign_up_view.dart';

class SignInView extends clean.View {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignInView();
  }
}

class _SignInView extends BaseStateView<SignInView, SignInController> {
  _SignInView() : super(SignInController());
  bool obscureText = true;

  @override
  bool isInitialAppbar() {
    return false;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  bool isHideBackButton() {
    return false;
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    SignInController _controller = controller as SignInController;
    final theme = Provider.of<ThemeProvider>(context).themeData;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _controller.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: toSize(20)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: toSize(120)),
                      Image.asset(ImageAssets.medVoiceCroppedLogo,
                          height: toSize(55)),
                      SizedBox(height: toSize(50)),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: theme.colorScheme.onBackground,
                                  fontSize: toSize(50),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                            Text(
                              "Sign in to continue",
                              style: TextStyle(
                                  color: theme.colorScheme.onBackground,
                                  fontSize: toSize(15),
                                  fontFamily: 'Rubik'
                                  // fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: toSize(20)),
                      SmallTextField(
                        fillColor: theme.colorScheme.onPrimary,
                        labelText: "EMAIL ADDRESS",
                        hint: "Enter your email",
                        validator: _controller.validateEmail,
                        showIconButton: false,
                        controller: _controller.emailController,
                      ),
                      SizedBox(height: toSize(5)),
                      SmallTextField(
                        fillColor: theme.colorScheme.onPrimary,
                        obscureText: obscureText,
                        hint: "Enter your password",
                        labelText: "PASSWORD",
                        iconButton: IconButton(
                          icon: Icon(
                            obscureText == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: theme.colorScheme.onBackground,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                        showIconButton: true,
                        validator: _controller.validatePassword,
                        controller: _controller.passwordController,
                      ),
                      SizedBox(height: toSize(13)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            pushScreen(Pages.reset);
                          },
                          child: Text("Forgot password?",
                              style: TextStyle(
                                  color: theme.colorScheme.onBackground,
                                  fontSize: toSize(13),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Rubik')),
                        ),
                      ),
                      SizedBox(height: toSize(23)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                if (_controller.submitForm()) {
                                  pushScreen(Pages.main, isAllowBack: false);
                                }
                              },
                              child: Container(
                                height: toSize(50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: theme.colorScheme.primary),
                                child: Center(
                                    child: Text("Log In",
                                        style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: toSize(17),
                                            color: theme.colorScheme.onPrimary.withOpacity(0.9)))),
                              ),
                            ),
                          ),
                          SizedBox(width: toSize(15)),
                          InkWell(
                            onTap: () async {
                              _controller.onLogInThroughBioAuth();
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: toSize(4)),
                                child:
                                    Icon(Icons.fingerprint, size: toSize(45))),
                          )
                        ],
                      ),
                      SizedBox(height: toSize(23)),
                      Center(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                pushScreen(Pages.signUp,
                                    arguments: {isFromOnBoardingParam: false});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Don't have an account?",
                                      style: TextStyle(
                                          color: theme.colorScheme.onBackground,
                                          fontSize: toSize(15),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Rubik')),
                                  SizedBox(width: toSize(5)),
                                  Text("Register now",
                                      style: TextStyle(
                                          color: theme.colorScheme.primary,
                                          fontSize: toSize(15),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Rubik')),
                                ],
                              ),
                            ),
                            SizedBox(height: toSize(20))
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
