import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entities/nurse/nurse_info.dart';
import '../../../../domain/entities/nurse/nurse_register_request.dart';
import '../../../../domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';
import '../../../../domain/usecase/nurse_data/editNurseInformationUseCase.dart';
import '../../../../domain/usecase/nurse_data/registerNurseUseCase.dart';

class OtpVerificationPresenter extends Presenter {
  Function? onRegisterNurseSuccess;
  Function? onRegisterNurseFailed;
  Function? onChangeEmailSuccess;
  Function? onChangeEmailFailed;
  Function? onCompleted;
  final NurseDataControlRepository _nurseRepository;

  RegisterNurseUseCase? _registerNurseUseCase;
  EditNurseInformationUseCase? _editEmailUseCase;

  OtpVerificationPresenter(this._nurseRepository) {
    _registerNurseUseCase = RegisterNurseUseCase(_nurseRepository);
    _editEmailUseCase = EditNurseInformationUseCase(_nurseRepository);
  }

  @override
  void dispose() {
    _registerNurseUseCase?.dispose();
    _editEmailUseCase?.dispose();
  }

  void executeCreateNurseAccount(NurseRegisterRequest params) => _registerNurseUseCase?.execute(_RegisterNurseUseCaseObserver(this), params);
  void executeEditEmail(NurseRegisterRequest params) => _editEmailUseCase?.execute(_EditNurseInformationUseCaseObserver(this), params);
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

class _EditNurseInformationUseCaseObserver implements Observer<NurseInfo> {
  final OtpVerificationPresenter _presenter;

  _EditNurseInformationUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onChangeEmailFailed != null);
    _presenter.onChangeEmailFailed!(e);
  }

  @override
  void onNext(NurseInfo? response) {
    assert(response is NurseInfo);
    _presenter.onChangeEmailSuccess!(response);
  }
}