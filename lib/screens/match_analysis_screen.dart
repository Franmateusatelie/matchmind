import 'package:flutter/material.dart';

class MatchAnalysisScreen extends StatelessWidget {
  final String match;

  const MatchAnalysisScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Análise da Partida',
          style: TextStyle(color: Colors.greenAccent),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.greenAccent),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // JOGO
            Text(
              match,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // PROBABILIDADES
            _probabilityCard(
              icon: Icons.home,
              label: 'Vitória Casa',
              value: '45%',
              color: Colors.greenAccent,
            ),
            _probabilityCard(
              icon: Icons.balance,
              label: 'Empate',
              value: '28%',
              color: Colors.orangeAccent,
            ),
            _probabilityCard(
              icon: Icons.flight,
              label: 'Vitória Visitante',
              value: '27%',
              color: Colors.redAccent,
            ),

            const SizedBox(height: 20),

            // RESUMO IA
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
              ),
              child: const Text(
                'Resumo da IA:\n\n'
                'O time da casa apresenta leve vantagem devido ao fator '
                'campo e consistência recente. O visitante possui potencial '
                'ofensivo e pode surpreender. O empate é um cenário possível.',
                style: TextStyle(color: Colors.white70, height: 1.4),
              ),
            ),

            const Spacer(),

            // BOTÃO PRO
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Desbloquear MatchMind PRO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Aviso: análises não garantem resultados financeiros.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _probabilityCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
