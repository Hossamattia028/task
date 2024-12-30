import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';  
import '../../domain/entities/favorite_character.dart';  
import '../../data/repositories/favorite_repository.dart';  

class FavoriteState {  
  final List<FavoriteCharacter> favorites;  
  final bool loading;  
  final String? error;  

  FavoriteState({this.favorites = const [], this.loading = false, this.error});  
}  

class FetchFav {
  const FetchFav();
}

class FavoriteBloc extends Bloc<FetchFav,FavoriteState> {  
  final FavoriteRepository favoriteRepository;  

  FavoriteBloc(this.favoriteRepository) : super(FavoriteState()) { 
    on<FetchFav>((event, emit) async{
      await fetchFavorites(emit);
    });
  }  
  List<FavoriteCharacter> favorites = [];
  static FavoriteBloc get(BuildContext context) => BlocProvider.of(context);

  Future<void> fetchFavorites(emit) async {  
    emit(FavoriteState(loading: true));  
    try {  
      favorites = await favoriteRepository.getFavorites();  
      debugPrint('fav: ${favorites.length}');
      emit(FavoriteState(favorites: favorites));  
    } catch (e) {  
      emit(FavoriteState(error: e.toString()));  
    }  
  }  

  Future<void> addFavorite(FavoriteCharacter character) async {  
    await favoriteRepository.saveFavorite(character);  
    // await fetchFavorites(); // Refresh the favorites list  
  }  

  Future<void> removeFavorite(FavoriteCharacter character) async {  
    await favoriteRepository.removeFavorite(character);  
    // await fetchFavorites(); // Refresh the favorites list  
  }  
}