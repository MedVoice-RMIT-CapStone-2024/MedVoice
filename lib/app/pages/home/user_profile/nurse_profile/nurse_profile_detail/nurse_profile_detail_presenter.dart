import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../../domain/entities/nurse/nurse_register_request.dart';
import '../../../../../../domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';
import '../../../../../../domain/usecase/nurse_data/deleteNurseAccountUseCase.dart';

class NurseProfileDetailPresenter extends Presenter {
  Function? onGetNurseInfoSucceed;
  Function? onGetNurseInfoFailed;
  Function? onCompleted;
  final NurseDataControlRepository _nurseRepository;

  DeleteNurseAccountUseCase? _deleteNurseAccountUseCase;

  NurseProfileDetailPresenter(this._nurseRepository) {
    _deleteNurseAccountUseCase = DeleteNurseAccountUseCase(_nurseRepository);
  }

  @override
  void dispose() {
    _deleteNurseAccountUseCase?.dispose();
  }

  void executeDeleteNurseAccount(NurseRegisterRequest params) => _deleteNurseAccountUseCase?.execute(_DeleteNurseAccountUseCaseObserver(this), params);

}

class _DeleteNurseAccountUseCaseObserver implements Observer<bool> {
  final NurseProfileDetailPresenter _presenter;

  _DeleteNurseAccountUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onGetNurseInfoFailed != null);
    _presenter.onGetNurseInfoFailed!(e);
  }

  @override
  void onNext(bool? response) {
    assert(response is bool);
    _presenter.onGetNurseInfoSucceed!(response);
  }
}