import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'i_base_presenter.dart';

abstract class BasePresenter extends Presenter implements IBasePresenter {
  @override
  void dispose() {
    onDestroy();
  }

  @override
  void onDestroy() {}
}