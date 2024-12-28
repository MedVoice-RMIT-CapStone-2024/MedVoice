import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/nurse/nurse_register_request.dart';
import 'package:med_voice/domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';

import '../../../data/exceptions/authentication_exception.dart';
import '../../entities/nurse/nurse_info.dart';

class EditNurseInformationUseCase extends UseCase<NurseInfo, NurseRegisterRequest> {
  final NurseDataControlRepository _repository;
  EditNurseInformationUseCase(this._repository);

  @override
  Future<Stream<NurseInfo>> buildUseCaseStream(NurseRegisterRequest? params) async {
    final StreamController<NurseInfo> controller = StreamController();

    try {
      NurseInfo result = await _repository.editNurseInformation(params!);
      controller.add(result);
      debugPrint('edit nurse information successful.');
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
