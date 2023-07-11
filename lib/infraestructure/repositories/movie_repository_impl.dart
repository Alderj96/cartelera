import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieDatasource movieDatasource;

  MovieRepositoryImpl(this.movieDatasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return movieDatasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return movieDatasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return movieDatasource.getTopRated(page: page);
  }
  
  @override
  Future<List<Movie>> getUpComming({int page = 1}) {
    return movieDatasource.getUpComming(page: page);
  }
  
  @override
  Future<Movie> getMovieById(String movieId) {
    return movieDatasource.getMovieById(movieId);
  }
  
  @override
  Future<List<Movie>> searchMovie(String query) {
    return movieDatasource.searchMovie(query);
  }

}