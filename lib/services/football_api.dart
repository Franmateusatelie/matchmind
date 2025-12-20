import 'dart:convert';
import 'package:http/http.dart' as http;

/// API-FOOTBALL (API-SPORTS) v3
/// Base: https://v3.football.api-sports.io
class FootballApi {
  static const String _baseUrl = 'https://v3.football.api-sports.io';

  /// ✅ Pega a chave do build (Codemagic) sem deixar no código
  /// No Codemagic você vai passar:
  /// --dart-define=API_FOOTBALL_KEY=SEU_TOKEN
  static const String _apiKey = String.fromEnvironment('API_FOOTBALL_KEY');

  static Map<String, String> get _headers {
    if (_apiKey.isEmpty) {
      // Ajuda a debugar quando esquecer de passar a chave no build
      return {'Content-Type': 'application/json'};
    }
    return {
      'x-apisports-key': _apiKey,
      'Content-Type': 'application/json',
    };
  }

  /// Busca ligas do Brasil (Serie A, Serie B, Copa do Brasil, etc.)
  static Future<List<Map<String, dynamic>>> getBrazilLeagues() async {
    final uri = Uri.parse('$_baseUrl/leagues?country=Brazil');
    final res = await http.get(uri, headers: _headers);

    if (res.statusCode != 200) {
      throw Exception('Erro leagues: ${res.statusCode} ${res.body}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final list = (data['response'] as List).cast<Map<String, dynamic>>();

    // Retorna lista completa; você filtra na UI pelo nome
    return list;
  }

  /// Busca jogos por liga e data (jogos do dia)
  static Future<List<Map<String, dynamic>>> getFixturesByLeagueAndDate({
    required int leagueId,
    required int season,
    required String dateYYYYMMDD,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/fixtures?league=$leagueId&season=$season&date=$dateYYYYMMDD',
    );
    final res = await http.get(uri, headers: _headers);

    if (res.statusCode != 200) {
      throw Exception('Erro fixtures: ${res.statusCode} ${res.body}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final list = (data['response'] as List).cast<Map<String, dynamic>>();
    return list;
  }
}

