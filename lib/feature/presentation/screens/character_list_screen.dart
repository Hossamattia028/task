import 'package:flutter/material.dart';  
import 'package:flutter_bloc/flutter_bloc.dart';  
import 'package:task_project/feature/presentation/screens/favorite_screen.dart';  
import '../blocs/character_bloc.dart';  
import '../widgets/loading_indicator.dart';  
import '../widgets/character_tile.dart';  

class CharacterListScreen extends StatefulWidget {  
  const CharacterListScreen({super.key});  

  @override  
  State<CharacterListScreen> createState() => _CharacterListScreenState();  
}  

class _CharacterListScreenState extends State<CharacterListScreen> {  
  int _currentPage = 1; // Track current page  
  bool _isLoadingMore = false; // Track if loading more pages  
  final ScrollController _scrollController = ScrollController();  

  @override  
  void initState() {  
    super.initState();  
  
    BlocProvider.of<CharacterBloc>(context).add(FetchCharacters(_currentPage));  

    _scrollController.addListener(() {  
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoadingMore) {  
        _loadMoreCharacters();  
      }  
    });  
  }  

  void _loadMoreCharacters() {  
    setState(() {  
      _isLoadingMore = true; // Set loading state to true  
    });  
    
    _currentPage++; // Increment the current page  
    BlocProvider.of<CharacterBloc>(context).add(FetchCharacters(_currentPage));  
  }  

  @override  
  void dispose() {  
    _scrollController.dispose(); // Dispose of the controller  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Characters'),  
        actions: [  
          IconButton(  
            icon: const Icon(Icons.favorite),  
            onPressed: () => Navigator.push(  
              context,  
              MaterialPageRoute(builder: (context) => const FavoriteScreen()),  
            ),  
          ),  
        ]  
      ),  
      
      body: BlocBuilder<CharacterBloc, CharacterState>(  
        builder: (context, state) {  
          if (state.loading && _currentPage == 1) return const LoadingIndicator();  
          if (state.error != null) return Center(child: Text(state.error!));  

          return ListView.builder(  
            controller: _scrollController,  
            itemCount: state.characters.length + (_isLoadingMore ? 1 : 0), // Add 1 for loading indicator if loading more  
            itemBuilder: (context, index) {  
              if (index >= state.characters.length) {  
                return const Center(child: CircularProgressIndicator()); // Show loading indicator at the end  
              }  

              final character = state.characters[index];  
              return CharacterTile(character: character);  
            },  
          );  
        },  
      ),  
    );  
  }  
}