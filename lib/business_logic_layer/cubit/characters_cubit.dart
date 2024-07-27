import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/data_layer/models/character_model.dart';
import 'package:rickandmorty/data_layer/repository/characters.repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> myCharacters = [];

  CharactersCubit(this.charactersRepository) : super(CharacterInitial());

  // this is the function i am using to recive the characters from Repository
  List<Character> retriveAllCharacters() {
    // characters that i made in Repository class
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharacterLoaded(characters));
      myCharacters = characters;
    });

    return myCharacters;
  }
}
