import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:med_voice/data/network/constants.dart';
import 'package:med_voice/domain/entities/ask/ask_request.dart';
import 'package:med_voice/domain/entities/ask/ask_response.dart';
import 'package:med_voice/domain/repositories/ask_repository/ask_repository.dart';

class AskRepositoryImpl implements AskRepository {
  @override
  Future<AskResponse> getAnswer(AskRequest request) async {
    final response = await http.post(
      Uri.parse(Constants.askEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return AskResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch answer');
    }
  }
}
