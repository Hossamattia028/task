import 'dart:convert';

class FavoriteCharacter {  
  final int id;  
  final String name;  
  final String image;  

  FavoriteCharacter({  
    required this.id,  
    required this.name,  
    required this.image,  
  });  

  // Convert to a Map for SharedPreferences  
  Map<String, dynamic> toMap() {  
    return {  
      'id': id,  
      'name': name,  
      'image': image,  
    };  
  }  

  // Convert to JSON string  
  String toJson() => json.encode(toMap());  

  // Factory constructor to create from JSON  
  factory FavoriteCharacter.fromJson(String source) {  
    final map = json.decode(source); // Decode JSON string into a Map  
    return FavoriteCharacter(  
      id: map['id'],  
      name: map['name'],  
      image: map['image'],  
    );  
  }   
}