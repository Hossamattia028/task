import 'package:flutter_bloc/flutter_bloc.dart';  
import '../../domain/usecases/get_characters.dart';  
import '../../domain/entities/character.dart';  

class CharacterState {  
  final List<Character> characters;  
  final bool loading;  
  final String? error;  

  CharacterState({this.characters = const [], this.loading = false, this.error});  
}  

class CharacterEvent {}  

class FetchCharacters extends CharacterEvent {  
  final int page;  

  FetchCharacters(this.page);  
} 

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {  
 

  final GetCharacters getCharacters;  

  List<Character> characters = [];

  CharacterBloc(this.getCharacters) : super(CharacterState()) {  
    on<FetchCharacters>((event, emit) async {  
      emit(CharacterState(loading: true)); // Start loading  
      try {  
        final list = await getCharacters(event.page);  
        characters.addAll(list);
        emit(CharacterState(characters: [...state.characters, ...characters])); 
      } catch (e) {  
        emit(CharacterState(error: e.toString())); // Handle error  
      }  
    });  
  }  

}