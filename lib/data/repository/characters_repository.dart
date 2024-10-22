import 'package:rm_bloc/data/models/characters.dart';
import 'package:rm_bloc/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<dynamic>> getAllTheCharacters() async {
    final characters = await charactersWebServices.getAllTheCharacters();

    return characters;
  }
}
