import 'dart:math';
import 'package:flutter/material.dart';

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
    iaConfidence = 60 + random.nextInt(31); // 60% a 90%
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FUNDO CAMPO DE FUTEBOL
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0B6623), Color(0xFF013220)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  iconTheme:
                      const IconThemeData(color: Colors.greenAccent),
                  title: const Text(
                    'ANÁLISE DO JOGO',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  widget.match,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // PALPITE DA IA
                _card(
                  title: 'PALPITE DA IA',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _info('Resultado sugerido:', iaPick),
                      _info('Placar provável:', iaScore),
                      _info('Confiança da IA:', '$iaConfidence%'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // SEU PALPITE
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
                      userPick == iaPick
                          ? '✔️ Seu palpite concorda com a IA'
                          : '❌ Seu palpite é diferente da IA',
                      style: TextStyle(
                        color: userPick == iaPick
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const Spacer(),

                // CONFIRMAR
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: userPick == null
                          ? null
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Palpite registrado com sucesso!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
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
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.greenAccent.withOpacity(0.5),
        ),
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

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '$label $value',
        style: const TextStyle(
          color: Colors.greenAccent,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


