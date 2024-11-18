import 'package:rick_and_mortya_app/data/model/chracter_model.dart';
import 'package:rick_and_mortya_app/data/web_services/character_web_servies.dart';

class CharacterRepository {
  final CharacterWebServies characterWebServies;
  const CharacterRepository({required this.characterWebServies});
  Future<List<CharacterModel>> getAllCharacters() async {
    final allCharacters = await characterWebServies.getAllCharacters();
    return allCharacters
        .map((character) => CharacterModel.fromJson(character))
        .toList();
  }
}
