import 'package:cinemapedia/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProviders = StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {

  final moviesRepository = ref.watch(movieRepositoryProvider);

  return SearchMoviesNotifier(
    searchMovies: moviesRepository.searchMovie,
    ref: ref,
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {

  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).update((state) => query);
    final movies = await searchMovies(query);
    state = movies;
    return movies;
  }

}