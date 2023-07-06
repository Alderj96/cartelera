import 'package:cinemapedia/infraestructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infraestructure/repositories/actor_respository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) {
  return ActorsRespositoryImpl(ActorMovieDBDatasource());
});