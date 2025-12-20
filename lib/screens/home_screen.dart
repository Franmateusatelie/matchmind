import 'package:flutter/material.dart';
import 'palpitar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String campeonatoSelecionado = 'BRASILEIRAO_A';

  final campeonatos = [
    {
      'id': 'BRASILEIRAO_A',
      'nome': 'Série A',
      'icon': 'assets/campeonatos/brasileirao_a.png',
    },
    {
      'id': 'BRASILEIRAO_B',
      'nome': 'Série B',
      'icon': 'assets/campeonatos/brasileirao_b.png',
    },
    {
      'id': 'COPA_BRASIL',
      'nome': 'Copa do Brasil',
      'icon': 'assets/campeonatos/copa_brasil.png',
    },
  ];

  final jogos = [
    {
      'campeonato': 'BRASILEIRAO_A',
      'home': 'Flamengo',
      'away': 'Palmeiras',
      'homeIcon': 'assets/times/flamengo.png',
      'awayIcon': 'assets/times/palmeiras.png',
      'hora': '21:30',
      'data': 'Hoje',
    },
    {
      'campeonato': 'BRASILEIRAO_A',
      'home': 'Corinthians',
      'away': 'São Paulo',
      'homeIcon': 'assets/times/corinthians.png',
      'awayIcon': 'assets/times/saopaulo.png',
      'hora': '19:00',
      'data': 'Hoje',
    },
    {
      'campeonato': 'BRASILEIRAO_B',
      'home': 'Sport',
      'away': 'Ceará',
      'homeIcon': 'assets/times/sport.png',
      'awayIcon': 'assets/times/ceara.png',
      'hora': '18:30',
      'data': 'Amanhã',
    },
    {
      'campeonato': 'COPA_BRASIL',
      'home': 'Grêmio',
      'away': 'Internacional',
      'homeIcon': 'assets/times/gremio.png',
      'awayIcon': 'assets/times/internacional.png',
      'hora': '20:00',
      'data': 'Amanhã',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final jogosFiltrados =
        jogos.where((j) => j['campeonato'] == campeonatoSelecionado).toList();

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
                itemCount: campeonatos.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final camp = campeonatos[index];
                  final ativo = camp['id'] == campeonatoSelecionado;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        campeonatoSelecionado = camp['id']!;
                      });
                    },
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        color: ativo
                            ? Colors.greenAccent
                            : const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.greenAccent.withOpacity(0.5),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(camp['icon']!, height: 32),
                          const SizedBox(height: 6),
                          Text(
                            camp['nome']!,
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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: jogosFiltrados.length,
                itemBuilder: (context, index) {
                  final j = jogosFiltrados[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.greenAccent.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        // TIMES
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _time(j['homeIcon']!, j['home']!),
                            const Text(
                              'X',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _time(j['awayIcon']!, j['away']!),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Text(
                          '${j['data']} • ${j['hora']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                              foregroundColor: Colors.black,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PalpitarScreen(
                                    match:
                                        '${j['home']} x ${j['away']}',
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

  Widget _time(String icon, String nome) {
    return Column(
      children: [
        Image.asset(icon, height: 40),
        const SizedBox(height: 6),
        Text(
          nome,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}





