import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRespositoryImpl extends ActorsRespository {

  final ActorsDataSource _actorsDatadource;

  ActorsRespositoryImpl(this._actorsDatadource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return _actorsDatadource.getActorsByMovie(movieId);
  }

}