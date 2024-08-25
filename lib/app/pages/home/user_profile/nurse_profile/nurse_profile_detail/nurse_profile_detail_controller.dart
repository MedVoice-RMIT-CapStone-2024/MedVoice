import 'package:flutter/cupertino.dart';
import 'package:med_voice/app/pages/home/user_profile/nurse_profile/nurse_profile_detail/nurse_profile_detail_presenter.dart';
import 'package:med_voice/common/base_controller.dart';

import '../../../../../../domain/entities/nurse/nurse_register_request.dart';
import '../../../../../utils/global.dart';
import '../../../../../utils/pages.dart';

class NurseProfileDetailController extends BaseController {
  final NurseProfileDetailPresenter _presenter;
  NurseRegisterRequest? request;

  NurseProfileDetailController(nurseRepository)
      : _presenter = NurseProfileDetailPresenter(nurseRepository);

  @override
  void firstLoad() {
    request = NurseRegisterRequest.buildDefault();
  }

  @override
  void onListener() {
    _presenter.onGetNurseInfoSucceed = (bool response) {
      debugPrint("Delete nurse successful");
      hideLoadingProgress();
      view.showPopupWithAction(
          'Account deleted successfully', 'Return to login', () {
        view.pushScreen(Pages.signIn, isAllowBack: false);
      });
    };
    _presenter.onGetNurseInfoFailed = (e) {
      debugPrint("Delete nurse failed");
      hideLoadingProgress();
      view.showErrorFromServer('Failed to delete nurse account');
    };
    _presenter.onCompleted = (){
      debugPrint("Delete nurse completed");
    };
  }

  void onDeleteNurseAccount() {
    showLoadingProgress(loadingContent: 'Deleting your account');
    request?.id = Global.userCredentials.id;
    _presenter.executeDeleteNurseAccount(request!);
  }
}
