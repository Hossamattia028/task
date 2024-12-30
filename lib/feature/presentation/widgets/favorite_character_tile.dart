import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/feature/presentation/blocs/favorite_bloc.dart';  
import '../../domain/entities/favorite_character.dart';  

class FavoriteCharacterTile extends StatelessWidget {  
  final FavoriteCharacter favorite;  

  const FavoriteCharacterTile({super.key, required this.favorite});  

  @override  
  Widget build(BuildContext context) {  
    return ListTile(  
      leading: Image.network(favorite.image),  
      title: Text(favorite.name),  
      trailing: IconButton(  
        icon: const Icon(Icons.delete),  
        onPressed: () {  
          // Handle removal of favorite character  
          final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);  
          favoriteBloc.removeFavorite(favorite);  

          favoriteBloc.add(const FetchFav());
        },  
      ),  
    );  
  }  
}