import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:med_voice/data/network/constants.dart';
import 'package:med_voice/data/network/http_helper.dart';
import 'package:med_voice/domain/entities/nurse/nurse_info.dart';
import 'package:med_voice/domain/entities/nurse/nurse_login_request.dart';
import 'package:med_voice/domain/entities/nurse/nurse_login_response.dart';
import 'package:med_voice/domain/entities/nurse/nurse_register_request.dart';
import 'package:med_voice/domain/entities/nurse/nurse_response.dart';
import 'package:med_voice/domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';

import '../../domain/entities/nurse/nurse_login_info.dart';

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
          headers: null, body: const JsonEncoder().convert(param.toJsonForRegister()));
    } catch (e) {
      debugPrint("Invoke HTTP failed: $e");
      rethrow;
    }

    if (body == null) return NurseInfo.buildDefault();
    nurseResponse = NurseResponse.fromJson(body);
    nurseInfo =
        NurseInfo(nurseResponse.id, nurseResponse.name, nurseResponse.email, nurseResponse.detail);

    return nurseInfo;
  }

  @override
  Future<NurseInfo> getNurseInfo(NurseRegisterRequest param) async {
    NurseInfo nurseInfo;
    NurseResponse nurseResponse;
    Map<String, dynamic>? body;

    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(Constants.getNurseInformation
              .replaceAll('{nurse_id}', param.id ?? "")),
          RequestType.get,
          headers: null,
          body: null);
    } catch (e) {
      debugPrint("Invoke HTTP failed: $e");
      rethrow;
    }

    if (body == null) return NurseInfo.buildDefault();
    nurseResponse = NurseResponse.fromJson(body);
    nurseInfo =
        NurseInfo(nurseResponse.id, nurseResponse.name, nurseResponse.email, nurseResponse.detail);

    return nurseInfo;
  }

  @override
  Future<bool> deleteNurseAccount(NurseRegisterRequest param) async {
    bool? body;
    try {
      body = await HttpHelper.invokeBoolOnlyHttp(
          Uri.parse(Constants.deleteNurseAccount
              .replaceAll('{nurse_id}', param.id ?? "")),
          RequestType.delete,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to change delete nurse account $error");
      rethrow;
    }
    return true;
  }

  @override
  Future<NurseInfo> editNurseInformation(NurseRegisterRequest param) async {
    NurseInfo nurseInfo;
    NurseResponse nurseResponse;
    Map<String, dynamic>? body;

    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(Constants.editNurseInformation
              .replaceAll('{nurse_id}', param.id ?? "")),
          RequestType.put,
          headers: null,
          body: const JsonEncoder().convert(param.toJsonForEdit()));
    } catch (e) {
      debugPrint("Invoke HTTP failed: $e");
      rethrow;
    }

    if (body == null) return NurseInfo.buildDefault();
    nurseResponse = NurseResponse.fromJson(body);
    nurseInfo =
        NurseInfo(nurseResponse.id, nurseResponse.name, nurseResponse.email, nurseResponse.detail);

    return nurseInfo;
  }

  @override
  Future<NurseLoginInfo> loginNurse(NurseLoginRequest param) async {
    Map<String, dynamic>? body;
    NurseLoginInfo info;
    NurseLoginResponse response;

    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(Constants.loginNurseAccount), RequestType.post,
          headers: null, body: const JsonEncoder().convert(param.toJson()));
    } catch (error) {
      debugPrint("Fail to change delete nurse account $error");
      rethrow;
    }
    if (body == null) return NurseLoginInfo.buildDefault();
    response = NurseLoginResponse.fromJson(body);
    info = NurseLoginInfo(response.nurseId, response.detail);

    return info;
  }
}
