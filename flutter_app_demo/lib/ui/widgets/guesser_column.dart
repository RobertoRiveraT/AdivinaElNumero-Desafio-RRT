import 'package:flutter/material.dart';
import '../../models/column_entry.dart';

class GuesserColumn extends StatefulWidget {
  final String title;
  final Color headerColor;
  final List<ColumnEntry> entries;

  const GuesserColumn({
    super.key,
    required this.title,
    this.headerColor = Colors.black87,
    required this.entries,
  });

  @override
  State<GuesserColumn> createState() => _GuesserColumnState();
}

class _GuesserColumnState extends State<GuesserColumn> {
  final ScrollController _scrollController = ScrollController();

  /// Limpia las entradas de la columna
  void clearColumn() {
    setState(() {
      widget.entries.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // --- Header fijo ---
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.headerColor,
            ),
          ),
          const SizedBox(height: 8),
          // --- Lista con scroll automático ---
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.entries.length,
                itemBuilder: (context, index) {
                  final entry = widget.entries[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      entry.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: entry.color,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
