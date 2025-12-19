import 'package:flutter/material.dart';
import 'match_analysis_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'MatchMind',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          MatchCard(home: 'Flamengo', away: 'Palmeiras'),
          MatchCard(home: 'Santos', away: 'Corinthians'),
          MatchCard(home: 'Internacional', away: 'Atlético-MG'),
          MatchCard(home: 'Grêmio', away: 'Fluminense'),
        ],
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final String home;
  final String away;

  const MatchCard({
    super.key,
    required this.home,
    required this.away,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: ListTile(
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MatchAnalysisScreen(
        match: '$home x $away',
      ),
    ),
  );
},

        title: Text(
          '$home x $away',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          'Toque para ver análise por IA',
          style: TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.greenAccent),
      ),
    );
  }
}
