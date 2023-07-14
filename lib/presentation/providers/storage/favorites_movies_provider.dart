import 'package:cinemapedia/domain/repositories/local_storage_respository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';

final favoritesMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  int page = 0;
  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier({
    required this.localStorageRepository,
  }) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 15, limit: 15);
    if (movies.isNotEmpty) page++;

    final tempMoviesMap = <int, Movie>{};
    for(final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = { ...state, ...tempMoviesMap };
    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      // Accion necesario para mandar la renderización
      state = { ...state };
    } else {
      state = { ...state, movie.id: movie };
    }
  }
}