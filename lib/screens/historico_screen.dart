import 'package:flutter/material.dart';
import '../data/historico_palpites.dart';

class HistoricoScreen extends StatelessWidget {
  const HistoricoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Histórico de Palpites',
          style: TextStyle(color: Colors.greenAccent),
        ),
        centerTitle: true,
      ),
      body: HistoricoPalpites.palpites.isEmpty
          ? const Center(
              child: Text(
                'Nenhum palpite registrado ainda',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: HistoricoPalpites.palpites.length,
              itemBuilder: (context, index) {
                final item = HistoricoPalpites.palpites[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.greenAccent.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['jogo'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Palpite: ${item['palpite']}',
                        style: const TextStyle(color: Colors.greenAccent),
                      ),
                      Text(
                        'Placar provável: ${item['placar']}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
