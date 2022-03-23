import 'package:flutter/material.dart';
import 'package:mines/model/board.dart';
import 'package:mines/view/components/field_view.dart';

import 'dart:math';

class BoardView extends StatelessWidget {
  const BoardView({
    required this.board,
    Key? key,
  }) : super(key: key);

  final Board board;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final sizeUnit = min(c.maxHeight, c.maxWidth) / 10;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < Board.size; i++)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int j = 0; j < Board.size; j++)
                    SizedBox(
                      width: sizeUnit,
                      height: sizeUnit,
                      child: FieldView(board, i, j),
                    )
                ],
              ),
          ],
        );
      },
    );
  }
}
