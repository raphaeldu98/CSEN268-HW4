import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hw4/bloc/go_router_refresh_bloc.dart';
import 'package:hw4/cubit/book_cubit.dart';
import 'package:hw4/models/book_model.dart';
import 'package:hw4/page/book_detail.dart';
import 'package:hw4/page/book_list.dart';
import 'package:hw4/page/home_page.dart';
import 'package:hw4/page/login_page.dart';
import 'package:hw4/page/profile_screen.dart';
import 'bloc/authentication_bloc.dart';

void main() {
  runApp(BookClubApp());
}

class BookClubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthenticationBloc()),
        BlocProvider(create: (_) => BookCubit()..initBooks()), 
      ],
      child: Builder(
        builder: (context) {
          final authBloc = BlocProvider.of<AuthenticationBloc>(context);
          return MaterialApp.router(
            routerConfig: _goRouter(context, authBloc),
          );
        },
      ),
    );
  }

  GoRouter _goRouter(BuildContext context, AuthenticationBloc authBloc) {
    return GoRouter(
      refreshListenable: GoRouterRefreshBloc(authBloc.stream),
      initialLocation: '/login',
      redirect: (BuildContext context, GoRouterState state) {
        final bool loggedIn = authBloc.state == AuthenticationStatus.authenticated;
        final bool loggingIn = state.location == '/login';

        if (!loggedIn && !loggingIn) return '/login';

        if (loggedIn && loggingIn) return '/byAuthor';

        return null;
      },
      routes: [
        GoRoute(
          name: 'home',
          path: '/',
          redirect: (BuildContext context, GoRouterState state) => '/byAuthor',
        ),
        ShellRoute(
          builder: (context, state, child) => HomeScreen(child: child),
          routes: [
            GoRoute(
              name: 'byAuthor',
              path: '/byAuthor',
              builder: (context, state) => BookListScreen(byAuthor: true),
              routes: [
                GoRoute(
                  name: 'byAuthorDetail',
                  path: 'detail',
                  builder: (context, state) {
                    final book = state.extra as Book;
                    return BookDetailScreen();
                  },
                ),
              ],
            ),
            GoRoute(
              name: 'byTitle',
              path: '/byTitle',
              builder: (context, state) => BookListScreen(byAuthor: false),
              routes: [
                GoRoute(
                  name: 'byTitleDetail',
                  path: 'detail',
                  builder: (context, state) {
                    final book = state.extra as Book;
                    return BookDetailScreen();
                  },
                ),
              ],
            ),
            GoRoute(
              name: 'profile',
              path: '/profile',
              builder: (context, state) => ProfileScreen(),
            ),
          ],
        ),
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => LoginPage(),
        ),
      ],
    );
  }
}