import 'dart:async';

import 'package:flutter/material.dart';
import 'package:med_voice/data/exceptions/authentication_exception.dart';
import 'package:med_voice/domain/entities/profession/profession_info.dart';
import 'package:med_voice/domain/repositories/profession_repository/professsion_repository.dart';

class getProfessionListUseCase {
  final ProfessionRepository _professionRepository;

  getProfessionListUseCase(this._professionRepository);

//6. The buildUseCaseStream() method is called to execute the use case.
//The method returns a Stream of List<ProfessionInfo> which is the result of the use case.

  @override
  Future<Stream<List<ProfessionInfo>>> buildUseCaseStream(
      String? params) async {
    final StreamController<List<ProfessionInfo>> controller =
        StreamController();

    //7. The StreamController is created to add the data to the stream and check if the data is available or not.
    //the StreamController usage is to create a broadcast stream that allows multiple listeners.
    //and addError() method is used to add the error to the stream.
    //It also return the status of the use case execution to the Presenter.

    try {
      List<ProfessionInfo> professionInfo =
          await _professionRepository.getProfessionList();
      controller.add(professionInfo);
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
    //The controller.stream returns the stream of List<ProfessionInfo> to the Presenter.
    //The Presenter can listen to the stream and handle the UI accordingly.
  }
}
