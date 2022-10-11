import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

///STATE
abstract class GameState extends Equatable {
  const GameState({required this.score, required this.lives});

  final int lives;
  final int score;

  @override
  List<Object> get props => [score];
}

class GameInitial extends GameState {
  const GameInitial({required super.score, required super.lives});

  @override
  String toString() => 'GameInitial';
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

/// BLOC
class GameBloc extends Bloc<GameEvent, GameState> {
  static int _score = 0;
  static int _lives = 5;

  GameBloc() : super(GameInitial(score: _score, lives: _lives)) {
    on<GameAddPoints>(_onGameAddPoints);
    on<GameRemoveOneLife>(_onGameRemoveOneLife);
  }

  void _onGameAddPoints(GameAddPoints event, Emitter<GameState> emit) {
    _score += event.points;
    emit(GameInitial(score: _score, lives: _lives));
  }

  void _onGameRemoveOneLife(GameRemoveOneLife event, Emitter<GameState> emit) {
    _lives -= 1;
    emit(GameInitial(score: _score, lives: _lives));
  }
}
