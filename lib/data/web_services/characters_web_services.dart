import 'package:dio/dio.dart';
import 'package:rm_bloc/constants/strings.dart';
import 'package:rm_bloc/data/models/characters.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllTheCharacters() async {
    try {
      Response response = await dio.get('character');
      // Check if response data is a List
      if (response.data['results'] is List) {
        // Assuming Character.fromJson is implemented correctly
        List<dynamic> characters = (response.data['results'] as List)
            .map((characterData) => Character.fromJson(characterData))
            .toList();
        return characters;
      } else {
       
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      // Better error handling can be implemented here
      print('Error fetching charactersSSS: ${e.toString()}');
      return []; // Return an empty list in case of an error
    }
  }
}
