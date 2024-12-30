import 'package:flutter/material.dart';  
import 'package:flutter_bloc/flutter_bloc.dart';  
import '../blocs/favorite_bloc.dart';  
import '../widgets/loading_indicator.dart';  
import '../widgets/favorite_character_tile.dart';  

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: const Text('Favorites')),  
      body: BlocBuilder<FavoriteBloc, FavoriteState>(  
        builder: (context, state) {  
          if (state.loading) return const LoadingIndicator();  
          debugPrint('error: ${state.error}');
          if (state.error != null) return Center(child: Text(state.error!));  

          return ListView.builder(  
            itemCount: state.favorites.length,  
            itemBuilder: (context, index) {  
              final favorite = state.favorites[index];  
              return FavoriteCharacterTile(favorite: favorite);  
            },  
          );  
        },  
      ),  
    );  
  }  
}