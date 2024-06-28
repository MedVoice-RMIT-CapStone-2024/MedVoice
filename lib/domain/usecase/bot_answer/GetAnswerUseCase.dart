import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/repositories/ask_repository/ask_repository.dart';

import '../../entities/ask/ask_request.dart';

class GetAnswerUseCase extends UseCase<AskInfo, GetAnswerParams> {
  final AskRepository _repository;

  GetAnswerUseCase(this._repository);

  @override
  Future<Stream<AskInfo>> buildUseCaseStream(GetAnswerParams? params) async {
    final StreamController<AskInfo> controller = StreamController();

    try {
      final askInfo = await _repository.getAnswer(
        AskRequest(params!.question, params.sourceType),
      );
      controller.add(askInfo);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetAnswerParams {
  final String question;
  final String sourceType;

  GetAnswerParams(this.question, this.sourceType);
}
