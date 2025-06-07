import 'package:flutter/material.dart';
import 'package:flutter_tap2025/models/popular_model.dart';
import 'package:flutter_tap2025/screens/challenge_screen.dart';
import 'package:flutter_tap2025/screens/dashboard_screen.dart';
import 'package:flutter_tap2025/screens/detail_popular_movie.dart';
import 'package:flutter_tap2025/screens/login_screen.dart';
import 'package:flutter_tap2025/screens/weather_dashboard_screen.dart';
import 'package:flutter_tap2025/screens/popular_screen.dart';
import 'package:flutter_tap2025/screens/my_home_page.dart'; 
import 'package:flutter_tap2025/screens/favorites_screen.dart';
import 'package:flutter_tap2025/utils/global_values.dart';
import 'package:flutter_tap2025/utils/theme_settings.dart';
import 'package:flutter_tap2025/network/api_popular.dart';
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiPopular _apiPopular = ApiPopular();
  List<PopularModel> _movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final movies = await _apiPopular.getPopularMovies();
    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: GlobalValues.themeMode,
      builder: (context, value, widget) {
        return MaterialApp(
          theme: ThemeSettings.setTheme(value),
          home: const LoginScreen(),
          routes: {
            "/dash" : (context) => const DashboardScreen(),
            "/reto" : (context) => const ChallengeScreen(),
            "/api" : (context) => PopularScreen(movies: _movies),
            "/detail" : (context) => const DetailPopularMovie(),
            "/home" : (context) => const MyHomePage(),
            "/favorites" : (context) => FavoritesScreen(favoriteMovies: _movies.where((m) => m.isFavorite).toList()),
            "/weather": (context) => WeatherDashboardScreen.builder(context),
          },
        );
      }
    );
  }
}