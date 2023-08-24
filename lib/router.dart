import 'package:flutter/material.dart';
import 'package:reddit_tutorial/features/auth/screens/login_screen.dart';
import 'package:reddit_tutorial/features/community/screens/create_community_screens.dart';
import 'package:reddit_tutorial/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

import 'features/community/screens/community_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  "/": (route) => MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  "/": (route) => MaterialPage(child: HomeScreen()),
  "/create-community": (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  "/r/:name": (route) => MaterialPage(
          child: CommunityScreen(
        name: route.pathParameters['name']!,
      )),
});
