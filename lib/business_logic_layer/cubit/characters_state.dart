part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharacterInitial extends CharactersState {}

// class CharacterError extends CharactersState {

// }

class CharacterLoaded extends CharactersState {
  final List<Character> characters;

  CharacterLoaded(this.characters);
}
