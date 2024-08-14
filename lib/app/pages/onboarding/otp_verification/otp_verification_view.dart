import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:med_voice/app/utils/module_utils.dart';
import 'package:med_voice/data/repository_impl/nurse_data_control_repository_impl.dart';
import 'package:provider/provider.dart';

import '../../../../common/base_controller.dart';
import '../../../../common/base_state_view.dart';
import '../../../assets/icon_assets.dart';
import '../../../assets/image_assets.dart';
import '../../../widgets/theme_provider.dart';
import 'otp_verification_controller.dart';

const userEmailAddress = 'userEmailAddress';

class OtpVerificationView extends clean.View {
  final String userEmailAddress;
  const OtpVerificationView({Key? key, required this.userEmailAddress})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OtpVerificationView(userEmailAddress);
  }
}

class _OtpVerificationView
    extends BaseStateView<OtpVerificationView, OtpVerificationController>
    with SingleTickerProviderStateMixin {
  _OtpVerificationView(userEmailAddress)
      : super(OtpVerificationController(
            NurseDataControlRepositoryImpl(), userEmailAddress));

  OtpVerificationController? _controller;

  @override
  bool isInitialAppbar() {
    return false;
  }

  @override
  String appBarTitle() {
    return '';
  }

  @override
  Widget body(BuildContext context, BaseController controller) {
    ThemeData theme =
        Provider.of<ThemeProvider>(context, listen: false).themeData;
    _controller = controller as OtpVerificationController;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: toSize(20)),
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
                            child: Text("Email Verification",
                                style: TextStyle(
                                    color: theme.colorScheme.onBackground,
                                    fontSize: toSize(35),
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Rubik')),
                          ),
                          SizedBox(height: toSize(10)),
                          const Center(
                            child: Text("Enter the 5-digit OTP code we have sent to:",
                                style: TextStyle(fontFamily: 'Rubik')),
                          ),
                          SizedBox(height: toSize(5)),
                          Center(
                            child: Text(widget.userEmailAddress,
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: toSize(16),
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: toSize(30)),
                    Center(child: _buildTimer(theme, _controller!.otpDuration, false)),
                    SizedBox(height: toSize(20)),
                    OtpTextField(
                      numberOfFields: 5,
                      autoFocus: _controller!.isSent,
                      margin: EdgeInsets.symmetric(horizontal: toSize(5)),
                      borderRadius: BorderRadius.circular(toSize(10)),
                      enabledBorderColor: theme.colorScheme.onSurface.withOpacity(0.6),
                      focusedBorderColor: theme.colorScheme.primary,
                      showFieldAsBox: true,
                      fieldHeight: toSize(60),
                      fieldWidth: toSize(55),
                      contentPadding: EdgeInsets.all(toSize(16)),
                      onCodeChanged: (String code) {},
                      onSubmit: (String verificationCode) {
                        _controller!.otpVerification(verificationCode);
                      },
                      textStyle: const TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w600),

                    ),
                    SizedBox(height: toSize(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Did not receive a code?",
                            style: TextStyle(fontFamily: 'Rubik', fontSize: toSize(15))),
                        SizedBox(width: toSize(5)),
                        InkWell(
                            onTap: () {
                              if (_controller!.isAvailableToClick) {
                                _controller!.isAvailableToClick = false;
                                _controller!.sendOtp(widget.userEmailAddress);
                                _controller!.refreshUI();
                              }
                            },
                            child: Text("Resend",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: (_controller!.isAvailableToClick)
                                      ? theme.colorScheme.primary
                                      : Colors.grey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: toSize(15),
                                ))),
                        SizedBox(width: toSize(5)),
                        (!_controller!.isAvailableToClick)
                            ? _buildTimer(theme, _controller!.resendDuration, true)
                            : const SizedBox()
                      ],
                    )
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
    );
  }

  Widget _buildTimer(
      ThemeData theme, int durationCounter, bool isResendCoolDown) {
    if (_controller == null) return Container();

    final String minutes = _controller!.formatNumber(durationCounter ~/ 60);
    final String seconds = _controller!.formatNumber(durationCounter % 60);

    return Text(
      (!isResendCoolDown) ? '$minutes : $seconds' : '($seconds)',
      style: TextStyle(
          color: (!isResendCoolDown) ? theme.colorScheme.primary : Colors.grey,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w700,
          fontSize: toSize(15)),
    );
  }
}
