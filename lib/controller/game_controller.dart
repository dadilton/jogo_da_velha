import 'package:flutter/material.dart';
import 'package:jogo_da_velha/model/quadrado.dart';

//enum para informar quais jogadores podem ser mencionados no game
enum Jogador { xis, bola, nenhum }

//classe controle, que implementa as regras do jogo
class GameController {
  //lista contendo os estados dos quadrados que são exibidos nojogo
  List<Quadrado> quadrados = [];
  //próximo jogador que deverá fazer o movimento
  Jogador jogadorAtual = Jogador.xis;
  //listas de movimentos feitos pelos jogadores
  List<int> posicoesJogadorXis = [];
  List<int> posicoesJogadorBola = [];

  //construtor do controller. Para iniciar o jogo como se estivesse resetado pela primeira vez
  GameController() {
    _inicializaGame();
  }

  //função para iniciar o jogo. Deverá ser chamada no início do jogo, e quando o jogo for resetado
  _inicializaGame() {
    //gerando os nove quadrados vazios
    quadrados = List<Quadrado>.generate(9, (index) => Quadrado(index + 1));
    //limpa os movimentos dos jogadores
    posicoesJogadorXis.clear();
    posicoesJogadorBola.clear();
    //definindo o primeiro jogador da jogada
    jogadorAtual = Jogador.xis;
  }

  //método que permite o jogador marcar um quadrado. O id será passado pelo botão correspondente
  marcarQuadradoPorId(int id) {
    final quadrado = quadrados[id];
    if (jogadorAtual == Jogador.xis) {
      _marcarParaJogadorXis(quadrado);
    } else {
      _marcarParaJogadorBola(quadrado);
    }
  }

  //marca o quadrado para o jogador xis
  _marcarParaJogadorXis(Quadrado quadrado) {
    //atribui o símbolo X que será mostrado no quadrado
    quadrado.simbolo = "X";
    //atribui a cor que será visualizada no quadrado
    quadrado.cor = Colors.red;
    //desabilita o quadrado para ninguém mexer
    quadrado.habilitado = false;
    //adiciona o movimento do jogador na sua lista
    posicoesJogadorXis.add(quadrado.id);
    //o próximo jogador, será o jogador bola
    jogadorAtual = Jogador.bola;
  }

  //marca o quadrado para o jogador bola
  _marcarParaJogadorBola(Quadrado quadrado) {
    //atribui o símbolo O que será mostrado no quadrado
    quadrado.simbolo = "O";
    //atribui a cor que será visualizada no quadrado
    quadrado.cor = Colors.blue;
    //desabilita o quadrado para ninguém mais marcar
    quadrado.habilitado = false;
    //adiciona o movimento do jogador na sua lista de movimentos
    posicoesJogadorBola.add(quadrado.id);
    //o próximo jogador será o jogador xis
    jogadorAtual = Jogador.xis;
  }

  Jogador verificaVencedor() {
    //verificando se o jogador xis ganhou
    if (_verificaSeJogadorEhVencedor(posicoesJogadorXis)) {
      return Jogador.xis;
    }
    //verificando se o jogador bola ganhou
    if (_verificaSeJogadorEhVencedor(posicoesJogadorBola)) {
      return Jogador.bola;
    }
    //se nenhum deles ganhou, ainda
    return Jogador.nenhum;
  }

  _verificaSeJogadorEhVencedor(List<int> posicoes) {
    //abaixo, as jogadas ganhadoras possíveis
    //lembrar que os quadrados estão disponibilizados com os ids assim
    //  1  2  3    --> primeira linha
    //  4  5  6    --> segunda linha
    //  7  8  9    --> terceira linha

    final jogadasVencedoras = [
      [1, 2, 3], //0
      [4, 5, 6], //1
      [7, 8, 9], //2
      [1, 4, 7], //3
      [2, 5, 8], //4
      [3, 6, 9], //5
      [1, 5, 9], //6
      [3, 5, 7], //7
    ];

    //aqui, compara-se as jogadas vencedoras, uma a uma, com as jogadas que o jogador já fez
    return jogadasVencedoras.any((jogadaVencedora) =>
        posicoes.contains(jogadaVencedora[0]) &&
        posicoes.contains(jogadaVencedora[1]) &&
        posicoes.contains(jogadaVencedora[2]));
  }

  //verifica se ainda pode ser feito mais algum movimento
  bool aindaTemMovimento() {
    return (posicoesJogadorBola.length + posicoesJogadorXis.length) < 9;
  }

  //para resetar o jogo
  resetarJogo() {
    _inicializaGame();
  }
}
