import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miniflix/view/detailview/videoview.dart';
import 'package:miniflix/view/detailview/viewdetail.dart';
import 'package:miniflix/view/viewmanage.dart';

class Approuter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ViewManage(),
        routes: [
          GoRoute(
            path: 'viewDetails',
            builder: (context, state) {
              final movieId = state.extra as String;
              return ViewDetail(movieId: movieId);
            },
          ),
          GoRoute(
            path: 'videoView',
            builder: (context, state) {
              final trailerKey = state.extra as String;
              return VideoView(trailerKey: trailerKey);
            },
          ),
        ],
      ),
    ],
  );
}
