import 'package:flutter/material.dart';  
import '../../domain/entities/character.dart';  

class CharacterDetailsScreen extends StatelessWidget {  
  final Character character;  

  const CharacterDetailsScreen({super.key, required this.character});  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: Text(character.name)),  
      body: Column(  
        children: [  
          Image.network(character.image),  
          Text('Status: ${character.status}'),  
          Text('Species: ${character.species}'),  
          Text('Gender: ${character.gender}'),  
        ],  
      ),  
    );  
  }  
}