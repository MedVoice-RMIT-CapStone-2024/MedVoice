import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/entities/ask/ask_request.dart';
import 'package:med_voice/domain/repositories/ask_repository/ask_repository.dart';
import 'package:med_voice/domain/usecase/bot_answer/GetAnswerUseCase.dart';

class ChatBotPresenter extends Presenter {
  Function? onGetAnswerSuccess;
  Function? onGetAnswerFailed;
  Function? onCompleted;
  final AskRepository _askRepository;
  GetAnswerUseCase? _getAnswerUseCase;

  GetAnswerUseCase? getAnswerUseCase;

  ChatBotPresenter(this._askRepository) {
    _getAnswerUseCase = GetAnswerUseCase(_askRepository);
  }

  @override
  void dispose() {
    _getAnswerUseCase?.dispose();
  }

  void executeGetAnswer(AskRequest params) {
    _getAnswerUseCase?.execute(
        _GetAnswerObserver(this), params);
  }
}

class _GetAnswerObserver implements Observer<AskInfo> {
  final ChatBotPresenter _presenter;

  _GetAnswerObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.onCompleted != null);
    _presenter.onCompleted!();
  }

  @override
  void onError(e) {
    assert(_presenter.onGetAnswerFailed != null);
    _presenter.onGetAnswerFailed!(e);
  }

  @override
  void onNext(AskInfo? response) {
    assert(response is AskInfo);
    _presenter.onGetAnswerSuccess!(response);
  }
}
