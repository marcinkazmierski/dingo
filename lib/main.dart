import 'package:dingo/bloc/game_bloc.dart';
import 'package:dingo/game/dingo_game.dart';
import 'package:dingo/widgets/hud.dart';
import 'package:dingo/widgets/summary.dart';
import 'package:dingo/widgets/main_menu.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MyGame());
}

class MyGame extends StatelessWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = DingoGame();
    return MaterialApp(
      title: 'Dingo game',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: BlocProvider(
          create: (_) => GameBloc(),
          child: GameWidget(
            loadingBuilder: (_) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            },
            overlayBuilderMap: {
              MainMenu.id: (ctx, DingoGame g) => MainMenu(gameRef: g),
              Hud.id: (ctx, DingoGame g) => Hud(gameRef: g),
              Summary.id: (ctx, DingoGame g) => Summary(gameRef: g),
            },
            initialActiveOverlays: const [MainMenu.id],
            game: game,
          ),
        ),
      ),
    );
  }
}
