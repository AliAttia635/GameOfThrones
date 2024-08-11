import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/data_layer/models/character_model.dart';
import 'package:rickandmorty/data_layer/models/quotes_model.dart';
import 'package:rickandmorty/data_layer/repository/characters.repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> myCharacters = [];
  Quote myQuotes = Quote(name: 'Default Name', quotes: []);

  CharactersCubit(this.charactersRepository) : super(CharacterInitial());

  // this is the function i am using to recieve the characters from Repository
  List<Character> retriveAllCharacters() {
    // characters that i made in Repository class
    charactersRepository.getAllCharacters().then(
      (characters) {
        emit(CharacterLoaded(characters));
        myCharacters = characters;
      },
    );

    return myCharacters;
  }

  // this is the function i am using to recieve the character quotes from Repository
  Quote retriveCharacterQuote(String charName) {
    // characters that i made in Repository class
    charactersRepository.getCharacterQuote(charName).then((quotes) {
      emit(QuoteLoaded(quotes));
      myQuotes = quotes;
    });

    return myQuotes;
  }

//   Future<List<Character>> retriveAllCharacters() async {
//   try {
//     final characters = await charactersRepository.getAllCharacters();
//     emit(CharacterLoaded(characters));
//     myCharacters = characters;
//     return myCharacters;
//   } catch (e) {
//     // Handle error and emit an error state if needed
//     // emit(CharacterError());
//     return [];
//   }
// }
}
