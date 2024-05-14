import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/pages/onboarding/signup/info/info_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/utils/pages.dart';
import 'package:med_voice/app/widgets/custom_scaffold.dart';
import 'package:med_voice/app/widgets/password_strength.dart';
import 'package:med_voice/app/widgets/small_text_field.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';

class InfoView extends clean.View {
  InfoView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InfoView();
  }
}

class _InfoView extends BaseStateView<InfoView, InfoController> {
  _InfoView() : super(InfoController());

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
    final Size size = MediaQuery.of(context).size;

    return CustomScaffold(
      link: ImageAssets.imgBg3,
      child: Form(
        key: _controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmallTextField(
              labelText: "EMAIL ADDRESS",
              showIconButton: false,
              validator: _controller.validateEmail,
              controller: _controller.emailController,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _controller.obscureText,
              builder: (context, obscureText, child) {
                return SmallTextField(
                  labelText: "PASSWORD",
                  iconButton: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: _controller.togglePasswordVisibility,
                  ),
                  showIconButton: true,
                  validator: _controller.validatePassword,
                  controller: _controller.passwordController,
                  obscureText: obscureText,
                  onChanged: _controller.updatePasswordStrength, // Add this
                );
              },
            ),
            ValueListenableBuilder<PasswordStrength>(
              valueListenable: _controller.passwordStrengthNotifier,
              builder: (context, strength, child) {
                return PasswordStrengthIndicator(
                  strength: strength.strength,
                  strengthLabel: strength.strengthLabel,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _controller.obscureText,
              builder: (context, obscureText, child) {
                return SmallTextField(
                  labelText: "CONFIRM PASSWORD",
                  iconButton: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
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
            Padding(
              padding: EdgeInsets.all(toSize(20)),
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.submitForm()) {
                    pushScreen(Pages.signIn, isAllowBack: false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#EC4B8B"),
                  fixedSize: Size(size.width * 0.75, toSize(50)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: HexColor("#FFFDF5"),
                    fontSize: toSize(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
