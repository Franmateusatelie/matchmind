import 'package:flutter/material.dart';
import '../data/favoritos.dart';
import 'palpitar_screen.dart';
import 'historico_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SafeArea(
        child: Column(
          children: [
            // LOGO
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/matchmind_logo.png',
                    height: 140,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'PALPITES INTELIGENTES',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            // BOTÃO HISTÓRICO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton.icon(
                icon: const Icon(Icons.history),
                label: const Text('HISTÓRICO'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.greenAccent,
                  side: const BorderSide(color: Colors.greenAccent),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HistoricoScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // LISTA DE JOGOS
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _card(context, 'Flamengo', 'Palmeiras'),
                  _card(context, 'Grêmio', 'Internacional'),
                  _card(context, 'Corinthians', 'São Paulo'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context, String home, String away) {
    final bool favHome = Favoritos.isFavorito(home);
    final bool favAway = Favoritos.isFavorito(away);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LINHA DOS TIMES + ESTRELAS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$home x $away',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      favHome ? Icons.star : Icons.star_border,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        Favoritos.toggle(home);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      favAway ? Icons.star : Icons.star_border,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        Favoritos.toggle(away);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
