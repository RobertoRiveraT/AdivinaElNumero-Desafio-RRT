import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../ui/widgets/guesser_column.dart';
import '../ui/widgets/level_selector.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GameController _controller;
  final TextEditingController _textCtrl = TextEditingController();
  String _feedback = '';
  int _selectedLevelIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = GameController();
    _controller.setDifficulty('facil'); // por el momento
  }

  void _submitGuess() {
    final input = _textCtrl.text;
    final guess = int.tryParse(input);
    if (guess == null) {
      _feedback = 'Ingrese un número válido';
    } else {
      _feedback = _controller.makeGuess(guess);
    }
    setState(() {}); // dispara rebuild para actualizar intentos y feedback
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // === Este es el contenedor principal centrado ===
        child: Padding(
          padding: const EdgeInsets.all(16),
          // === Padding exterior para separar del borde de la pantalla ===
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // === Selector de nivel de dificultad (arriba de la Card) ===
              LevelSelector(
                controller: _controller,
                selectedIndex: _selectedLevelIndex,
                onLevelChanged: (level) {
                  setState(() {
                    _selectedLevelIndex = _controller.getLevels.indexOf(level);
                    _controller.setDifficulty(level); // reinicia el juego cuando se cambia de nivel 
                  });
                },
              ),
              const SizedBox(height: 16),

              // === Tarjeta principal del juego ===
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // === Primera fila: input del número y contador de intentos ===
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // --- Lado izquierdo: TextField + botón ---
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  controller: _textCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Tu número ( X? )',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: _submitGuess,
                                  child: const Text('Adivinar X'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),

                          // --- Lado derecho: contador de intentos ---
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Intentos',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${_controller.remainingAttempts}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // === Segunda fila: feedback del resultado ===
                      SizedBox(
                        height: 80,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _feedback,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _feedback == 'correcto'
                                      ? Colors.green
                                      : (_feedback == 'Game over'
                                          ? Colors.red
                                          : Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // === Tercera fila: columnas de historial con scroll ===
                      SizedBox(
                        height: 180,
                        child: Row(
                          children: [
                            // Columna: Mayor que
                            GuesserColumn(
                              title: 'mayores que x:',
                              headerColor: Colors.deepPurple,
                              entries: _controller.greaterThanList,
                            ),
                            const SizedBox(width: 8),

                            // Columna: Menor que
                            GuesserColumn(
                              title: 'menores que x:',
                              headerColor: Colors.deepPurple,
                              entries: _controller.lessThanList,
                            ),
                            const SizedBox(width: 8),

                            // Columna: Historial
                            GuesserColumn(
                              title: 'Historial',
                              headerColor: Colors.black,
                              entries: _controller.historyList,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}