



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

class GameController {
  late int secretNumber;
  late int remainingAttempts;
  late int maxNumber;
  late int maxAttempts;
  final List<int> greaterThan = [];
  final List<int> lessThan = [];
  final List<GuessResult> history = [];

  void setDifficulty(String level) {
    // Aquí defines los rangos
  }

  String makeGuess(int number) {
    // Validación y lógica del juego
    // Guarda en history[]
  }

  void resetGame() {
    // Reinicia los valores
  }
}

class GuessResult {
  final int number;
  final bool success;
  GuessResult(this.number, this.success);
}
