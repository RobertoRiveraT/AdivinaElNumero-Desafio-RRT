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

class GameController {
  late int secretNumber;
  late int remainingAttempts;
  late int maxNumber;
  late int maxAttempts;
  // Nota: en dart las variables que empiezan con "_" son privadas
  final List<int> _greaterThanList = [];
  final List<int> _lessThanList = [];
  final List<GuessResult> _historyList = [];

  // Getters
  // Como guesser_column contiene strings 
  List<String> get greaterThanList => _greaterThanList.map((e) => '$e').toList();
  List<String> get lessThanList => _lessThanList.map((e) => '$e').toList();
  List<String> get historyList => _historyList
      .map((e) => '${e.number} - ${e.success ? '✔' : '✘'}')
      .toList();

  final Map<String, Map<String, int>> difficultyLevels = {
    'facil':   {'maxNumber': 10,    'maxAttempts': 5},
    'medio':   {'maxNumber': 20,    'maxAttempts': 8},
    'avanzado': {'maxNumber': 100,   'maxAttempts': 15},
    'extremo': {'maxNumber': 1000,  'maxAttempts': 25},
  };

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
    _historyList.clear();
  }

  // devuelve feedback
  String makeGuess(int guess) {
    if (remainingAttempts <= 0) return 'Game over';
    remainingAttempts--;

    if (guess == secretNumber) {
      _historyList.add(GuessResult(guess, true));
      return 'correct';
    }

    if (guess > secretNumber) {
      //  mayor que: el número que ingresamos (guess) es mayor que el número que queremos adivinar (secretNumber)
      _greaterThanList.add(guess);
      _historyList.add(GuessResult(guess, false));
      return 'my alto';
    } else {
      //  menor que: el número que ingresamos (guess) es menor que el número que queremos adivinar (secretNumber)
      _lessThanList.add(guess);
      _historyList.add(GuessResult(guess, false));
      return 'muy bajo';
    }
  }
}

class GuessResult {
  final int number;
  final bool success;
  GuessResult(this.number, this.success);
}
