import 'package:flutter/material.dart';
import '../../controllers/game_controller.dart';

class LevelSelector extends StatelessWidget {
  final GameController controller;
  final Function(String) onLevelChanged;
  final int selectedIndex;

  const LevelSelector({
    super.key,
    required this.controller,
    required this.onLevelChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final levels = controller.getLevels;

    return Column(
      children: [
        Text(
          'Dificultad: ${levels[selectedIndex].toUpperCase()} ${controller.getBoundaries()}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: selectedIndex.toDouble(),
          min: 0,
          max: (levels.length - 1).toDouble(),
          divisions: levels.length - 1,
          label: levels[selectedIndex],
          onChanged: (value) {
            onLevelChanged(levels[value.toInt()]);
          },
        ),
      ],
    );
  }
}
