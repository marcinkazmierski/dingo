import 'package:dingo/bloc/game_bloc.dart';
import 'package:dingo/game/dingo_game.dart';
import 'package:dingo/widgets/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Hud extends StatelessWidget {
  const Hud({Key? key, required this.gameRef}) : super(key: key);
  static const id = 'Hud';

  final DingoGame gameRef;

  @override
  Widget build(BuildContext context) {
    final score = context.select((GameBloc bloc) => bloc.state.score);
    final lives = context.select((GameBloc bloc) => bloc.state.lives);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) {
                if (index + 1 <= lives) {
                  return const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  );
                } else {
                  return const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  );
                }
              },
            ),
          ),
          Text(
            "Score: $score",
            style: const TextStyle(fontSize: 28, color: Colors.white),
          ),
          TextButton(
            onPressed: () {
              gameRef.stopGame();
              gameRef.overlays.remove(Hud.id);
              gameRef.overlays.add(MainMenu.id);
            },
            child: const Icon(Icons.exit_to_app, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
