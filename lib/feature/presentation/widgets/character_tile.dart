import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/feature/domain/entities/favorite_character.dart';
import 'package:task_project/feature/presentation/blocs/favorite_bloc.dart';
import 'package:task_project/feature/presentation/screens/character_details_screen.dart';  
import '../../domain/entities/character.dart';  

class CharacterTile extends StatelessWidget {  
  final Character character;  

  const CharacterTile({super.key, required this.character});  

  @override  
  Widget build(BuildContext context) {  
    return ListTile(  
      leading: Image.network(character.image),  
      title: Text(character.name),  
      subtitle: Text('${character.status} - ${character.species}'),  
      trailing: BlocBuilder<FavoriteBloc,FavoriteState>(
        builder: (ctx,state){
          int checkIndex = FavoriteBloc.get(ctx).favorites.indexWhere((item)=> item.id==character.id);
          bool selected = checkIndex!=-1;
          // var item = FavoriteBloc.get(ctx).favorites[checkIndex];
          return IconButton(  
            icon: Icon(selected? Icons.favorite :Icons.favorite_border),  
            onPressed: () {  
              final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);  
              if(selected){
                favoriteBloc.removeFavorite(FavoriteCharacter(  
                  id: character.id,  
                  name: character.name,  
                  image: character.image,  
                ));
              }else{
                favoriteBloc.addFavorite(FavoriteCharacter(  
                  id: character.id,  
                  name: character.name,  
                  image: character.image,  
                )); 
              }
              favoriteBloc.add(const FetchFav()); 
            },  
          );
        },
      ), 
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CharacterDetailsScreen(character: character)),
      ),  
    );  
  }  
}