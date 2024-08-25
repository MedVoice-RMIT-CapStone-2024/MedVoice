import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/nurse/nurse_login_info.dart';
import 'package:med_voice/domain/entities/nurse/nurse_login_request.dart';
import 'package:med_voice/domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';

class LoginNurseUseCase extends UseCase<NurseLoginInfo, NurseLoginRequest> {
  final NurseDataControlRepository _repository;
  LoginNurseUseCase(this._repository);

  @override
  Future<Stream<NurseLoginInfo>> buildUseCaseStream(NurseLoginRequest? params) async {
    final StreamController<NurseLoginInfo> controller = StreamController();

    try {
      NurseLoginInfo result = await _repository.loginNurse(params!);
      controller.add(result);
      debugPrint('login nurse successful.');
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
