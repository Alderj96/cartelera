import '../entities/movie.dart';

abstract class MovieRepository {

  Future<List<Movie>> getNowPlaying ({int page = 1});
  Future<List<Movie>> getPopular ({int page = 1});
  Future<List<Movie>> getUpComming ({int page = 1});
  Future<List<Movie>> getTopRated ({int page = 1});

  Future<Movie> getMovieById(String movieId);
  Future<List<Movie>> searchMovie(String query);
}