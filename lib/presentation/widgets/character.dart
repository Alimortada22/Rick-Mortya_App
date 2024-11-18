import 'package:flutter/material.dart';
import 'package:rick_and_mortya_app/constant/constant_strings.dart';
import 'package:rick_and_mortya_app/constant/mycolors.dart';
import 'package:rick_and_mortya_app/data/model/chracter_model.dart';

class Character extends StatelessWidget {
  const Character({super.key, required this.character});
  final CharacterModel character;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, characterDetailsScreen,
          arguments: character),
      child: Hero(
        tag: character.charId,
        child: Container(
          height: double.infinity,
          margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Mycolors.secondary),
          child: GridTile(
            footer: Container(
              width: double.infinity,
                alignment: Alignment.bottomCenter,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Mycolors.secondary.withOpacity(0.5),
                child: Text(
                 ' ${character.charName}',
                  style: const  TextStyle(
                      height: 1,fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                )),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: character.charImage.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: "lib/assets/images/loading.gif",
                      image: character.charImage,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "lib/assets/images/Rick And Morty Wallpaper.jpg"),
            ),
          ),
        ),
      ),
    );
  }
}
