class PopularModel {
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  double voteAverage;
  int voteCount;
  String? trailerUrl;
  bool isFavorite;

  /*PopularModel(String override){
    this.overview = override;
  }*/

  PopularModel({
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    this.isFavorite = false,
  });

  factory PopularModel.fromMap(Map<String,dynamic> movie){
    return PopularModel(
      backdropPath: 'https://image.tmdb.org/t/p/w500/${movie['backdrop_path']}' 
      ?? 'https://img.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-5529.jpg', 
      id: movie['id'], 
      originalLanguage: movie['original_language'], 
      originalTitle: movie['original_title'], 
      overview: movie['overview'], 
      popularity: movie['popularity'], 
      posterPath: 'https://image.tmdb.org/t/p/w500/${movie['poster_path']}'
                  ?? 'https://img.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-5529.jpg', 
      releaseDate: movie['release_date'], 
      title: movie['title'], 
      voteAverage: movie['vote_average'], 
      voteCount: movie['vote_count']
    );
  }

  
}