import 'dart:math';

import './field.dart';

class Board {
  Board({
    required this.onEnd,
    required this.onChanged,
  }) {
    // generate the fields
    _fields = List<List<Field>>.generate(
      size,
      (_) => List<Field>.generate(size, (_) => Field()),
    );

    _addBombs();
    _setNumbers();
  }

  static const int size = 10;
  static const int mines = 10;

  final Function(bool didWin) onEnd;
  final Function() onChanged;

  List<List<Field>> _fields = [];
  int minesFlagged = 0;
  int openedFields = 0;

  // int get openFields => fields.fold<int>(
  //       0,
  //       (previousValue, row) =>
  //           previousValue +
  //           row.fold(
  //               0,
  //               (previousValue, element) =>
  //                   element.isOpen ? previousValue + 1 : previousValue),
  //     ); // Functional programming, eh?

  Field field(int x, int y) {
    return _fields[x][y];
  }

  void flag(int x, int y) {
    _fields[x][y].isFlagged = !_fields[x][y].isFlagged;
    if (_fields[x][y].isFlagged) {
      minesFlagged++;
    } else {
      minesFlagged--;
    }
    onChanged();
  }

  void open(int x, int y) {
    if (_fields[x][y].isBomb) onEnd(false);
    if (_fields[x][y].isOpen) return;
    _fields[x][y].isOpen = true;
    openedFields++;
    onChanged();

    if (_fields[x][y].isEmpty) {
      _openEmpty(x, y);
    } else {
      _openEmptyNeighbors(x, y);
    }

    _checkWin();
  }

  //
  // Private methods
  //

  void _checkWin() {
    if (openedFields + mines == size * size) onEnd(true);
  }

  void _openEmpty(int x, int y) {
    // open all around
    if (x > 0) {
      open(x - 1, y);
      if (y > 0) open(x - 1, y - 1);
      if (y < size - 1) open(x - 1, y + 1);
    }
    if (x < size - 1) {
      open(x + 1, y);
      if (y > 0) open(x + 1, y - 1);
      if (y < size - 1) open(x + 1, y + 1);
    }

    if (y > 0) open(x, y - 1);
    if (y < size - 1) open(x, y + 1);
  }

  void _openEmptyNeighbors(int x, int y) {
    if (x > 0 && _fields[x - 1][y].isEmpty) open(x - 1, y);
    if (x < size - 1 && _fields[x + 1][y].isEmpty) open(x + 1, y);
    if (y > 0 && _fields[x][y - 1].isEmpty) open(x, y - 1);
    if (y < size - 1 && _fields[x][y + 1].isEmpty) open(x, y + 1);
  }

  void _addBombs() {
    for (int i = 0; i < mines; i++) {
      final rng = Random();
      final randomFieldWId = rng.nextInt(size);
      final randomFieldHId = rng.nextInt(size);

      if (_fields[randomFieldWId][randomFieldHId].isBomb) {
        i--;
        continue;
      } else {
        _fields[randomFieldWId][randomFieldHId].number = 10;
      }
    }
  }

  void _setNumbers() {
    for (int x = 0; x < size; x++) {
      for (int y = 0; y < size; y++) {
        if (_fields[x][y].isBomb) continue;

        int sum = 0;

        // Left border
        if (x > 0) {
          // Top
          if (y > 0 && _fields[x - 1][y - 1].isBomb) sum++;
          // Middle
          if (_fields[x - 1][y].isBomb) sum++;
          // Bottom
          if (y < size - 1 && _fields[x - 1][y + 1].isBomb) sum++;
        }

        // Right border
        if (x < size - 1) {
          // Top
          if (y > 0 && _fields[x + 1][y - 1].isBomb) sum++;
          // Middle
          if (_fields[x + 1][y].isBomb) sum++;
          // Bottom
          if (y < size - 1 && _fields[x + 1][y + 1].isBomb) sum++;
        }

        if (y > 0 && _fields[x][y - 1].isBomb) sum++;
        if (y < size - 1 && _fields[x][y + 1].isBomb) sum++;

        _fields[x][y].number = sum;
      }
    }
  }
}
