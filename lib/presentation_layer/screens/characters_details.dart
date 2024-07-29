import 'package:flutter/material.dart';
import 'package:rickandmorty/constants/myColors.dart';
import 'package:rickandmorty/data_layer/models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
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

  @override
  Widget build(BuildContext context) {
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
