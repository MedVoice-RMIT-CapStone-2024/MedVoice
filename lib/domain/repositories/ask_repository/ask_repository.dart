import 'package:med_voice/domain/entities/ask/ask_request.dart';
import 'package:med_voice/domain/entities/ask/ask_response.dart';

abstract class AskRepository {
  Future<AskResponse> getAnswer(AskRequest request);
}
