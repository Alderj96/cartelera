import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = state.pathParameters['page'] ?? '0';
        int intPageIndex = int.parse(pageIndex);
        if (intPageIndex < 0) intPageIndex = 0;
        if (intPageIndex > 2) intPageIndex = 2;
        return HomeScreen(pageIndex: intPageIndex,);
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId,);
          },
        ),
      ]
    ),

    GoRoute(
      path: '/',
      redirect: (_, __) {
        return '/home/0';
      },
    ),

  ],
);
