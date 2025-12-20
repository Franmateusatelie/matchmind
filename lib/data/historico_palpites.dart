class HistoricoPalpite {
  final String campeonato;
  final String jogo;
  final String palpiteUsuario;
  final String palpiteIa;
  final int confiancaIa;

  HistoricoPalpite({
    required this.campeonato,
    required this.jogo,
    required this.palpiteUsuario,
    required this.palpiteIa,
    required this.confiancaIa,
  });
}

class HistoricoService {
  static final List<HistoricoPalpite> palpites = [];
}
