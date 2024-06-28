import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:med_voice/data/network/http_helper.dart';
import 'package:med_voice/data/network/constants.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/entities/ask/ask_request.dart';
import 'package:med_voice/domain/entities/ask/ask_response.dart';
import 'package:med_voice/domain/repositories/ask_repository/ask_repository.dart';

class AskRepositoryImpl implements AskRepository {
  static final AskRepositoryImpl _instance = AskRepositoryImpl._internal();

  AskRepositoryImpl._internal();

  factory AskRepositoryImpl() => _instance;

  @override
  Future<AskInfo> getAnswer(AskRequest request) async {
    Map<String, dynamic>? body;

    try {
      body = await HttpHelper.invokeHttp(
        Uri.parse(Constants.askEndpoint),
        RequestType.post,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );
    } catch (error) {
      debugPrint("Failed to get answer");
      rethrow;
    }

    if (body == null) return AskInfo.buildDefault();

    AskResponse askResponse = AskResponse.fromJson(body);
    return AskInfo(askResponse.answer ?? '');
  }
}
