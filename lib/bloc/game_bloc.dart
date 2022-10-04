import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

///STATE
abstract class GameState extends Equatable {
  const GameState(this.score);

  final int score;

  @override
  List<Object> get props => [score];
}

class GameInitial extends GameState {
  const GameInitial(super.score);

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

/// BLOC
class GameBloc extends Bloc<GameEvent, GameState> {
  static int _score = 0;

  GameBloc() : super(GameInitial(_score)) {
    on<GameAddPoints>(_onGameAddPoints);
  }

  void _onGameAddPoints(GameAddPoints event, Emitter<GameState> emit) {
    _score += event.points;
    emit(GameInitial(_score));
  }
}
