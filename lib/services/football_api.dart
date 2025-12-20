import 'dart:convert';
import 'package:http/http.dart' as http;

/// football-data.org API
/// Auth via header: X-Auth-Token  (token não pode ficar exposto no app em produção)
class FootballApi {
  // Base URL v4
  static const String _base = 'https://api.football-data.org/v4';

  // Pegamos o token de --dart-define (Codemagic) pra NÃO deixar no código.
  static const String token = String.fromEnvironment('FD_TOKEN');

  static Map<String, String> get _headers {
    return {
      'X-Auth-Token': token,
    };
  }

  /// Lista partidas (fixtures) de uma competição.
  /// Ex: competitionCode = "BSA" (Brasileirão Série A)  (pode variar por plano)
  static Future<List<dynamic>> getMatches({
    required String competitionCode,
  }) async {
    if (token.isEmpty) {
      throw Exception('FD_TOKEN vazio. Configure no Codemagic com --dart-define.');
    }

    final uri = Uri.parse('$_base/competitions/$competitionCode/matches');
    final res = await http.get(uri, headers: _headers);

    if (res.statusCode != 200) {
      throw Exception('Erro API (${res.statusCode}): ${res.body}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return (data['matches'] as List<dynamic>?) ?? [];
  }
}

