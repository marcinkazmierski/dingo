import 'package:bloc/bloc.dart';
import 'package:dingo/constants.dart';
import 'package:equatable/equatable.dart';

///STATE
abstract class GameState extends Equatable {
  const GameState({required this.score, required this.lives});

  final int lives;
  final int score;

  @override
  List<Object> get props => [score, lives];
}

class GameInitial extends GameState {
  const GameInitial({required super.score, required super.lives});

  @override
  String toString() => 'GameInitial';
}

class GameOver extends GameState {
  const GameOver({required score}) : super(lives: 0, score: score);

  @override
  String toString() => 'GameOver';
}

///EVENT
abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class GameAddPoints extends GameEvent {
  const GameAddPoints({required this.points});

  final int points;
}

class GameRemoveOneLife extends GameEvent {
  const GameRemoveOneLife();
}

class GameRestart extends GameEvent {
  const GameRestart();
}

/// BLOC
class GameBloc extends Bloc<GameEvent, GameState> {
  static int _score = 0;
  static int _lives = kLivesOnStart;

  GameBloc() : super(GameInitial(score: _score, lives: _lives)) {
    on<GameAddPoints>(_onGameAddPoints);
    on<GameRemoveOneLife>(_onGameRemoveOneLife);
    on<GameRestart>(_onGameRestart);
  }

  void _onGameAddPoints(GameAddPoints event, Emitter<GameState> emit) {
    _score += event.points;
    emit(GameInitial(score: _score, lives: _lives));
  }

  void _onGameRemoveOneLife(GameRemoveOneLife event, Emitter<GameState> emit) {
    _lives -= 1;
    if (_lives > 0) {
      emit(GameInitial(score: _score, lives: _lives));
    } else {
      emit(GameOver(score: _score));
    }
  }

  void _onGameRestart(GameRestart event, Emitter<GameState> emit) {
    _lives = kLivesOnStart;
    _score = 0;
    emit(GameInitial(score: _score, lives: _lives));
  }

  @override
  void onTransition(Transition<GameEvent, GameState> transition) {
    super.onTransition(transition);
    print(transition.toString());
  }

  @override
  void onEvent(GameEvent event) {
    super.onEvent(event);
    print(event.toString());
  }
}
