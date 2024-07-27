// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rickandmorty/data_layer/models/character_model.dart';
import 'package:rickandmorty/data_layer/web_services/character_api.dart';

class CharactersRepository {
  // iam making object from CharactersApi to be able to call its function getAllCharacters()
  CharactersApi? charactersApi;
  CharactersRepository({
    this.charactersApi,
  });

  Future<List<Character>> getAllCharacters() async {
    final characters = await CharactersApi().fetchAllCharacters();
    // loop around all elements in the response (object by object of the character) and map them key to value like the model i made
    // and then convert it to list
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
