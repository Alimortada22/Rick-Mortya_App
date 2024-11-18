import 'package:flutter/material.dart';
import 'package:rick_and_mortya_app/constant/mycolors.dart';
import 'package:rick_and_mortya_app/data/model/chracter_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});
  final CharacterModel character;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      stretch: true,
      pinned: true,
      backgroundColor: Mycolors.background,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.charImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildCharacterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 21, 205, 4),
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 21, 205, 4),
            ),
          ),
        ]));
  }

  Widget divider(double eninded) {
    return Divider(
      color: Colors.deepPurple,
      height: 30,
      thickness: 2,
      endIndent: eninded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolors.background,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(

              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.only(
                  top: 14, right: 15, left: 14, bottom: 0),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCharacterInfo("Name : ", character.charName),
                  divider(250),
                  buildCharacterInfo("Status : ", character.charStatus),
                  divider(240),
                  buildCharacterInfo("Species : ", character.charSpecies),
                  divider(230),
                  buildCharacterInfo("Gender : ", character.charGender),
                  divider(240),
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
