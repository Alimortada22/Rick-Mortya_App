import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_mortya_app/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_mortya_app/constant/constant_strings.dart';
import 'package:rick_and_mortya_app/data/model/chracter_model.dart';
import 'package:rick_and_mortya_app/data/repository/character_repository.dart';
import 'package:rick_and_mortya_app/data/web_services/character_web_servies.dart';
import 'package:rick_and_mortya_app/presentation/pages/character_details.dart';
import 'package:rick_and_mortya_app/presentation/pages/home_page.dart';

class AppRoutes {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;
  AppRoutes(){
    characterRepository = CharacterRepository(characterWebServies: CharacterWebServies());
    charactersCubit= CharactersCubit(characterRepository: characterRepository);
  }
  Route? generatedRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case charactersScreen:
        return MaterialPageRoute(builder: (_) =>  BlocProvider(
          create: (context) => CharactersCubit(characterRepository: characterRepository),
          child: const HomePage(),
        ));
      case characterDetailsScreen:
      final character= routeSettings.arguments as CharacterModel;
        return MaterialPageRoute(
            builder: (_) =>  CharacterDetailsScreen(character: character,));

      default:
        return MaterialPageRoute(builder: (_) =>  const HomePage());
    }
  }
}
