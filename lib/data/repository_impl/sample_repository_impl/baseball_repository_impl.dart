import 'package:flutter/cupertino.dart';
import 'package:med_voice/data/network/http_helper.dart';
import 'package:med_voice/domain/entities/baseball/baseball_info.dart';
import 'package:med_voice/domain/entities/baseball/baseball_response.dart';
import 'package:med_voice/domain/repositories/sample_repository/sample_repository.dart';

import '../../network/constants.dart';

class BaseballRepositoryImpl implements SampleRepository {
  static final BaseballRepositoryImpl _instance =
  BaseballRepositoryImpl._internal();

  BaseballRepositoryImpl._internal() {}

  factory BaseballRepositoryImpl() => _instance;

  @override
  Future<List<BaseballInfo>> getBaseballList() async {
    List<BaseballResponse> baseballResponses;
    List<BaseballInfo> baseballInfo = [];
    List<dynamic>? body;
    try {
      body = await HttpHelper.invokeHttpList(
          Uri.parse(Constants.baseballList), RequestType.get,
          headers: null, body: null);
    } catch (error) {
      debugPrint("Fail to get baseball list");
      rethrow;
    }

    if (body == null) return [];
    baseballResponses = body
        .map(
            (dynamic i) => BaseballResponse.fromJson(i as Map<String, dynamic>))
        .toList();

    for (var i = 0; i < baseballResponses.length; i++) {
      BaseballResponse baseballResponse = baseballResponses[i];
      baseballInfo.add(BaseballInfo(
          baseballResponse.rank ?? "",
          baseballResponse.player ?? "",
          baseballResponse.ageThatYear ?? "",
          baseballResponse.hits ?? 0,
          baseballResponse.year ?? 0,
          baseballResponse.bats ?? "",
          baseballResponse.id ?? 0));
    }
    return baseballInfo;
  }
}