import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/usecase/bot_answer/GetAnswerUseCase.dart';

class ChatBotPresenter extends Presenter {
  late Function getAnswerOnNext;
  late Function getAnswerOnComplete;
  late Function getAnswerOnError;

  final GetAnswerUseCase getAnswerUseCase;

  ChatBotPresenter(askRepository)
      : getAnswerUseCase = GetAnswerUseCase(askRepository);

  void getAnswer(String question, String sourceType) {
    getAnswerUseCase.execute(
        _GetAnswerObserver(this), GetAnswerParams(question, sourceType));
  }

  @override
  void dispose() {
    getAnswerUseCase.dispose();
  }
}

class _GetAnswerObserver extends Observer<AskInfo> {
  final ChatBotPresenter presenter;

  _GetAnswerObserver(this.presenter);

  @override
  void onNext(AskInfo? response) {
    presenter.getAnswerOnNext(response);
  }

  @override
  void onComplete() {
    presenter.getAnswerOnComplete();
  }

  @override
  void onError(e) {
    presenter.getAnswerOnError(e);
  }
}
