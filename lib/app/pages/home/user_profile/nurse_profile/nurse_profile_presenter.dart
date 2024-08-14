import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/usecase/nurse_data/getNurseInfoUseCase.dart';

import '../../../../../domain/entities/nurse/nurse_info.dart';
import '../../../../../domain/entities/nurse/nurse_register_request.dart';
import '../../../../../domain/repositories/nurse_data_control_repository/nurse_data_control_repository.dart';

class NurseProfilePresenter extends Presenter {
  Function? onGetNurseInfoSucceed;
  Function? onGetNurseInfoFailed;
  Function? onCompleted;
  final NurseDataControlRepository _nurseRepository;

  GetNurseInfoUseCase? _getNurseInfoUseCase;

  NurseProfilePresenter(this._nurseRepository) {
    _getNurseInfoUseCase = GetNurseInfoUseCase(_nurseRepository);
  }

  @override
  void dispose() {
    _getNurseInfoUseCase?.dispose();
  }

  void executeGetNurseInfo(NurseRegisterRequest params) => _getNurseInfoUseCase?.execute(_GetNurseInfoUseCaseObserver(this), params);

}

class _GetNurseInfoUseCaseObserver implements Observer<NurseInfo> {
  final NurseProfilePresenter _presenter;

  _GetNurseInfoUseCaseObserver(this._presenter);

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
  void onNext(NurseInfo? response) {
    assert(response is NurseInfo);
    _presenter.onGetNurseInfoSucceed!(response);
  }
}
