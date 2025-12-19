import 'package:flutter/material.dart';

class MatchAnalysisScreen extends StatelessWidget {
  final String match;

  const MatchAnalysisScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.asset(
          'assets/matchmind_logo.png',
          height: 36,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _matchCard(),
            const SizedBox(height: 16),
            _predictionCard(),
            const SizedBox(height: 16),
            _scoreCard(),
            const SizedBox(height: 16),
            _oddsCard(),
          ],
        ),
      ),
    );
  }

  Widget _matchCard() {
    return _card(
      child: Column(
        children: [
          Text(
            match,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Análise Inteligente por IA',
            style: TextStyle(color: Colors.greenAccent),
          ),
        ],
      ),
    );
  }

  Widget _predictionCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'PALPITE DA IA',
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Vitória do mandante',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Probabilidade estimada: 64%',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _scoreCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'PLACAR PROVÁVEL',
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              '2 x 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _oddsCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ODDS SIMULADAS',
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _oddRow('Mandante', '1.65'),
          _oddRow('Empate', '3.40'),
          _oddRow('Visitante', '4.80'),
        ],
      ),
    );
  }

  Widget _oddRow(String label, String odd) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              odd,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.greenAccent.withOpacity(0.3),
        ),
      ),
      child: child,
    );
  }
}
