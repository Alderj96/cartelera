import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infraestructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infraestructure/models/creadits_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/enviroment.dart';

class ActorMovieDBDatasource extends ActorsDataSource {

  final dio = Dio(BaseOptions(
    baseUrl: Enviroment.movieDBBaseUrl,
    queryParameters: {
      'api_key': Enviroment.movieDBKey,
      'language': Enviroment.movieDBLanguage,
    }
  ));


  List<Actor> _jsonToActors (Map<String, dynamic> data) {
    final castData = CreditsResponse.fromMap(data);

    return castData.cast
    .map(
      (cast) => ActorMapper.castToEntity(cast),
    ).toList();
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get(
      '/movie/$movieId/credits',
    );

    return _jsonToActors(response.data);
  }

}