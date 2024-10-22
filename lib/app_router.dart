import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rm_bloc/busness_logic/cubit/characters_cubit.dart';
import 'package:rm_bloc/constants/strings.dart';
import 'package:rm_bloc/data/models/characters.dart';
import 'package:rm_bloc/data/repository/characters_repository.dart';
import 'package:rm_bloc/data/web_services/characters_web_services.dart';
import 'package:rm_bloc/presentation/screens/character_details_screen.dart';
import 'package:rm_bloc/presentation/screens/characters_screen.dart';


class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
      final character =settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(character:character));
    }
    return null;
  }
}
