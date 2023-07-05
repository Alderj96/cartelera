import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/movie_details.dart';
import 'package:cinemapedia/infraestructure/models/moviedb_response.dart';
import 'package:dio/dio.dart';

import '../../domain/datasources/movies_datasource.dart';

class MovieDBDataSource extends MovieDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: Enviroment.movieDBBaseUrl,
    queryParameters: {
      'api_key': Enviroment.movieDBKey,
      'language': Enviroment.movieDBLanguage,
    }
  ));

  List<Movie> _jsonToMovies (Map<String, dynamic> data) {
    final movieData = MovieDbResponse.fromMap(data);

    return movieData.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb),
    ).toList();
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
      },
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'page': page,
      },
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page': page,
      },
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpComming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
      },
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String movieId) async {
    final response = await dio.get('/movie/$movieId',);
    if (response.statusCode != 200) throw Exception('Movie with id: $movieId not found');

    final movieDB = MovieDetails.fromMap(response.data);

    return MovieMapper.movieDetailToEntity(movieDB);
  }

}