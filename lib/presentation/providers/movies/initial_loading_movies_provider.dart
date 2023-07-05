import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';


final initialLoadingMoviesProvider = Provider<bool>((ref) {
  final nowPlayingMoviesIsEmpty = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final popularMoviesIsEmpty = ref.watch(popularMoviesProvider).isEmpty;
  final topRatedMoviesIsEmpty = ref.watch(topRatedMoviesProvider).isEmpty;
  final upComingMoviesIsEmpty = ref.watch(upComingMoviesProvider).isEmpty;

  return nowPlayingMoviesIsEmpty &&
    popularMoviesIsEmpty &&
    topRatedMoviesIsEmpty &&
    upComingMoviesIsEmpty;
});