import 'package:flutter/material.dart';

class ColumnEntry {
  final int number;
  final int secret;

  ColumnEntry(this.number, this.secret);

  /// Devuelve el número en formato de texto
  String get text => number.toString();

  /// Devuelve un color según la distancia al número secreto
  Color get color {
    final distance = (number - secret).abs();

    if (distance <= 2) return Colors.blue;      // Muy cerca
    if (distance <= 4) return Colors.amber;     // Medio cerca
    return Colors.red;                          // Muy lejos
  }
}

// Tipo de dato específico para la columna del "Historial" de numeros adivinados o fallsdos en adivinar
class ColumnEntryResult extends ColumnEntry {
  final bool success;

  ColumnEntryResult(int number, this.success, int secret)
      : super(number, secret);

  @override
  String get text => '$number - ${success ? '✔' : '✘'}';

  @override
  Color get color => success ? Colors.green : Colors.red;
}