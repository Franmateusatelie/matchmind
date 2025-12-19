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
  bool confirmado = false;

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
            const SizedBox(height: 10),

            Text(
              widget.match,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // PALPITE DA IA
            _card(
              title: '🤖 Palpite da IA',
              content:
                  '${palpiteIA['resultado']} | Placar provável: ${palpiteIA['placar']}',
              color: Colors.greenAccent,
            ),

            const SizedBox(height: 16),

            // OPÇÕES DO USUÁRIO
            _botao('Vitória Mandante'),
            _botao('Empate'),
            _botao('Vitória Visitante'),

            const Spacer(),

            // CONFIRMAR
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      escolhido == null ? Colors.grey : Colors.greenAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: escolhido == null
                    ? null
                    : () {
                        setState(() {
                          confirmado = true;
                        });

                        HistoricoPalpites.palpites.add({
                          'jogo': widget.match,
                          'palpite': escolhido!,
                          'placar': palpiteIA['placar'],
                          'ia': palpiteIA['resultado'],
                        });
                      },
                child: const Text(
                  'CONFIRMAR PALPITE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // RESULTADO DA COMPARAÇÃO
            if (confirmado)
              _card(
                title: '📊 Comparação',
                content: escolhido == palpiteIA['resultado']
                    ? 'Você concordou com a IA ✅'
                    : 'Seu palpite foi diferente da IA ❌',
                color: escolhido == palpiteIA['resultado']
                    ? Colors.greenAccent
                    : Colors.redAccent,
              ),
          ],
        ),
      ),
    );
  }

  Widget _botao(String texto) {
    final ativo = escolhido == texto;

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

  Widget _card({
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
