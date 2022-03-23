class Field {
  int number = 0;
  bool isOpen = false;

  bool _isFlagged = false;
  get isFlagged => _isFlagged && !isOpen;
  set isFlagged(val) => _isFlagged = val;

  get isBomb => number == 10;
  get isEmpty => number == 0;
}
