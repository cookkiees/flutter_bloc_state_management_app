import 'package:bloc_state_management/app/modules/article/presentation/pages/article_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../modules/article/domain/entities/article_data_entity.dart';
import '../../modules/article/presentation/bloc/article_bloc.dart';
import '../../modules/article/presentation/pages/article_screen.dart';
import '../../modules/counter/bloc/counter_bloc.dart';
import '../../modules/counter/pages/counter_screen.dart';
import '../../modules/main/main_screen.dart';
import '../../modules/user/presentation/bloc/user_bloc.dart';
import '../../modules/user/presentation/pages/user_screen.dart';
import 'my_routes.dart';

class MyRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static router() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/user',
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainScreen(navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: MyRoutes.user,
                  path: '/user',
                  builder: (context, state) => BlocProvider(
                    create: (context) => UserBloc(),
                    child: const UserScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: MyRoutes.counter,
                  path: '/counter',
                  builder: (context, state) => BlocProvider(
                    create: (context) => CounterBloc(),
                    child: const CounterScreen(),
                  ),
                )
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: MyRoutes.article,
                  path: '/article',
                  builder: (context, state) => BlocProvider(
                    create: (context) => ArticleBloc(),
                    child: const ArticleScreen(),
                  ),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      name: MyRoutes.articleDetail,
                      path: 'article-detail/:author',
                      builder: (context, state) {
                        state.pathParameters['author'];
                        final article = state.extra as ArticleDataEntity;
                        return BlocProvider(
                          create: (context) => ArticleBloc(),
                          child: ArticleDetailScreen(article: article),
                        );
                      },
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
