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
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Jogo
            Text(
              match,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            _probCard(
              icon: Icons.home,
              label: 'Probabilidade Casa',
              value: '45%',
              color: Colors.greenAccent,
            ),
            _probCard(
              icon: Icons.balance,
              label: 'Probabilidade Empate',
              value: '28%',
              color: Colors.amberAccent,
            ),
            _probCard(
              icon: Icons.flight_takeoff,
              label: 'Probabilidade Visitante',
              value: '27%',
              color: Colors.redAccent,
            ),

            const SizedBox(height: 20),

            const Text(
              'Resumo da IA',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'O time da casa tem vantagem jogando em seus domínios, '
              'mas o visitante apresenta bom desempenho recente. '
              'O empate não pode ser descartado.',
              style: TextStyle(color: Colors.white70),
            ),

            const Spacer(),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.greenAccent),
              ),
              child: Column(
                children: const [
                  Text(
                    'Conteúdo PRO bloqueado',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Assine para desbloquear análises avançadas',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Desbloquear MatchMind Pro',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _probCard({
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
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
