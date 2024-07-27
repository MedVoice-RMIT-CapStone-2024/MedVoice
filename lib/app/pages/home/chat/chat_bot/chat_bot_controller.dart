import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/pages/home/chat/chat_bot/chat_bot_presenter.dart';
import 'package:med_voice/domain/entities/ask/chat_info.dart';
import 'package:med_voice/common/base_controller.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/entities/ask/get_answer_params.dart';

import '../../../../assets/lottie_assets.dart';

enum SendMode { typing, notTyping }

class ChatBotController extends BaseController {
  final ChatBotPresenter _presenter;
  List<ChatInfo> messages = [];
  List<String> bubbles = [];
  SendMode _sendMode = SendMode.notTyping;
  GetAnswerParams? getAnswerParams;
  bool _areBubblesVisible = true;
  bool _isLoading = false;
  Timer? _loadingTimer;

  ChatBotController(askRepository)
      : _presenter = ChatBotPresenter(askRepository) {
    _generateBubbles();
  }

  SendMode get sendMode => _sendMode;
  bool get areBubblesVisible => _areBubblesVisible;
  bool get isLoading => _isLoading;

  void setSendMode(SendMode mode) {
    _sendMode = mode;
    refreshUI();
  }

  void sendMessage(String message, {bool isUserInput = true}) {
    if (message.isNotEmpty) {
      messages
          .add(ChatInfo(message: message, isMe: true, time: DateTime.now()));
      refreshUI();
      _startLoading();
      _presenter.executeGetAnswer(message, 'json');
      if (isUserInput) {
        setSendMode(SendMode.notTyping);
      }
    }
  }

  void sendBubbleContent(String content) {
    sendMessage(content, isUserInput: false);
    hideBubbles();
    Future.delayed(Duration(seconds: 5), showBubbles);
  }

  void hideBubbles() {
    _areBubblesVisible = false;
    refreshUI();
  }

  void showBubbles() {
    _generateBubbles();
    _areBubblesVisible = true;
    refreshUI();
  }

  void _generateBubbles() {
    bubbles = [
      'Save transcript',
      'Update information',
      'Scan QR code',
      'Record interaction',
      'Show logs',
      'Clear chat',
      'Help'
    ];
  }

  void _startLoading() {
    _isLoading = true;
    refreshUI();
    _loadingTimer = Timer(Duration(seconds: 2), () {
      if (_isLoading) {
        _isLoading = false;
        refreshUI();
      }
    });
  }

  void _stopLoading() {
    _loadingTimer?.cancel();
    _isLoading = false;
    refreshUI();
  }

  String getLottieAnimationAsset(bool isDarkMode) {
    return isDarkMode
        ? LottieAssets.loadingDarkTheme
        : LottieAssets.loadingLightTheme;
  }

  void onMessageChanged(String value) {
    setSendMode(value.isNotEmpty ? SendMode.typing : SendMode.notTyping);
  }

  @override
  void firstLoad() {
    // Add the initial message here
    messages.add(ChatInfo(
      message: "Hello, I'm MVBot. How can I assist you today?",
      isMe: false,
      time: DateTime.now(),
    ));
    refreshUI();
  }

  @override
  void onListener() {
    _presenter.onGetAnswerSuccess = (AskInfo response) {
      Future.delayed(Duration(seconds: 2), () {
        _stopLoading();
        messages.add(ChatInfo(
            message: response.mAnswer, isMe: false, time: DateTime.now()));
        refreshUI();
      });
    };

    _presenter.onGetAnswerFailed = (error) {
      _stopLoading();
      debugPrint("Error getting answer: $error");
      view.showErrorFromServer("Failed to get answer: $error");
    };

    _presenter.onCompleted = () {
      debugPrint("Get answer completed");
    };
  }
}
