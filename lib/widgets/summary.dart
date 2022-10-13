import 'dart:ui';
import 'package:dingo/bloc/game_bloc.dart';
import 'package:dingo/widgets/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../game/dingo_game.dart';

class Summary extends StatelessWidget {
  static const id = 'Summary';

  final DingoGame gameRef;

  const Summary({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final score = context.select((GameBloc bloc) => bloc.state.score);

    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  const Text(
                    'Dingo Game',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Game Over',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "Your score: $score",
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      gameRef.overlays.remove(Summary.id);
                      gameRef.overlays.add(MainMenu.id);
                    },
                    child: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 42,
                    ),
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
