import 'dart:typed_data';
import 'dart:ui';
import 'package:dingo/bloc/game_bloc.dart';
import 'package:dingo/widgets/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../game/dingo_game.dart';

class Summary extends StatelessWidget {
  static const id = 'Summary';

  final DingoGame gameRef;

  final ScreenshotController _screenshotController = ScreenshotController();

  Summary({Key? key, required this.gameRef}) : super(key: key);

  void _takeScreenshot() async {
    final Uint8List? imageFile = await _screenshotController.capture();

    await Share.shareXFiles([
      XFile.fromData(imageFile!, name: 'dingo_game.png', mimeType: 'image/png')
    ], text: "Shared from Dingo Game");
  }

  @override
  Widget build(BuildContext context) {
    final score = context.select((GameBloc bloc) => bloc.state.score);
    Sentry.captureMessage("New user score", params: [
      {"score": score}
    ]);

    return Screenshot(
      controller: _screenshotController,
      child: Center(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
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
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            gameRef.overlays.remove(Summary.id);
                            gameRef.overlays.add(MainMenu.id);
                          },
                          child: Column(
                            children: const [
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                                size: 42,
                              ),
                              Text(
                                "Back to menu",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: TextButton(
                            onPressed: _takeScreenshot,
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 42,
                                ),
                                Text(
                                  "Share your score",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
