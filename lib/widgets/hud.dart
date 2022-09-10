import 'package:dingo/game/dingo_game.dart';
import 'package:dingo/widgets/main_menu.dart';
import 'package:flutter/material.dart';

class Hud extends StatelessWidget {
  static const id = 'Hud';

  final DingoGame gameRef;

  const Hud({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                if (index < 3) {
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
          const Text(
            'Score: 666',
            style: TextStyle(fontSize: 20, color: Colors.white),
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
