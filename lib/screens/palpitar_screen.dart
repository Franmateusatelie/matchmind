import 'package:flutter/material.dart';

class PalpitarScreen extends StatefulWidget {
  final String match;

  const PalpitarScreen({super.key, required this.match});

  @override
  State<PalpitarScreen> createState() => _PalpitarScreenState();
}

class _PalpitarScreenState extends State<PalpitarScreen> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Palpite',
          style: TextStyle(color: Colors.greenAccent),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // LOGO
            Image.asset(
              'assets/matchmind_logo.png',
              height: 120,
            ),

            const SizedBox(height: 20),

            // JOGO
            Text(
              widget.match,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // BOTÕES DE PALPITE
            palpiteBotao('Vitória Casa', 'HOME', '1.85'),
            palpiteBotao('Empate', 'DRAW', '3.20'),
            palpiteBotao('Vitória Visitante', 'AWAY', '2.10'),

            const SizedBox(height: 30),

            // IA SUGESTÃO
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
              ),
              child: Column(
                children: const [
                  Text(
                    '🤖 Análise MatchMind IA',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Placar provável: 2 x 1\nProbabilidade: 64%',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget palpiteBotao(String texto, String valor, String odd) {
    final bool ativo = selected == valor;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = valor;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: ativo ? Colors.greenAccent : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              texto,
              style: TextStyle(
                color: ativo ? Colors.black : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              odd,
              style: TextStyle(
                color: ativo ? Colors.black : Colors.greenAccent,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
