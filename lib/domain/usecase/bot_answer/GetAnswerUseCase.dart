import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/repositories/ask_repository/ask_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';
import '../../entities/ask/ask_request.dart';

class GetAnswerUseCase extends UseCase<AskInfo, AskRequest> {
  final AskRepository _repository;

  GetAnswerUseCase(this._repository);

  @override
  Future<Stream<AskInfo>> buildUseCaseStream(AskRequest? params) async {
    final StreamController<AskInfo> controller = StreamController();

    try {
      AskInfo askInfo = await _repository.getAnswer(params!);
      controller.add(askInfo);
      debugPrint('get answer info successful.');
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
