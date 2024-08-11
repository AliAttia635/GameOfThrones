import 'package:rickandmorty/data_layer/models/character_model.dart';
import 'package:rickandmorty/data_layer/models/quotes_model.dart';
import 'package:rickandmorty/data_layer/web_services/character_api.dart';
import 'package:rickandmorty/data_layer/web_services/quote_api.dart';

class CharactersRepository {
  // iam making object from CharactersApi to be able to call its function getAllCharacters()
  CharactersApi? charactersApi;
  QuoteApi? quoteApi;
  CharactersRepository({
    this.charactersApi,
    this.quoteApi,
  });

  Future<List<Character>> getAllCharacters() async {
    final characters = await CharactersApi().fetchAllCharacters();
    // loop around all elements in the response (object by object of the character) and map them key to value like the model i made
    // and then convert it to list
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<Quote> getCharacterQuote(String charName) async {
    final quotes = await QuoteApi().fetchSpecificCharacterQuote(charName);

    // Access the first (and only) element in the list and parse it into a Quote object
    final Map<String, dynamic> quoteData = quotes[0];
    return Quote.fromJson(quoteData);
  }
}
