import 'dart:convert';  
import 'package:http/http.dart' as http;  
import '../models/character_model.dart';  

class CharacterRemoteDataSource {  
  final String baseUrl = 'https://rickandmortyapi.com/api/character';  

  Future<List<CharacterModel>> fetchCharacters(int page) async {  
    final response = await http.get(Uri.parse('$baseUrl?page=$page'));  

    if (response.statusCode == 200) {  
      final data = json.decode(response.body);  
      return (data['results'] as List)  
          .map((character) => CharacterModel.fromJson(character))  
          .toList();  
    } else {  
      throw Exception('Failed to load characters');  
    }  
  }  
}