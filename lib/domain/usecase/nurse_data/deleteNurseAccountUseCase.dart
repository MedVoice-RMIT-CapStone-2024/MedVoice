import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/nurse/nurse_register_request.dart';
import 'package:med_voice/domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';

class DeleteNurseAccountUseCase extends UseCase<bool, NurseRegisterRequest> {
  final NurseDataControlRepository _repository;
  DeleteNurseAccountUseCase(this._repository);

  @override
  Future<Stream<bool>> buildUseCaseStream(NurseRegisterRequest? params) async {
    final StreamController<bool> controller = StreamController();

    try {
      bool result = await _repository.deleteNurseAccount(params!);
      controller.add(result);
      debugPrint('delete nurse successful.');
      controller.close();
    } catch (e) {
      if (e is APIException) {
        debugPrint("failed ${e.message}");
        controller.addError(e.message);
      } else {
        debugPrint("failed $e");
        controller.addError(e);
      }
    }
    return controller.stream;
  }
}
