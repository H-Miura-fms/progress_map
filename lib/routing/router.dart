//package
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//pages
import '../page/login.dart';
import '../routing/bottom_navigation.dart';
import '../page/config.dart';
import '../page/home.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      name: "login",
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
    // GoRoute(
    //   name: "home",
    //   path: '/',
    //   builder: (BuildContext context, GoRouterState state) => const HomePage(),
    // ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BottomNavigation(child: child);
      },
      routes: [
        GoRoute(
          path: "/home",
          pageBuilder: (BuildContext context, GoRouterState state) =>
              _buildPageWithAnimation(const HomePage()),
        ),
        GoRoute(
          path: "/setting",
          pageBuilder: (BuildContext context, GoRouterState state) =>
              _buildPageWithAnimation(const ConfigPage()),
        ),
      ],
    ),
  ],
);
CustomTransitionPage<void> _buildPageWithAnimation(Widget page) {
  return CustomTransitionPage<void>(
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    transitionDuration: const Duration(milliseconds: 0),
  );
}
