import '../repositories/character_repository.dart';  
import '../entities/character.dart';  

class ToggleFavorite {  
  final CharacterRepository repository;  

  ToggleFavorite(this.repository);  

  Future<void> call(Character character) async {  
    // Logic to toggle favorite in local storage  
  }  
}