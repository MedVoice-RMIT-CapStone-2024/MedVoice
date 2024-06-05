// Setting up specific cases for when you navigate to pages

import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/pages/home/medical_archive/audio_playback/audio_playback_view.dart';
import 'package:med_voice/app/pages/home/medical_archive/medical_archive_controller.dart';
import 'package:med_voice/app/pages/home/patient_doc/note/note_view.dart';
import 'package:med_voice/app/pages/home/user_profile/policies/privacy/privacy_policy_view.dart';
import 'package:med_voice/app/pages/home/user_profile/policies/terms/term_of_service_view.dart';
import 'package:med_voice/app/pages/home/user_profile/profile_qr/my_qr_view.dart';
import 'package:med_voice/app/pages/onboarding/login/sign_in_view.dart';
import 'package:med_voice/app/pages/onboarding/signup/info/info_view.dart';
import 'package:med_voice/app/utils/pages.dart';

import '../../domain/entities/recording/audio_transcript_info.dart';
import '../pages/home/recording_documentation/demo_temp_transcript/demo_temp_transcript_view.dart';
import '../pages/onboarding/confirm/confirm_view.dart';
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
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            SignUpView(
                isFromOnBoarding: arguments[isFromOnBoardingParam] as bool));

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
        return _buildRoute(settings, InfoView());

      case Pages.audioPlayback:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            AudioPlaybackView(
              recordingInfo: arguments[recordingInfo] as String,
            ));

      case Pages.demoTempTranscript:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return _buildRoute(
            settings,
            DemoTempTranscriptView(
              audioTranscriptInfo:
                  arguments[audioTranscriptInfo] as AudioTranscriptInfo,
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

      default:
        return null;
    }
  }

  CupertinoPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return CupertinoPageRoute(
        settings: settings, builder: (context) => builder);
  }
}
