import 'dart:convert';
import 'package:http/http.dart' as http;

class FootballApi {
  static const String _baseUrl = 'https://v3.football.api-sports.io';

  // 🔐 API KEY via --dart-define
  static const String _apiKey =
      String.fromEnvironment('API_FOOTBALL_KEY');

  static Map<String, String> get _headers => {
        'x-apisports-key': _apiKey,
      };

  /// Jogos por campeonato (ex: Brasileirão Série A = 71)
  static Future<List<dynamic>> getMatches({
    required int leagueId,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/fixtures?league=$leagueId&season=2025',
    );

    final response = await http.get(uri, headers: _headers);

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar jogos');
    }

    final data = jsonDecode(response.body);
    return data['response'];
  }
}
