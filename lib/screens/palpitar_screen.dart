import 'dart:math';
import 'package:flutter/material.dart';
import '../data/historico_palpites.dart';

class PalpitarScreen extends StatefulWidget {
  final String match;

  const PalpitarScreen({super.key, required this.match});

  @override
  State<PalpitarScreen> createState() => _PalpitarScreenState();
}

class _PalpitarScreenState extends State<PalpitarScreen> {
  String? userPick;

  late String iaPick;
  late String iaScore;
  late int iaConfidence;

  @override
  void initState() {
    super.initState();
    _generateIaPrediction();
  }

  void _generateIaPrediction() {
    final random = Random();

    final picks = ['1', 'X', '2'];
    iaPick = picks[random.nextInt(3)];

    final homeGoals = random.nextInt(4);
    final awayGoals = random.nextInt(4);

    iaScore = '$homeGoals x $awayGoals';

    iaConfidence = 55 + random.nextInt(36); // 55% a 90%
  }

  @override
  Widget build(BuildContext context) {
    final bool concordou = userPick != null && userPick == iaPick;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'ANÁLISE DO JOGO',
          style: TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.greenAccent),
      ),
      body: Stack(
        children: [
          // FUNDO (CAMPO DE FUTEBOL)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B6623),
                  Color(0xFF013220),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Text(
                  widget.match,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                // PALPITE DA IA
                _card(
                  title: 'PALPITE DA IA',
                  child: Column(
                    children: [
                      _greenText('Resultado sugerido: $iaPick'),
                      const SizedBox(height: 6),
                      _greenText('Placar provável: $iaScore'),
                      const SizedBox(height: 6),
                      _greenText('Confiança: $iaConfidence%'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // PALPITE DO USUÁRIO
                _card(
                  title: 'SEU PALPITE',
                  child: Row(
                    children: [
                      _pickButton('1'),
                      const SizedBox(width: 10),
                      _pickButton('X'),
                      const SizedBox(width: 10),
                      _pickButton('2'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // COMPARAÇÃO
                if (userPick != null)
                  _card(
                    title: 'COMPARAÇÃO',
                    child: Text(
                      concordou
                          ? '✔️ Você concorda com a IA'
                          : '❌ Você discorda da IA',
                      style: TextStyle(
                        color:
                            concordou ? Colors.greenAccent : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                const Spacer(),

                // BOTÃO CONFIRMAR
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: userPick == null
                          ? null
                          : () {
                              HistoricoService.palpites.add(
                                HistoricoPalpite(
                                  campeonato: 'Brasileirão',
                                  jogo: widget.match,
                                  palpiteUsuario: userPick!,
                                  palpiteIa: iaPick,
                                  confiancaIa: iaConfidence,
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    concordou
                                        ? 'Você concordou com a IA ✅'
                                        : 'Palpite salvo (diferente da IA)',
                                  ),
                                  backgroundColor: concordou
                                      ? Colors.green
                                      : Colors.orange,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pickButton(String value) {
    final selected = userPick == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            userPick = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: selected ? Colors.greenAccent : Colors.black,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.greenAccent),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.black : Colors.greenAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _greenText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.greenAccent,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

