import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mines/view/components/board_view.dart';
import 'package:mines/view/styles/constants.dart';

import '../model/board.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Board board;
  String message = "";
  bool gameEnded = false;

  @override
  void initState() {
    super.initState();
    _newGame();
  }

  void _newGame() {
    board = Board(
      onEnd: (didWin) {
        setState(() {
          gameEnded = true;
          message = didWin ? "You won" : "You lost";
        });
      },
      onChanged: () {
        setState(() {});
      },
    );
    gameEnded = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final defaultTextStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.onPrimaryContainer,
    );
    return Scaffold(
      body: DefaultTextStyle(
        style: defaultTextStyle ?? const TextStyle(),
        child: Container(
          color: colorScheme.primaryContainer,
          padding: paddingS,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTitle(context),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      BoardView(board: board),
                      _buildBoardOverlay(context),
                    ],
                  ),
                ),
                _buildBottomBar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildTitle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: spaceM),
      child: Text(
        "Mines",
        style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
      ),
    );
  }

  IgnorePointer _buildBoardOverlay(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return IgnorePointer(
      ignoring: !gameEnded,
      child: InkWell(
        onTap: () => _newGame(),
        child: AnimatedOpacity(
          opacity: gameEnded ? 1 : 0,
          duration: durationL,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.displayMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildBottomBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: paddingS,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${board.minesFlagged} / ${Board.mines} mines\n"
            "Tap to dig or hold to flag",
          ),
          NeumorphicButton(
            onPressed: () => _newGame(),
            style: NeumorphicStyle(
              depth: 4,
              color: colorScheme.primaryContainer,
              boxShape: const NeumorphicBoxShape.circle(),
            ),
            child: Icon(
              Icons.refresh,
              size: 32,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
