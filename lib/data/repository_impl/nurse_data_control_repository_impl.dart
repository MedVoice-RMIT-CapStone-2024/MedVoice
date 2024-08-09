import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:med_voice/data/network/constants.dart';
import 'package:med_voice/data/network/http_helper.dart';
import 'package:med_voice/domain/entities/nurse/nurse_info.dart';
import 'package:med_voice/domain/entities/nurse/nurse_register_request.dart';
import 'package:med_voice/domain/entities/nurse/nurse_response.dart';
import 'package:med_voice/domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';

class NurseDataControlRepositoryImpl implements NurseDataControlRepository {
  static final NurseDataControlRepositoryImpl _instance =
      NurseDataControlRepositoryImpl._internal();

  NurseDataControlRepositoryImpl._internal();

  factory NurseDataControlRepositoryImpl() => _instance;

  @override
  Future<NurseInfo> registerNurse(NurseRegisterRequest param) async {
    NurseInfo nurseInfo;
    NurseResponse nurseResponse;
    Map<String, dynamic>? body;

    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(Constants.createNurseAccount), RequestType.post,
          headers: null, body: const JsonEncoder().convert(param.toJson()));
    } catch (e) {
      debugPrint("Invoke HTTP failed: $e");
      rethrow;
    }

    if (body == null) return NurseInfo.buildDefault();
    nurseResponse = NurseResponse.fromJson(body);
    nurseInfo =
        NurseInfo(nurseResponse.id, nurseResponse.name, nurseResponse.email);

    return nurseInfo;
  }
}
