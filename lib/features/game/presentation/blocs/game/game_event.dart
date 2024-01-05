part of 'game_bloc.dart';

abstract class GameEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class GameInitialled extends GameEvent{}

class GameSubmitted extends GameEvent{
  final String answer;

  GameSubmitted(this.answer);
}

class GameRestarted extends GameEvent{}