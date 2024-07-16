import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:hexcolor/hexcolor.dart';
import 'package:med_voice/app/assets/image_assets.dart';
import 'package:med_voice/app/pages/onboarding/signup/info/info_controller.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/app/utils/pages.dart';
import 'package:med_voice/app/widgets/password_strength.dart';
import 'package:med_voice/app/widgets/small_text_field.dart';
import 'package:med_voice/app/widgets/theme_provider.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/common/base_state_view.dart';
import 'package:provider/provider.dart';

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
    return true;
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    InfoController _controller = controller as InfoController;
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    return Form(
      key: _controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SmallTextField(
            fillColor: theme.colorScheme.onPrimary,
            labelText: "EMAIL ADDRESS",
            hint: "Enter your email address",
            showIconButton: false,
            validator: _controller.validateEmail,
            controller: _controller.emailController,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _controller.obscureText,
            builder: (context, obscureText, child) {
              return SmallTextField(
                fillColor: theme.colorScheme.onPrimary,
                labelText: "PASSWORD",
                hint: "Enter your password",
                iconButton: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: theme.colorScheme.onBackground,
                  ),
                  onPressed: _controller.togglePasswordVisibility,
                ),
                showIconButton: true,
                iconColor: theme.colorScheme.background,
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
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: PasswordStrengthIndicator(
                  strength: strength.strength,
                  strengthLabel: strength.strengthLabel,
                ),
              );
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _controller.obscureText,
            builder: (context, obscureText, child) {
              return SmallTextField(
                hint: "Re-enter your password",
                fillColor: theme.colorScheme.onPrimary,
                labelText: "CONFIRM PASSWORD",
                iconButton: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
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
          Padding(
            padding: EdgeInsets.all(toSize(20)),
            child: ElevatedButton(
              onPressed: () {
                if (_controller.submitForm()) {
                  pushScreen(Pages.signIn, isAllowBack: false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                fixedSize: Size(size.width * 0.75, toSize(50)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: theme.colorScheme.surface,
                  fontSize: toSize(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
