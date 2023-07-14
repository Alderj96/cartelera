import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies = await ref.read(favoritesMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(favoritesMoviesProvider).values.toList();

    if (favoritesMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary,),
            Text('Ohhh no!!', style: TextStyle(fontSize: 30, color: colors.primary),),
            Text(
              'No tienes peliculas favoritas',
              style: TextStyle(
                fontSize: 20,
                color: colors.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: const Text('Empieza a buscar'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: MovieMasonry(
          loadNextPage: loadNextPage,
          movies: favoritesMovies,
        ),
      ),
    );
  }
}