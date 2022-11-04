import 'package:dingo/bloc/game_bloc.dart';
import 'package:dingo/constants.dart';
import 'package:dingo/game/dingo_game.dart';
import 'package:dingo/widgets/main_menu.dart';
import 'package:dingo/widgets/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Hud extends StatelessWidget {
  const Hud({Key? key, required this.gameRef}) : super(key: key);
  static const id = 'Hud';

  final DingoGame gameRef;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameOver) {
          gameRef.stopGame();
          gameRef.overlays.remove(Hud.id);
          gameRef.overlays.add(Summary.id);
        }
      },
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: List.generate(
                    kLivesOnStart,
                    (index) {
                      if (index + 1 <= state.lives) {
                        return const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        );
                      } else {
                        return Icon(
                          Icons.favorite,
                          color: Colors.red.withOpacity(0.25),
                        );
                      }
                    },
                  ),
                ),
                Text(
                  "Your score: ${state.score}",
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
        },
      ),
    );
  }
}
