import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/business_logic_layer/cubit/characters_cubit.dart';
import 'package:rickandmorty/constants/Strings.dart';
import 'package:rickandmorty/data_layer/repository/characters.repository.dart';
import 'package:rickandmorty/data_layer/web_services/character_api.dart';
import 'package:rickandmorty/presentation_layer/screens/characters_details.dart';
import 'package:rickandmorty/presentation_layer/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(charactersApi: CharactersApi());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // main page
      case allCharactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        return MaterialPageRoute(builder: (_) => CharacterDetailsScreen());
    }
  }
}
