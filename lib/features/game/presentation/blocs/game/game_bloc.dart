import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/features/game/domain/repositories/game_repository.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;
  GameBloc({required this.gameRepository}) : super(const GameState()) {
    on<GameInitialled>(_onGameInitialled);
    on<GameSubmitted>(_onGameSubmitted);
    on<GameRestarted>(_onGameRestarted);
  }

  Future<void> _onGameInitialled(GameInitialled event, Emitter<GameState> emit)async{
    emit(state.copyWith(status: GameStatus.loading));
    List<String> contents = List<String>.from(state.contents);
    String answer = state.answer;

    if (state.contents.isEmpty) {
      contents = await gameRepository.loadAsset();
      answer = gameRepository.generateNewWord(contents);
    }

    emit(state.copyWith(
      status: GameStatus.initial,
      contents: contents,
      answer: answer
    ));
  }

  void _onGameSubmitted(GameSubmitted event, Emitter<GameState> emit){
    GameStatus status = GameStatus.play;
    String alertTitle = state.alertTitle;
    String alertMessage = state.alertMessage;
    int position = state.position;
    List<String> answers = List<String>.from(state.answers);

    if(state.position < 6) {
      answers[state.position] = event.answer;
      position += 1;

      if(state.answer == event.answer){
        status = GameStatus.finish;
        alertTitle = "You Win";
        alertMessage = "You guessed the word in $position attempt";

        emit(state.copyWith(
          status: status,
          alertTitle: alertTitle,
          alertMessage: alertMessage,
          position: position,
          answers: answers
        ));
        return;
      }
    }

    if(position > 5){
      status = GameStatus.finish;
      alertTitle = "You Lose";
      alertMessage = "You can't guessed the word\nThe answer is ${state.answer}";
    }

    emit(state.copyWith(
      status: status,
      alertTitle: alertTitle,
      alertMessage: alertMessage,
      position: position,
      answers: answers
    ));
  }

  void _onGameRestarted(GameRestarted event, Emitter<GameState> emit){
    GameStatus status = GameStatus.initial;
    List<String> answers = <String>["", "", "", "", "", ""];
    String answer = gameRepository.generateNewWord(state.contents);
    int position = 0;
    String alertTitle = "";
    String alertMessage = "";

    emit(state.copyWith(
      status: status,
      answers: answers,
      answer: answer,
      position: position,
      alertTitle: alertTitle,
      alertMessage: alertMessage
    ));
  }
}
