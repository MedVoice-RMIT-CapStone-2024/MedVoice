import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/repositories/sample_repository/sample_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';
import '../../entities/baseball/baseball_info.dart';


class GetBaseballListUseCase extends UseCase<List<BaseballInfo>, String?> {
  final SampleRepository _sampleRepository;

  GetBaseballListUseCase(this._sampleRepository);

  @override
  Future<Stream<List<BaseballInfo>>> buildUseCaseStream(String? params) async {
    final StreamController<List<BaseballInfo>> controller = StreamController();

    try {
      List<BaseballInfo> baseballInfo =
      await _sampleRepository.getBaseballList();
      controller.add(baseballInfo);
      debugPrint('getBaseballInfo successful.');
      controller.close();
    } catch (e) {
      if (e is APIException) {
        debugPrint("failed ${e.message}");
        controller.addError(e.message);
      } else {
        debugPrint("failed $e");
        controller.addError("");
      }
    }
    return controller.stream;
  }
}