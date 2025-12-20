class PredictorResult {
  final double homeWin;
  final double draw;
  final double awayWin;
  final String tip; // texto final

  PredictorResult({
    required this.homeWin,
    required this.draw,
    required this.awayWin,
    required this.tip,
  });
}

class Predictor {
  // Modelo simples (bom pra MVP):
  // usa média de gols feitos/sofridos + mando de campo
  static PredictorResult predict({
    required Map<String, dynamic> homeStats,
    required Map<String, dynamic> awayStats,
  }) {
    double homeGF = _toDouble(homeStats['goals']['for']['average']['total']);
    double homeGA = _toDouble(homeStats['goals']['against']['average']['total']);
    double awayGF = _toDouble(awayStats['goals']['for']['average']['total']);
    double awayGA = _toDouble(awayStats['goals']['against']['average']['total']);

    // força ofensiva/defensiva básica
    double homeStrength = (homeGF + awayGA) / 2;
    double awayStrength = (awayGF + homeGA) / 2;

    // bônus mando
    homeStrength *= 1.10;

    // normaliza em probabilidades (simples)
    double drawBase = 0.26; // média comum aproximada
    double homeScore = homeStrength;
    double awayScore = awayStrength;

    double total = homeScore + awayScore;
    double homeP = (homeScore / total) * (1 - drawBase);
    double awayP = (awayScore / total) * (1 - drawBase);
    double drawP = drawBase;

    String tip;
    if (homeP > awayP && homeP > drawP) {
      tip = 'Palpite da IA: Vitória Casa';
    } else if (awayP > homeP && awayP > drawP) {
      tip = 'Palpite da IA: Vitória Fora';
    } else {
      tip = 'Palpite da IA: Empate';
    }

    return PredictorResult(
      homeWin: _clamp(homeP),
      draw: _clamp(drawP),
      awayWin: _clamp(awayP),
      tip: tip,
    );
  }

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0.0;
    return 0.0;
  }

  static double _clamp(double v) => v < 0 ? 0 : (v > 1 ? 1 : v);
}
