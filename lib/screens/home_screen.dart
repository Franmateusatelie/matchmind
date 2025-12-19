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
            // LOGO + TÍTULO
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Image.asset(
                    'assets/matchmind_logo.png',
                    height: 140, // LOGO MAIOR
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
                ],
              ),
            ),

            // LISTA DE JOGOS
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  MatchBetCard(
                    home: 'Flamengo',
                    away: 'Palmeiras',
                    probHome: 52,
                    probDraw: 26,
                    probAway: 22,
                    oddHome: 1.85,
                    oddDraw: 3.10,
                    oddAway: 4.20,
                  ),
                  MatchBetCard(
                    home: 'Grêmio',
                    away: 'Internacional',
                    probHome: 48,
                    probDraw: 28,
                    probAway: 24,
                    oddHome: 2.05,
                    oddDraw: 3.00,
                    oddAway: 3.90,
                  ),
                  MatchBetCard(
                    home: 'Corinthians',
                    away: 'São Paulo',
                    probHome: 44,
                    probDraw: 30,
                    probAway: 26,
                    oddHome: 2.20,
                    oddDraw: 3.05,
                    oddAway: 3.60,
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

class MatchBetCard extends StatelessWidget {
  final String home;
  final String away;
  final int probHome;
  final int probDraw;
  final int probAway;
  final double oddHome;
  final double oddDraw;
  final double oddAway;

  const MatchBetCard({
    super.key,
    required this.home,
    required this.away,
    required this.probHome,
    required this.probDraw,
    required this.probAway,
    required this.oddHome,
    required this.oddDraw,
    required this.oddAway,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TIMES
          Text(
            '$home x $away',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // PROBABILIDADES
          _probRow('Vitória $home', probHome),
          _probRow('Empate', probDraw),
          _probRow('Vitória $away', probAway),

          const SizedBox(height: 12),

          // ODDS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _oddBox('1', oddHome),
              _oddBox('X', oddDraw),
              _oddBox('2', oddAway),
            ],
          ),

          const SizedBox(height: 16),

          // BOTÃO FUNCIONANDO
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
                'ANALISAR / DAR PALPITE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _probRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          Text(
            '$value%',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _oddBox(String label, double odd) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0E0E0E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 4),
          Text(
            odd.toStringAsFixed(2),
            style: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

