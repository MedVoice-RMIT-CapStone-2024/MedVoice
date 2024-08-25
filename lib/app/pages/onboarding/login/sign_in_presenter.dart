import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/nurse/nurse_login_info.dart';
import 'package:med_voice/domain/entities/nurse/nurse_login_request.dart';

import '../../../../domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';
import '../../../../domain/usecase/nurse_data/loginNurseUseCase.dart';

class SignInPresenter extends Presenter {
  Function? onLoginNurseSucceed;
  Function? onLoginNurseFailed;
  Function? onCompleted;

  final NurseDataControlRepository _nurseRepository;

  LoginNurseUseCase? _loginNurseUseCase;

  SignInPresenter(this._nurseRepository) {
    _loginNurseUseCase = LoginNurseUseCase(_nurseRepository);
  }

  @override
  void dispose() {
    _loginNurseUseCase?.dispose();
  }

  void executeLoginNurseAccount(NurseLoginRequest params) =>
      _loginNurseUseCase?.execute(_LoginNurseUseCaseObserver(this), params);
}

class _LoginNurseUseCaseObserver implements Observer<NurseLoginInfo> {
  final SignInPresenter _presenter;

  _LoginNurseUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onLoginNurseFailed != null);
    _presenter.onLoginNurseFailed!(e);
  }

  @override
  void onNext(NurseLoginInfo? response) {
    assert(response is NurseLoginInfo);
    _presenter.onLoginNurseSucceed!(response);
  }
}
