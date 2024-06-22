import 'package:med_voice/domain/entities/ask/ask_response.dart';

abstract class AskRepository {
  Future<List<AskResponse>> getAskList();
}
