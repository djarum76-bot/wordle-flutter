part of 'game_bloc.dart';

enum GameStatus { initial, loading, play, finish }

class GameState extends Equatable{
  const GameState({
    this.status = GameStatus.initial,
    this.answers = const <String>["", "", "", "", "", ""],
    this.contents = const <String>[],
    this.answer = "SLICE",
    this.position = 0,
    this.alertTitle = "",
    this.alertMessage = "",
  });

  final GameStatus status;
  final List<String> contents;
  final List<String> answers;
  final String answer;
  final int position;
  final String alertTitle;
  final String alertMessage;

  @override
  List<Object> get props => [
    status,
    contents,
    answers,
    answer,
    position,
    alertTitle,
    alertMessage
  ];

  GameState copyWith({
    GameStatus? status,
    List<String>? contents,
    List<String>? answers,
    String? answer,
    int? position,
    String? alertTitle,
    String? alertMessage,
  }) {
    return GameState(
      status: status ?? this.status,
      contents: contents ?? this.contents,
      answers: answers ?? this.answers,
      answer: answer ?? this.answer,
      position: position ?? this.position,
      alertTitle: alertTitle ?? this.alertTitle,
      alertMessage: alertMessage ?? this.alertMessage
    );
  }
}