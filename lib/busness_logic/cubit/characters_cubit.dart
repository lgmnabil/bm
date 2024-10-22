import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rm_bloc/data/models/characters.dart';
import 'package:rm_bloc/data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;

   List<dynamic> characters =[];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  Future<List<dynamic>> getAllTheCharacters() async {
       try {
      characters = await charactersRepository.getAllTheCharacters();
      emit(CharactersLoaded(characters));
      return characters;
    } catch (e) {
      print(e.toString());
      return []; 
    }
 

  }

  }

