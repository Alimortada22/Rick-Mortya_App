import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_mortya_app/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_mortya_app/constant/mycolors.dart';
import 'package:rick_and_mortya_app/data/model/chracter_model.dart';
import 'package:rick_and_mortya_app/presentation/widgets/character.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<CharacterModel> allCharacters;
  List<CharacterModel> searchedCharacters = [];
  bool isSearching = false;
  TextEditingController searchedCharacterController = TextEditingController();
  Widget buildSearchedCharacter() {
    return TextField(
      controller: searchedCharacterController,
      cursorColor: const Color.fromARGB(255, 31, 165, 1),
      decoration: const InputDecoration(
          hintText: " search for character...",
          hintStyle:
              TextStyle(color: Color.fromARGB(255, 31, 165, 1), fontSize: 18),
          border: InputBorder.none),
      style:
          const TextStyle(fontSize: 18, color: Color.fromARGB(255, 31, 165, 1)),
      onChanged: (searchedCharacter) =>
          searchedCharacterFromAllCharacters(searchedCharacter),
    );
  }

  void searchedCharacterFromAllCharacters(String searchedCharacter) {
    searchedCharacters = allCharacters.where((character) {
      return character.charName.toLowerCase().startsWith(searchedCharacter);
    }).toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              if (searchedCharacterController.text.isEmpty) {
                Navigator.pop(context);
              }
              _clearSearch();
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.deepPurple,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: startSearching,
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 31, 165, 1),
            ))
      ];
    }
  }

  void startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    _clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchedCharacterController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocBuilder() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).allCharacters;
          return buildLoadedCharacters();
        }
        return const Center(
            child: CircularProgressIndicator(
          color: Mycolors.primary,
        ));
      },
    );
  }

  Widget buildLoadedCharacters() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: searchedCharacterController.text.isNotEmpty
            ? searchedCharacters.length
            : allCharacters.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (ctx, index) {
          return searchedCharacterController.text.isNotEmpty
              ? Character(character: searchedCharacters[index])
              : Character(character: allCharacters[index]);
        });
  }

  Widget appBarBuilder() {
    return const Text(
      "Characters",
      style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 31, 165, 1)),
      textAlign: TextAlign.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              if (isSearching == false)
                SliverAppBar(
                  stretch: true,
                  floating: true,
                  expandedHeight: 150,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      "lib/assets/images/Rick And Morty Wallpaper.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
        body: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: isSearching ? buildSearchedCharacter() : appBarBuilder(),
            backgroundColor: Mycolors.background,
            elevation: 0,
            actions: buildAppBarActions(),
          ),
          backgroundColor: Mycolors.background,
          body: buildBlocBuilder(),
        ));
  }
}
