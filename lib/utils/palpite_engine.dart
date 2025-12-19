import 'dart:math';

class PalpiteEngine {
  static final _rand = Random();

  static Map<String, dynamic> gerarPalpite() {
    int home = 40 + _rand.nextInt(30); // 40 a 70
    int away = 100 - home - _rand.nextInt(10);
    int draw = 100 - home - away;

    String resultado;
    if (home > away && home > draw) {
      resultado = 'Vitória Mandante';
    } else if (away > home && away > draw) {
      resultado = 'Vitória Visitante';
    } else {
      resultado = 'Empate';
    }

    int golsCasa = _rand.nextInt(3) + 1;
    int golsFora = _rand.nextInt(3);

    return {
      'resultado': resultado,
      'placar': '$golsCasa x $golsFora',
      'home': home,
      'draw': draw,
      'away': away,
    };
  }
}
