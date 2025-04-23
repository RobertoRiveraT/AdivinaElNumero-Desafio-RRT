///  `final` 
// significa que la variable solo puede asignarse UNA VEZ (como una constante),
// pero su valor puede calcularse en tiempo de ejecución.
// Ideal para valores que no cambian una vez asignados.
// final int maxAttempts = 5;
// final protege la referencia, no el contenido. 
// Es decir, listas como -history- siempre apuntarán a la misma lista en memoria, pero esa lista puede cambiar internamente.

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
  final List<int> greaterThan = [];
  final List<int> lessThan = [];
  final List<GuessResult> history = [];

  /// Configura el nivel de dificultad: ajusta rangos y reinicia el juego
  void setDifficulty(String level) {
    switch (level.toLowerCase()) {
      case 'facil':
        maxNumber = 10;
        maxAttempts = 5;
        break;
      case 'medio':
        maxNumber = 20;
        maxAttempts = 8;
        break;
      case 'avanzado':
        maxNumber = 100;
        maxAttempts = 15;
        break;
      case 'extremo':
        maxNumber = 1000;
        maxAttempts = 25;
        break;
      default:
        maxNumber = 10;
        maxAttempts = 5;
    }
    resetGame(); // inicializa secretNumber y remainingAttempts
  }

  // Genera nuevo número secreto y reinicia contadores y listas
  void resetGame() {
    final rand = Random();
    secretNumber = rand.nextInt(maxNumber) + 1;
    remainingAttempts = maxAttempts;
    greaterThan.clear();
    lessThan.clear();
    history.clear();
  }

  // devuelve feedback
  String makeGuess(int guess) {
    if (remainingAttempts <= 0) return 'Game over';
    remainingAttempts--;

    if (guess == secretNumber) {
      history.add(GuessResult(guess, true));
      return 'correct';
    }

    if (guess > secretNumber) {
      greaterThan.add(guess);
      history.add(GuessResult(guess, false));
      return 'my alto';
    } else {
      lessThan.add(guess);
      history.add(GuessResult(guess, false));
      return 'muy bajo';
    }
  }
}

class GuessResult {
  final int number;
  final bool success;
  GuessResult(this.number, this.success);
}
