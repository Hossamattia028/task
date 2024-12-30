
import 'package:shared_preferences/shared_preferences.dart';  
import '../../domain/entities/favorite_character.dart';  

class FavoriteRepository {  
  static const String favoriteKey = 'favorite_characters';  

  Future<void> saveFavorite(FavoriteCharacter character) async {  
    final prefs = await SharedPreferences.getInstance();  
    final favorites = prefs.getStringList(favoriteKey) ?? [];  
    favorites.add(character.toJson()); // Store the JSON string representation  
    await prefs.setStringList(favoriteKey, favorites);  
  }  


  Future<List<FavoriteCharacter>> getFavorites() async {  
    final prefs = await SharedPreferences.getInstance();  
    final favorites = prefs.getStringList(favoriteKey) ?? [];  
    return favorites  
        .map((fav) => FavoriteCharacter.fromJson(fav)) // Correctly decode JSON strings back to FavoriteCharacter instances  
        .toList();  
  }  

  Future<void> removeFavorite(FavoriteCharacter character) async {  
    final prefs = await SharedPreferences.getInstance();  
    final favorites = prefs.getStringList(favoriteKey) ?? [];  
    favorites.removeWhere((fav) =>  
        FavoriteCharacter.fromJson(fav).id == character.id);  
    await prefs.setStringList(favoriteKey, favorites);  
  }  
}