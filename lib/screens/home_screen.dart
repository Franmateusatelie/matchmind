import 'package:flutter/material.dart';
import '../models/team_model.dart';
import '../models/match_model.dart';
import '../services/football_api.dart';
import 'palpitar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCompetition = 'Brasileirão';

  // Mapeie seus campeonatos para códigos da API
  // OBS: Códigos/competitions podem variar conforme o plano da API
  final Map<String, String> apiCompetitionCodes = const {
    'Brasileirão': 'BSA',
    'Copa do Brasil': 'CBR',     // se não existir no seu plano, vai dar erro
    'Libertadores': 'CLI',       // pode variar / não existir no plano
  };

  final competitions = const [
    'Brasileirão',
    'Copa do Brasil',
    'Libertadores',
  ];

  // Cache simples na tela
  Future<List<MatchModel>>? _futureMatches;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  void _loadMatches() {
    final code = apiCompetitionCodes[selectedCompetition] ?? 'BSA';
    setState(() {
      _futureMatches = _fetchMatchesFromApi(code);
    });
  }

  Future<List<MatchModel>> _fetchMatchesFromApi(String competitionCode) async {
    final raw = await FootballApi.getMatches(competitionCode: competitionCode);

    // Conversão para seu modelo MatchModel
    return raw.map((m) {
      final homeName = (m['homeTeam']?['name'] ?? 'Casa').toString();
      final awayName = (m['awayTeam']?['name'] ?? 'Fora').toString();

      // Como escudos reais têm direitos/licenças, vamos por enquanto usar um ícone genérico
      // Depois a gente liga isso com TheSportsDB (ou seus assets) de forma segura.
      final home = Team(name: homeName, logo: 'assets/teams/default.png');
      final away = Team(name: awayName, logo: 'assets/teams/default.png');

      return MatchModel(home: home, away: away, competition: selectedCompetition);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Image.asset('assets/matchmind_logo.png', height: 100),
            const SizedBox(height: 12),

            // CAMPEONATOS
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: competitions.length,
                itemBuilder: (_, i) {
                  final comp = competitions[i];
                  final selected = comp == selectedCompetition;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedCompetition = comp);
                      _loadMatches();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: selected ? Colors.greenAccent : const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        comp,
                        style: TextStyle(
                          color: selected ? Colors.black : Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: FutureBuilder<List<MatchModel>>(
                future: _futureMatches,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snap.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Erro ao buscar jogos.\n\n${snap.error}\n\nDica: talvez esse campeonato não esteja liberado na sua chave.',
                          style: const TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  final matches = snap.data ?? [];
                  if (matches.isEmpty) {
                    return const Center(
                      child: Text('Nenhum jogo encontrado', style: TextStyle(color: Colors.white70)),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: matches.length,
                    itemBuilder: (_, i) {
                      final match = matches[i];
                      return _matchCard(context, match);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _matchCard(BuildContext context, MatchModel match) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _team(match.home),
              const Text('VS', style: TextStyle(color: Colors.white70)),
              _team(match.away),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PalpitarScreen(
                      match: '${match.home.name} x ${match.away.name}',
                    ),
                  ),
                );
              },
              child: const Text('ANALISAR / PALPITAR', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _team(Team team) {
    return Column(
      children: [
        // Se ainda não tiver default.png, crie: assets/teams/default.png
        Image.asset(team.logo, height: 40, errorBuilder: (_, __, ___) {
          return const Icon(Icons.shield, color: Colors.white70, size: 40);
        }),
        const SizedBox(height: 6),
        SizedBox(
          width: 120,
          child: Text(
            team.name,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

