import 'package:flutter/material.dart';
import '../utils/palpite_engine.dart';
import '../data/historico_palpites.dart';

class PalpitarScreen extends StatefulWidget {
  final String match;

  const PalpitarScreen({super.key, required this.match});

  @override
  State<PalpitarScreen> createState() => _PalpitarScreenState();
}

class _PalpitarScreenState extends State<PalpitarScreen> {
  String? escolhido;
  late Map<String, dynamic> palpiteIA;

  @override
  void initState() {
    super.initState();
    palpiteIA = PalpiteEngine.gerarPalpite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Palpite MatchMind',
          style: TextStyle(color: Colors.greenAccent),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset('assets/matchmind_logo.png', height: 90),
            const SizedBox(height: 12),

            Text(
              widget.match,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),

            const SizedBox(height: 20),

            Text(
              '🤖 Palpite do App: ${palpiteIA['resultado']}',
              style: const TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Placar provável: ${palpiteIA['placar']}',
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 24),

            botao('Vitória Mandante'),
            botao('Empate'),
            botao('Vitória Visitante'),

            const Spacer(),

            ElevatedButton(
              onPressed: escolhido == null
                  ? null
                  : () {
                      HistoricoPalpites.palpites.add({
                        'jogo': widget.match,
                        'palpite': escolhido!,
                        'placar': palpiteIA['placar'],
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Palpite salvo no histórico!'),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'CONFIRMAR PALPITE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget botao(String texto) {
    bool ativo = escolhido == texto;
    return GestureDetector(
      onTap: () {
        setState(() => escolhido = texto);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ativo ? Colors.greenAccent : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            texto,
            style: TextStyle(
              color: ativo ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

