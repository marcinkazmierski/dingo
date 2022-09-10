import 'package:dingo/game/dingo_game.dart';
import 'package:dingo/widgets/hud.dart';
import 'package:dingo/widgets/main_menu.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        body: GameWidget(
          loadingBuilder: (_) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
          overlayBuilderMap: {
            MainMenu.id: (ctx, DingoGame g) => const MainMenu(),
            Hud.id: (ctx, DingoGame g) => const Hud(),
          },
          initialActiveOverlays: const [Hud.id],
          game: game,
        ),
      ),
    );
  }
}
