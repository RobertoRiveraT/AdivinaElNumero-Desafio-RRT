import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';

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
  int _counter = 0;
  late GameController _controller;
  final TextEditingController _textCtrl = TextEditingController();
  String _feedback = '';

  /*
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  */

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
          // === Padding exterior que separa del borde de la pantalla ===
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            // === Este es el contenedor principal de la Card ===
            child: Padding(
              padding: const EdgeInsets.all(16),
              // === Padding interior dentro de la Card ===
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // === Sección IZQUIERDA de la Card: input y botón ===
                  Expanded(
                    child: Column(
                      children: [
                        // --- Aquí va el TextField de entrada de número ---
                        TextField(
                          controller: _textCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Tu número',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // --- Botón para enviar la conjetura ---
                        ElevatedButton(
                          onPressed: _submitGuess,
                          child: const Text('Adivinar'),
                        ),
                        const SizedBox(height: 8),
                        // --- Texto de feedback (muy alto / muy bajo / correct) ---
                        Text(_feedback),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // === Sección DERECHA de la Card: contador de intentos ===
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // --- Etiqueta estática "Intentos" ---
                      const Text(
                        'Intentos',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      // --- Aquí mostramos el número de intentos restantes ---
                      Text(
                        '${_controller.remainingAttempts}',
                        style: const TextStyle(fontSize: 32, color: Colors.indigo),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}