import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'movie_poster_link.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback loadNextPage;

  const MovieMasonry({
    super.key,
    required this.movies,
    required this.loadNextPage,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 200) > scrollController.position.maxScrollExtent) {
        widget.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: widget.movies.length,
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        final movie = widget.movies[index];

        if (index == 1) {
          return Column(
            children: [
              const SizedBox(height: 40,),
              MoviePosterLink(movie: movie),
            ],
          );
        }
        return MoviePosterLink(movie: movie);
      },
    );
  }
}