import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/business_logic_layer/cubit/characters_cubit.dart';
import 'package:rickandmorty/constants/myColors.dart';
import 'package:rickandmorty/data_layer/models/character_model.dart';
import 'package:rickandmorty/data_layer/models/quotes_model.dart';
import 'package:rickandmorty/data_layer/web_services/quote_api.dart';
import 'package:rickandmorty/presentation_layer/widgets/character_item.dart';
import 'package:rickandmorty/presentation_layer/widgets/search_field.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedCharacters;
  final _serahcTextController = TextEditingController();
  bool _isSeraching = false;
  @override
  void initState() {
    super.initState();
    // ana kda bandah 3la el bloc
    BlocProvider.of<CharactersCubit>(context).retriveAllCharacters();
    QuoteApi().fetchSpecificCharacterQuote();
  }

  void addSearchedForItemsRoSearchedList(String thesearchedCharacter) {
    searchedCharacters = allCharacters
        .where((searchedCharacter) => searchedCharacter.fullName
            .toLowerCase()
            .startsWith(thesearchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSeraching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(Icons.search),
          color: MyColors.myGrey,
        )
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSeraching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSeraching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _serahcTextController.clear();
    });
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _serahcTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a Character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myWhite, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (serachedCharacter) {
        addSearchedForItemsRoSearchedList(serachedCharacter.toLowerCase());
      },
    );
  }

  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharacterLoaded) {
        allCharacters = (state).characters;
        return builLoadedListWidget();
      } else {
        //show loading indecator if the program didnt start yet
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget builLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _serahcTextController.text.isEmpty
            ? allCharacters.length
            : searchedCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            character: _serahcTextController.text.isEmpty
                ? allCharacters[index]
                : searchedCharacters[index],
          );
        });
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.myWhite),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSeraching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlockWidget(),
    );
  }
}
