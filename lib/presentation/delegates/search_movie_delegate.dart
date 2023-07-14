import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  void _onQueryChange(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    isLoadingStream.add(true);
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      initialMovies = movies;
      if (!debounceMovies.isClosed) debounceMovies.add(movies);
      if (!isLoadingStream.isClosed) isLoadingStream.add(false);
    });
  }

  void clearStreams() {
    debounceMovies.close();
    isLoadingStream.close();
  }

  Widget buildResultsAndSuggestions () {
    return StreamBuilder(
      stream: debounceMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onMovieSelected: (Movie movie) {
                close(context, movie);
                clearStreams();
              },
            );
          },
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: isLoadingStream.stream,
        initialData: false,
        builder: (context, snapshot) {
          final isLoadding = snapshot.data ?? false;

          return Visibility(
            visible: !isLoadding,
            replacement: SpinPerfect(
              spins: 20,
              infinite: true,
              duration: const Duration(seconds: 20),
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.refresh_rounded),
              ),
            ),
            child: FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.clear),
              ),
            ),
          );
        },
      ),
      
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () {
        close(context, null);
        clearStreams();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(Movie movie) onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onMovieSelected(movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child,),
                ),
              ),
            ),

            const SizedBox(width: 10,),

            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium,),
                  Text(movie.overview, style: textStyles.bodyMedium, maxLines: 3, overflow: TextOverflow.ellipsis,),
                  Row(
                    children: [
                      Icon(Icons.star_half, color: Colors.yellow.shade800,),
                      const SizedBox(width: 5,),
                      Text(
                        HumanFormats.number(movie.voteAverage, decimals: 1),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return ListTile(
    //   leading: ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: Image.network(movie.posterPath),
    //   ),
    //   title: Text(movie.title),
    //   subtitle: Text(movie.overview, maxLines: 2,),
    // );
  }
}