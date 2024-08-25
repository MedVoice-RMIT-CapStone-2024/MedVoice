import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/nurse/nurse_register_request.dart';
import 'package:med_voice/domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';
import '../../entities/nurse/nurse_info.dart';

class RegisterNurseUseCase extends UseCase<NurseInfo, NurseRegisterRequest> {
  final NurseDataControlRepository _repository;

  RegisterNurseUseCase(this._repository);

  @override
  Future<Stream<NurseInfo>> buildUseCaseStream(NurseRegisterRequest? params) async {
    final StreamController<NurseInfo> controller = StreamController();

    try {
      NurseInfo nurseInfo = await _repository.registerNurse(params!);
      controller.add(nurseInfo);
      debugPrint('register nurse successful.');
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
