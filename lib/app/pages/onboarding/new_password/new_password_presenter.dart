import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entities/nurse/nurse_info.dart';
import '../../../../domain/entities/nurse/nurse_register_request.dart';
import '../../../../domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';
import '../../../../domain/usecase/nurse_data/editNurseInformationUseCase.dart';

class NewPasswordPresenter extends Presenter {
  final NurseDataControlRepository _nurseRepository;
  Function? onChangePasswordSuccess;
  Function? onChangePasswordFailed;
  Function? onCompleted;

  EditNurseInformationUseCase? _editEmailUseCase;

  NewPasswordPresenter(this._nurseRepository) {
    _editEmailUseCase = EditNurseInformationUseCase(_nurseRepository);
  }


  @override
  void dispose() {
    _editEmailUseCase?.dispose();
  }

  void executeEditPassword(NurseRegisterRequest params) => _editEmailUseCase?.execute(_EditNurseInformationUseCaseObserver(this), params);
}

class _EditNurseInformationUseCaseObserver implements Observer<NurseInfo> {
  final NewPasswordPresenter _presenter;

  _EditNurseInformationUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onChangePasswordFailed != null);
    _presenter.onChangePasswordFailed!(e);
  }

  @override
  void onNext(NurseInfo? response) {
    assert(response is NurseInfo);
    _presenter.onChangePasswordSuccess!(response);
  }
}