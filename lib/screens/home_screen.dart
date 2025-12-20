import 'package:flutter/material.dart';
import 'palpitar_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Image.asset(
              'assets/matchmind_logo.png',
              height: 120,
            ),

            const SizedBox(height: 12),

            const Text(
              'PALPITES INTELIGENTES',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            // CAMPEONATOS (SIMULADO)
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _ChampChip('Brasileirão'),
                  _ChampChip('Copa do Brasil'),
                  _ChampChip('Libertadores'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // LISTA DE JOGOS (SIMULADOS)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _MatchCard(
                    home: 'Flamengo',
                    away: 'Palmeiras',
                  ),
                  _MatchCard(
                    home: 'Grêmio',
                    away: 'Internacional',
                  ),
                  _MatchCard(
                    home: 'Corinthians',
                    away: 'São Paulo',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChampChip extends StatelessWidget {
  final String title;
  const _ChampChip(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  final String home;
  final String away;

  const _MatchCard({
    required this.home,
    required this.away,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.35)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _team(home),
              const Text(
                'VS',
                style: TextStyle(color: Colors.white70),
              ),
              _team(away),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PalpitarScreen(
                      match: '$home x $away',
                    ),
                  ),
                );
              },
              child: const Text(
                'ANALISAR / PALPITAR',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _team(String name) {
    return Column(
      children: [
        const Icon(
          Icons.shield,
          color: Colors.white70,
          size: 40,
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 110,
          child: Text(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}


