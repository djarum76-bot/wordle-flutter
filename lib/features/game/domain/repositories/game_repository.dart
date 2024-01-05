abstract class GameRepository{
  Future<List<String>> loadAsset();
  String generateNewWord(List<String> contents);
}