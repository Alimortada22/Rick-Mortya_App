import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_mortya_app/data/model/chracter_model.dart';
import 'package:rick_and_mortya_app/data/repository/character_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharacterRepository characterRepository;
   List<CharacterModel> characters=[];
  CharactersCubit({required this.characterRepository})
      : super(CharactersInitial());
  List<CharacterModel> getAllCharacters() {
    
    characterRepository.getAllCharacters().then((character) {
      emit(CharactersLoaded(allCharacters: character));
       characters = [...character];
    });
    return characters;
  }
}
