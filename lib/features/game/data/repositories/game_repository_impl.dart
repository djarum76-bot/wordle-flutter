import 'package:flutter/services.dart';
import 'package:wordle/features/game/domain/repositories/game_repository.dart';

class GameRepositoryImpl extends GameRepository{
  @override
  Future<List<String>> loadAsset()async{
    String content = await rootBundle.loadString("asset/words.txt");
    List<String> contents = content.split("\n");
    return contents;
  }

  @override
  String generateNewWord(List<String> contents) {
    return (contents.toList()..shuffle()).first;
  }
}