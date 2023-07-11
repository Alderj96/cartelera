import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/models/movie_details.dart';
import 'package:cinemapedia/infraestructure/models/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: moviedb.backdropPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: moviedb.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'https://www.movienewz.com/img/films/poster-holder.jpg',
        releaseDate: moviedb.releaseDate,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );

  static Movie movieDetailToEntity(MovieDetails movideDetail) => Movie(
        adult: movideDetail.adult,
        backdropPath: movideDetail.backdropPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${movideDetail.backdropPath}'
            : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
        genreIds: movideDetail.genres.map((e) => e.name).toList(),
        id: movideDetail.id,
        originalLanguage: movideDetail.originalLanguage,
        originalTitle: movideDetail.originalTitle,
        overview: movideDetail.overview,
        popularity: movideDetail.popularity,
        posterPath: movideDetail.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${movideDetail.posterPath}'
            : 'https://www.movienewz.com/img/films/poster-holder.jpg',
        releaseDate: movideDetail.releaseDate,
        title: movideDetail.title,
        video: movideDetail.video,
        voteAverage: movideDetail.voteAverage,
        voteCount: movideDetail.voteCount,
      );
}