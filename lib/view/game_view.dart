import 'package:flutter/material.dart';
import 'package:jogo_da_velha/controller/game_controller.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  GameController gameController = GameController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _clicaNoQuadrado(index),
                  child: Container(
                    color: gameController.quadrados[index].cor,
                    child: Center(
                      child: Text(gameController.quadrados[index].simbolo),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _clicaNoQuadrado(int index) {
    if (!gameController.quadrados[index].habilitado) return;
    setState(() {
      gameController.marcarQuadradoPorId(index);
    });
    _verificaVencedor();
  }

  _verificaVencedor() {
    var vencedor = gameController.verificaVencedor();
    if (vencedor == Jogador.nenhum) {
      if (!gameController.aindaTemMovimento()) {
        mostraDialog("Deu velha!!");
      }
    } else {
      mostraDialog(
          "E o vencedor é ${(vencedor == Jogador.xis) ? "Xis" : "Bola"} !!!");
    }
  }

  mostraDialog(String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text(mensagem),
          content: const Text("Pressione 'reset' para reiniciar"),
          actions: [
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  gameController.resetarJogo();
                });
              },
            ),
          ]),
    );
  }
}
