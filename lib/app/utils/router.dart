// Setting up specific cases for when you navigate to pages

import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/pages/home/medical_archive/audio_playback/audio_playback_view.dart';
import 'package:med_voice/app/pages/home/medical_archive/medical_archive_controller.dart';
import 'package:med_voice/app/pages/home/patient_doc/note/note_view.dart';
import 'package:med_voice/app/pages/home/user_profile/nurse_profile/nurse_profile_detail/nurse_profile_detail_view.dart';
import 'package:med_voice/app/pages/home/user_profile/policies/privacy/privacy_policy_view.dart';
import 'package:med_voice/app/pages/home/user_profile/policies/terms/term_of_service_view.dart';
import 'package:med_voice/app/pages/home/user_profile/profile_qr/my_qr_view.dart';
import 'package:med_voice/app/pages/onboarding/login/sign_in_view.dart';
import 'package:med_voice/app/pages/onboarding/new_password/new_password_view.dart';
import 'package:med_voice/app/pages/onboarding/onboarding_welcome/onboarding_welcome_view.dart';
import 'package:med_voice/app/pages/onboarding/signup/info/info_view.dart';
import 'package:med_voice/app/utils/pages.dart';

import '../../domain/entities/nurse/nurse_register_request.dart';
import '../pages/home/chat/chat_bot/chat_bot_view.dart';
import '../pages/home/user_profile/nurse_profile/change_nurse_email/change_nurse_email_view.dart';
import '../pages/home/user_profile/nurse_profile/change_nurse_password/change_nurse_password_view.dart';
import '../pages/onboarding/confirm/confirm_view.dart';
import '../pages/onboarding/otp_verification/otp_verification_view.dart';
import '../pages/onboarding/reset/reset_view.dart';
import '../pages/onboarding/signup/sign_up_view.dart';

import '../pages/home/main/main_view.dart';
import '../pages/home/medical_archive/medical_archive_view.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();

  CupertinoPageRoute? getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Pages.startup:

      // case Pages.foodDetails:
      //   Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
      //   return _buildRoute(settings, FoodDetailsView(
      //     foodItem: arguments[foodItemParam] as String,
      //   ));

      case Pages.signUp:
        return _buildRoute(settings, SignUpView());

      case Pages.signIn:
        return _buildRoute(settings, const SignInView());

      case Pages.reset:
        return _buildRoute(settings, ResetView());

      case Pages.confirm:
        return _buildRoute(settings, ConfirmView());

      case Pages.main:
        return _buildRoute(settings, const MainView());

      case Pages.medicalArchive:
        return _buildRoute(settings, const MedicalArchiveView());

      case Pages.myQR:
        return _buildRoute(settings, MyQRView());

      case Pages.info:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            InfoView(
              isFromOnBoarding: arguments[isFromOnBoardingParam] as bool,
            ));

      case Pages.audioPlayback:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            AudioPlaybackView(
              recordingInfo: arguments[recordingInfo] as String,
            ));

      case Pages.terms:
        return _buildRoute(settings, TermsAndConditionsView());

      case Pages.privacy:
        return _buildRoute(settings, PrivacyPolicyView());

      case Pages.noteArchiveDetails:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            NoteView(
              groupDateInfo: arguments[groupDateInfo] as DisplayArchive,
              audioLink: arguments[audioLink] as String,
            ));

      case Pages.chatBot:
        return _buildRoute(settings, ChatBotView());

      case Pages.onBoardingWelcome:
        return _buildRoute(settings, const OnBoardingWelcomeView());

      case Pages.otpVerification:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            OtpVerificationView(
                isFromEmailChange: arguments[isFromEmailChange] as bool,
                isFromPasswordReset: arguments[isFromPasswordReset] as bool));

      case Pages.nurseProfileDetail:
        return _buildRoute(settings, const NurseProfileDetailView());

      case Pages.changeNurseEmail:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            ChangeNurseEmailView(
                nurseEmailItemRequest:
                    arguments[nurseEmailItemRequest] as NurseRegisterRequest));

      case Pages.changeNursePassword:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            ChangeNursePasswordView(
                nursePasswordItemRequest: arguments[nursePasswordItemRequest]
                    as NurseRegisterRequest));

      case Pages.newPasswordView:
        return _buildRoute(settings, const NewPasswordView());

      default:
        return null;
    }
  }

  CupertinoPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return CupertinoPageRoute(
        settings: settings, builder: (context) => builder);
  }
}
