import 'package:med_voice/domain/entities/ask/ask_request.dart';
import 'package:med_voice/domain/entities/ask/ask_response.dart';
import 'package:med_voice/domain/repositories/ask_repository/ask_repository.dart';

class GetAnswerUseCase {
  final AskRepository repository;

  GetAnswerUseCase(this.repository);

  Future<AskResponse> execute(AskRequest request, askRequest) {
    return repository.getAnswer(request);
  }
}
