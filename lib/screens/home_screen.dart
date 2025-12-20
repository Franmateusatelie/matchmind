import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/football_api.dart';
import 'palpitar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int ligaSelecionada = 71; // 71 = Brasileirão Série A
  bool loading = true;

  List<Map<String, dynamic>> jogos = [];

  final ligas = [
    {
      'id': 71,
      'nome': 'Série A',
      'icon': 'assets/campeonatos/brasileirao_a.png',
    },
    {
      'id': 72,
      'nome': 'Série B',
      'icon': 'assets/campeonatos/brasileirao_b.png',
    },
    {
      'id': 73,
      'nome': 'Copa do Brasil',
      'icon': 'assets/campeonatos/copa_brasil.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _carregarJogos();
  }

  Future<void> _carregarJogos() async {
    setState(() => loading = true);

    final hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final response = await FootballApi.getFixturesByLeagueAndDate(
        leagueId: ligaSelecionada,
        season: DateTime.now().year,
        dateYYYYMMDD: hoje,
      );

      setState(() {
        jogos = response;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            Image.asset('assets/matchmind_logo.png', height: 110),

            const SizedBox(height: 8),

            const Text(
              'PALPITES INTELIGENTES',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            // CAMPEONATOS
            SizedBox(
              height: 90,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: ligas.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final liga = ligas[index];
                  final ativo = liga['id'] == ligaSelecionada;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        ligaSelecionada = liga['id'] as int;
                      });
                      _carregarJogos();
                    },
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        color:
                            ativo ? Colors.greenAccent : const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.greenAccent.withOpacity(0.5),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(liga['icon'] as String, height: 32),
                          const SizedBox(height: 6),
                          Text(
                            liga['nome'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: ativo ? Colors.black : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // JOGOS
            Expanded(
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      ),
                    )
                  : jogos.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum jogo hoje',
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : ListView.builder(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: jogos.length,
                          itemBuilder: (context, index) {
                            final j = jogos[index];
                            final home = j['teams']['home'];
                            final away = j['teams']['away'];
                            final date =
                                DateTime.parse(j['fixture']['date']);

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color:
                                      Colors.greenAccent.withOpacity(0.3),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _time(home['logo'], home['name']),
                                      const Text(
                                        'X',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      _time(away['logo'], away['name']),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    DateFormat('HH:mm').format(date),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.greenAccent,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => PalpitarScreen(
                                              match:
                                                  '${home['name']} x ${away['name']}',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'ANALISAR / PALPITAR',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _time(String logoUrl, String nome) {
    return Column(
      children: [
        Image.network(logoUrl, height: 40),
        const SizedBox(height: 6),
        Text(
          nome,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}






