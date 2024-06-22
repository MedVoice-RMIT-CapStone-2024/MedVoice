import 'dart:async';

import 'package:flutter/material.dart';
import 'package:med_voice/app/pages/home/chat/chat_bot/chat_bot_view.dart';
import 'package:med_voice/common/base_controller.dart';

class ChatBotController extends BaseController {
  bool isShowStartButton = false;
  Timer? timer;
  SendMode _sendMode = SendMode.typing;

  @override
  void onResumed() {}

  @override
  void onListener() {}

  @override
  void firstLoad() {
    // startTimer();
  }
  void setSendMode(SendMode sendMode) {
    _sendMode = sendMode;
    refreshUI();
  }

  @override
  void dispose() {}
}
