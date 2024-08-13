import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entities/nurse/nurse_info.dart';
import '../../../../domain/entities/nurse/nurse_register_request.dart';
import '../../../../domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';
import '../../../../domain/usecase/nurse_data/registerNurseUseCase.dart';

class OtpVerificationPresenter extends Presenter {
  Function? onRegisterNurseSuccess;
  Function? onRegisterNurseFailed;
  Function? onCompleted;
  final NurseDataControlRepository _nurseRepository;

  RegisterNurseUseCase? _registerNurseUseCase;

  OtpVerificationPresenter(this._nurseRepository) {
    _registerNurseUseCase = RegisterNurseUseCase(_nurseRepository);
  }

  @override
  void dispose() {
    _registerNurseUseCase?.dispose();
  }

  void executeUploadLibraryTranscript(NurseRegisterRequest params) => _registerNurseUseCase?.execute(_RegisterNurseUseCaseObserver(this), params);

}

class _RegisterNurseUseCaseObserver implements Observer<NurseInfo> {
  final OtpVerificationPresenter _presenter;

  _RegisterNurseUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onRegisterNurseFailed != null);
    _presenter.onRegisterNurseFailed!(e);
  }

  @override
  void onNext(NurseInfo? response) {
    assert(response is NurseInfo);
    _presenter.onRegisterNurseSuccess!(response);
  }
}