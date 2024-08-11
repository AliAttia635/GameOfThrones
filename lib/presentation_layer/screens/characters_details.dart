import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/business_logic_layer/cubit/characters_cubit.dart';
import 'package:rickandmorty/constants/myColors.dart';
import 'package:rickandmorty/data_layer/models/character_model.dart';
import 'package:rickandmorty/data_layer/models/quotes_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  // final Quote quote;
  // final House house;
  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    // bat7akem fel sora w el name
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          '${character.title}',
          style: TextStyle(color: MyColors.myWhite),
          //textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endindent) {
    return Divider(
      height: 30,
      endIndent: endindent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget buildBlocTextWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is QuoteLoaded) {
          return displayRandomQuoteOrEmptySpace(state);
        } else {
          return showProgressIndicator();
        }
      },
    );
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotesList = state.quotes;
    if (quotesList.quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotesList.quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: MyColors.myWhite, shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              ),
            ]),
            child: AnimatedTextKit(repeatForever: true, animatedTexts: [
              FlickerAnimatedText(quotesList.quotes[randomQuoteIndex]),
            ])),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .retriveCharacterQuote(character.firstName.toLowerCase());
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('First Name : ', '${character.firstName}'),
                      buildDivider(265),
                      characterInfo('Last Name : ', '${character.lastName}'),
                      buildDivider(265),
                      characterInfo('Title : ', '${character.title}'),
                      buildDivider(315),
                      characterInfo('Family: ', '${character.family}'),
                      buildDivider(299),
                      buildBlocTextWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 550,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
