import 'package:flutter/material.dart';

class Quadrado {
  int id;
  String simbolo;
  Color cor;
  bool habilitado;

  Quadrado(
    this.id, {
    this.simbolo = '',
    this.cor = Colors.black26,
    this.habilitado = true,
  });
}
