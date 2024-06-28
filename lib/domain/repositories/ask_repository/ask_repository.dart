import 'package:med_voice/domain/entities/ask/ask_info.dart';
import 'package:med_voice/domain/entities/ask/ask_request.dart';

abstract class AskRepository {
  Future<AskInfo> getAnswer(AskRequest request);
}
