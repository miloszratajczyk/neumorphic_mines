import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mines/model/board.dart';
import 'package:mines/view/styles/constants.dart';

class FieldView extends StatelessWidget {
  const FieldView(
    this.board,
    this.x,
    this.y, {
    Key? key,
  }) : super(key: key);

  final Board board;
  final int x;
  final int y;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final field = board.field(x, y);

    Widget? child;
    if (field.isOpen && field.isBomb) {
      child = Icon(
        Icons.brightness_high_outlined,
        color: colorScheme.primary,
      );
    } else if (field.isOpen && !field.isEmpty) {
      child = Center(
        child: Text(
          field.number.toString(),
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      );
    } else if (field.isFlagged) {
      child = Icon(
        Icons.flag,
        color: colorScheme.primary,
      );
    }

    return GestureDetector(
      onTap: () => board.open(x, y),
      onLongPress: () => board.flag(x, y),
      child: Neumorphic(
        margin:
            field.isOpen ? const EdgeInsets.all(4) : const EdgeInsets.all(6),
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          depth: field.isOpen ? -4 : 4,
          lightSource:
              field.isFlagged ? LightSource.bottomRight : LightSource.topLeft,
          color: colorScheme.primaryContainer,
        ),
        duration: durationM,
        child: child,
      ),
    );
  }
}
