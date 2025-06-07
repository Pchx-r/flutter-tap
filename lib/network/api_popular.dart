import 'package:dio/dio.dart';
import 'package:flutter_tap2025/models/actores_models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_tap2025/models/popular_model.dart';
class ApiPopular {
  
  final URL = 'https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1';

  Future<List<PopularModel>> getPopularMovies() async{
    final dio = Dio();
    final response = await dio.get(URL);
    final res = response.data['results'] as List;
    return res.map((movie) => PopularModel.fromMap(movie)).toList();
  }

  Future<String?> getTrailerKey(int movieId) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      final trailer = results.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );
      return trailer != null ? trailer['key'] : null;
    } else {
      throw Exception('Failed to load trailer');
    }
  }

  Future<List<Cast>> getCast(int movieId) async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$movieId/credits?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final castList = data['cast'] as List<dynamic>;

      return castList.take(10).map((actor) {
        return Cast(
          adult: actor['adult'], 
          gender: actor['gender'], 
          id: actor['id'], 
          knownForDepartment: actor['known_for_department'], 
          name: actor['name'], 
          originalName: actor['original_name'], 
          popularity: actor['popularity'], 
          profilePath: actor['profile_path'],
          castId: actor['cast_id'],
          character: actor['character'], 
          creditId: actor['credit_id'], 
          order: actor['order'],
          department: actor['department'],
          job: actor['job'],
          );
      }).toList();
    } else {
      throw Exception('Failed to load cast');
    }
  }


  
}