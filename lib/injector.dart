import 'package:get_it/get_it.dart';
import 'package:wordle/features/game/data/repositories/game_repository_impl.dart';
import 'package:wordle/features/game/domain/repositories/game_repository.dart';
import 'package:wordle/features/game/presentation/blocs/game/game_bloc.dart';

final injector = GetIt.instance;

void injectorSetup() {
  injector.registerLazySingleton<GameRepository>(() => GameRepositoryImpl(),);

  injector.registerSingleton<GameBloc>(GameBloc(gameRepository: injector<GameRepository>()));
}