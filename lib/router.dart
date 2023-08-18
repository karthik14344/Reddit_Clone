import 'package:flutter/material.dart';
import 'package:reddit_tutorial/features/auth/screens/login_screen.dart';
import 'package:reddit_tutorial/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute =
    RouteMap(routes: {"/": (route) => MaterialPage(child: LoginScreen())});

final loggedInRoute =
    RouteMap(routes: {"/": (route) => MaterialPage(child: HomeScreen())});
