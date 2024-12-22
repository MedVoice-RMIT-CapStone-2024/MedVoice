import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:med_voice/common/base_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/base_state_view.dart';
import '../../../../../../domain/entities/nurse/nurse_register_request.dart';
import '../../../../../utils/module_utils.dart';
import '../../../../../utils/pages.dart';
import '../../../../../widgets/small_text_field.dart';
import '../../../../../widgets/theme_provider.dart';
import '../../../../onboarding/otp_verification/otp_verification_view.dart';
import 'change_nurse_email_controller.dart';

const nurseEmailItemRequest = 'nurseEmailItemRequest';

class ChangeNurseEmailView extends clean.View {
  final NurseRegisterRequest nurseEmailItemRequest;

  const ChangeNurseEmailView({Key? key, required this.nurseEmailItemRequest})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangeNurseEmailViewState(nurseEmailItemRequest);
  }
}

class _ChangeNurseEmailViewState
    extends BaseStateView<ChangeNurseEmailView, ChangeNurseEmailController> {
  _ChangeNurseEmailViewState(nurseEmailItemRequest)
      : super(ChangeNurseEmailController());

  ChangeNurseEmailController? _controller;

  @override
  String appBarTitle() {
    return toText("changeNurseEmailTitle");
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme = Provider.of<ThemeProvider>(context).themeData;
    _controller = controller as ChangeNurseEmailController;

    return SafeArea(
        child: Form(
      key: _controller?.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: toSize(20)),
        child: Column(
          children: [
            SizedBox(
              height: toSize(20),
            ),
            SmallTextField(
              fillColor: theme.colorScheme.onPrimary,
              labelText: toText("changeNurseEmailNewEmailAddress").toUpperCase(),
              hint: toText("changeNurseEmailNewEmailAddress"),
              validator: _controller?.validateEmail,
              showIconButton: false,
              controller: _controller!.emailController,
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                if (_controller!.submitForm()) {
                  pushScreen(Pages.otpVerification, arguments: {
                    isFromEmailChange: true,
                    isFromPasswordReset: false
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: toSize(55),
                margin: EdgeInsets.only(bottom: toSize(30)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme.colorScheme.primary),
                child: Center(
                  child: Text(toText("changeNurseEmailContinue").toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: toSize(15),
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
