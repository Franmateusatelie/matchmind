import 'package:flutter/material.dart';
import '../data/historico_palpites.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palpites = HistoricoService.palpites;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Histórico de Palpites',
          style: TextStyle(color: Colors.greenAccent),
        ),
        iconTheme: const IconThemeData(color: Colors.greenAccent),
      ),
      body: palpites.isEmpty
          ? const Center(
              child: Text(
                'Nenhum palpite registrado ainda',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: palpites.length,
              itemBuilder: (_, i) {
                final p = palpites[i];
                final concordou = p.palpiteUsuario == p.palpiteIa;

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: concordou
                          ? Colors.greenAccent
                          : Colors.orangeAccent,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.campeonato,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        p.jogo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Seu palpite: ${p.palpiteUsuario}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        'Palpite IA: ${p.palpiteIa}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        'Confiança IA: ${p.confiancaIa}%',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        concordou
                            ? '✔ Concordou com a IA'
                            : '✖ Divergiu da IA',
                        style: TextStyle(
                          color: concordou
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
