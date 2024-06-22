import 'package:med_voice/domain/entities/ask/ask_request.dart';
import 'package:med_voice/domain/entities/ask/ask_response.dart';
import 'package:med_voice/domain/repositories/ask_repository/ask_repository.dart';
import 'package:med_voice/domain/usecase/bot_answer/getAnswerUseCase.dart';

class ChatBotPresenter {
  final AskRepository _askRepository;
  late GetAnswerUseCase _getAnswerUseCase;

  Function(AskResponse)? onGetAnswerSuccess;
  Function(dynamic)? onGetAnswerError;
  Function? onCompleted;

  ChatBotPresenter(this._askRepository) {
    _getAnswerUseCase = GetAnswerUseCase(_askRepository);
  }

  void dispose() {
    // Cleanup if needed
  }

  Future<void> executeGetAnswer(String question) async {
    final request = AskRequest(question: question);
    try {
      final response = await _getAnswerUseCase.execute(request, null);
      onGetAnswerSuccess?.call(response);
      onCompleted?.call();
    } catch (e) {
      onGetAnswerError?.call(e);
    }
  }
}
