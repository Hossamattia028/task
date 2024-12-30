import 'package:flutter/material.dart';  
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:task_project/feature/data/data_sources/character_remote_data_source.dart';
import 'package:task_project/feature/data/repositories/character_repository.dart';
import 'package:task_project/feature/data/repositories/favorite_repository.dart';
import 'package:task_project/feature/domain/repositories/character_repository.dart';
import 'package:task_project/feature/domain/usecases/get_characters.dart';
import 'package:task_project/feature/presentation/blocs/character_bloc.dart';
import 'package:task_project/feature/presentation/blocs/favorite_bloc.dart';
import 'package:task_project/feature/presentation/screens/character_list_screen.dart';  


void main() async{  
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MyApp());  
}  

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override  
  Widget build(BuildContext context) {  
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) => sl<CharacterBloc>()),
          BlocProvider(create: (ctx) => sl<FavoriteBloc>()..add(const FetchFav())),
        ],
        child: MaterialApp(
         debugShowCheckedModeBanner: false,
          builder: (BuildContext? context, Widget? widget) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return const SizedBox();
            };
            return widget!;
          },
          title: 'Rick and Morty',
          home: const CharacterListScreen(),
        ),
      );  
  }  
}




final sl = GetIt.instance;

Future<void> init() async {
  ///  initial
  sl.registerFactory(() => CharacterBloc(
      sl(),
    ));

  sl.registerLazySingleton(() => GetCharacters(sl()));

  sl.registerLazySingleton<CharacterRepository>(() => CharacterModelRepository(characterRemoteDataSource: sl(),));
   
  sl.registerLazySingleton<CharacterRemoteDataSource>(() => CharacterRemoteDataSource());

   sl.registerFactory(() => FavoriteBloc(
      sl(),
    ));
  sl.registerLazySingleton<FavoriteRepository>(() => FavoriteRepository());  
}