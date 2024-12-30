import 'package:task_project/feature/domain/repositories/character_repository.dart';

import '../../domain/entities/character.dart';  
import '../data_sources/character_remote_data_source.dart';  

class CharacterModelRepository implements CharacterRepository{  
  final CharacterRemoteDataSource characterRemoteDataSource;

  CharacterModelRepository({required this.characterRemoteDataSource});  

  @override
  Future<List<Character>> getCharacters(int page) async {  
    final characterModels = await characterRemoteDataSource.fetchCharacters(page);  
    return characterModels.map((model) => Character(  
      id: model.id,  
      name: model.name,  
      status: model.status,  
      species: model.species,  
      gender: model.gender,  
      image: model.image,  
    )).toList();  
  }  
}