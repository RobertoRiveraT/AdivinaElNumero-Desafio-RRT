///  `final` 
// significa que la variable solo puede asignarse UNA VEZ (como una constante),
// pero su valor puede calcularse en tiempo de ejecución.
// Ideal para valores que no cambian una vez asignados.
// final int maxAttempts = 5;
// final protege la referencia, no el contenido. 
// Es decir, listas como -_historyList- siempre apuntarán a la misma lista en memoria, pero esa lista puede cambiar internamente.

// - `final List`: no puedo cambiar la referencia, pero sí su contenido (agregar, quitar).
// - `const List`: no puedo cambiar ni la referencia ni su contenido. Es totalmente inmutable.

/// `late` 
// le dice al compilador: “prometo que esta variable será inicializada antes de usarse”.
// Se usa cuando no puedes inicializarla al declararla, pero SABES que tendrá un valor más adelante.
// late int secretNumber;

import 'dart:math';
import 'package:flutter/material.dart';
import '../models/column_entry.dart'; // 👈 Asegúrate de importar tus modelos

class GameController {
  late int secretNumber;
  late int remainingAttempts;
  late int maxNumber;
  late int maxAttempts;

  // Nota: en dart las variables que empiezan con "_" son privadas
  final List<ColumnEntry> _greaterThanList = [];
  final List<ColumnEntry> _lessThanList = [];
  final List<ColumnEntryResult> _historyList = [];

  // Level Configurations
  final Map<String, Map<String, int>> difficultyLevels = {
    'facil':    {'maxNumber': 10,    'maxAttempts': 5},
    'medio':    {'maxNumber': 20,    'maxAttempts': 8},
    'avanzado': {'maxNumber': 100,   'maxAttempts': 15},
    'extremo':  {'maxNumber': 1000,  'maxAttempts': 25},
  };

  // Getters
  List<ColumnEntry> get greaterThanList => _greaterThanList;
  List<ColumnEntry> get lessThanList => _lessThanList;
  List<ColumnEntryResult> get historyList => _historyList;

  List<String> get getLevels => difficultyLevels.keys.toList();

  /// Configura el nivel de dificultad desde un mapa predefinido
  void setDifficulty(String level) {
    final normalizedLevel = level.toLowerCase();

    if (difficultyLevels.containsKey(normalizedLevel)) {
      final config = difficultyLevels[normalizedLevel]!;
      maxNumber = config['maxNumber']!;
      maxAttempts = config['maxAttempts']!;
    } else {
      // Valor por defecto
      maxNumber = 10;
      maxAttempts = 5;
    }

    resetGame();
  }

  // Genera nuevo número secreto y reinicia contadores y listas
  void resetGame() {
    final rand = Random();
    secretNumber = rand.nextInt(maxNumber) + 1;
    remainingAttempts = maxAttempts;

    _greaterThanList.clear();
    _lessThanList.clear();
    // _historyList.clear(); // No limpiar el historial
  }

  // Devuelve feedback textual y actualiza historial
  String makeGuess(int guess) {
    if ((remainingAttempts <= 1) && !(guess == secretNumber) ) {
      // la respuesta no se adivinó, mostrar la respeusta en rojo con un "X"
      _historyList.add(ColumnEntryResult(secretNumber, false, secretNumber));
      resetGame();
      return 'Perdiste !!';
    }

    remainingAttempts--;

    if (guess == secretNumber) {
      _historyList.add(ColumnEntryResult(guess, true, secretNumber));
      resetGame();
      return 'correct';
    }

    if (guess > secretNumber) {
      _greaterThanList.add(ColumnEntry(guess, secretNumber));
      // _historyList.add(ColumnEntryResult(guess, false, secretNumber));
      return 'muy alto';
    } else {
      _lessThanList.add(ColumnEntry(guess, secretNumber));
      // _historyList.add(ColumnEntryResult(guess, false, secretNumber));
      return 'muy bajo';
    }
  }
}
