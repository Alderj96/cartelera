import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesMovies = ref.watch(favoritesMoviesProvider);
    return Scaffold(
      body: ListView.builder(
        itemCount: favoritesMovies.length,
        itemBuilder: (context, index) {
          final movie = favoritesMovies[index];
          return ListTile(
            title: Text(movie.title),
          );
        },
      ),
    );
  }
}