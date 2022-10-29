import 'dart:ui';
import 'package:dingo/bloc/game_bloc.dart';
import 'package:dingo/widgets/hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../game/dingo_game.dart';

class MainMenu extends StatelessWidget {
  static const id = 'MainMenu';

  final DingoGame gameRef;

  const MainMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: const Text(
                      'Tap to jump!',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          gameRef.buildContext!
                              .read<GameBloc>()
                              .add(const GameRestart());
                          gameRef.startGame();
                          gameRef.overlays.remove(MainMenu.id);
                          gameRef.overlays.add(Hud.id);
                          //todo: bloc: in block use gameRef, reset score and lives
                        },
                        child: const Text(
                          'Play',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: const Text(
                            'Exit',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
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
