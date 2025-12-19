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
          'Dar Palpite',
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
              height: 110,
            ),

            const SizedBox(height: 16),

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

            // OPÇÕES DE PALPITE
            palpiteBotao('Vitória Mandante', 'HOME', '1.85'),
            palpiteBotao('Empate', 'DRAW', '3.20'),
            palpiteBotao('Vitória Visitante', 'AWAY', '2.10'),

            const SizedBox(height: 20),

            // MOSTRAR PALPITE ESCOLHIDO
            if (selected != null)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.greenAccent),
                ),
                child: Text(
                  'Seu palpite: $selected',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const Spacer(),

            // CONFIRMAR PALPITE
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selected == null ? Colors.grey : Colors.greenAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: selected == null
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Palpite registrado com sucesso!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                child: const Text(
                  'CONFIRMAR PALPITE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
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
