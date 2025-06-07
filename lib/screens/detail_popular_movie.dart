import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tap2025/models/actores_models.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_tap2025/models/popular_model.dart';
import 'package:flutter_tap2025/network/api_popular.dart';

class DetailPopularMovie extends StatefulWidget {
  const DetailPopularMovie({super.key});

  @override
  State<DetailPopularMovie> createState() => _DetailPopularMovieState();
}

class _DetailPopularMovieState extends State<DetailPopularMovie> {
  late PopularModel popular;
  String? trailerKey;
  List<Cast>? cast;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    popular = ModalRoute.of(context)!.settings.arguments as PopularModel;
    _loadTrailer();
    _searchCast();
  }

  Future<void> _loadTrailer() async {
    final api = ApiPopular();
    final key = await api.getTrailerKey(popular.id);
    setState(() {
      trailerKey = key;
    });
  }

  Future<void> _searchCast() async {
    final api = ApiPopular();
    final castList = await api.getCast(popular.id);
    setState(() {
      cast = castList.isNotEmpty ?castList : [];
    });
    }

  @override
  Widget build(BuildContext context) {
    Hero(
      tag: 'movieImage_${popular.id}', 
      child: Image.network(
        popular.backdropPath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 300,
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text(popular.title)),
      body: trailerKey == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(popular.backdropPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(0.5), 
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: trailerKey!,
                            flags: YoutubePlayerFlags(autoPlay: true),
                          ),
                          showVideoProgressIndicator: true,
                        ),
                        Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sinapsis: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        popular.overview,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                         Text(
                        ' Rating: ${popular.voteAverage.toStringAsFixed(1)} ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          ),
                        ),
                        Icon (Icons.star, color: Colors.white, size: 20),
                        ],
                      ), 
                      Text(
                        'Cast: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 240,
                        child: cast == null 
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            scrollDirection:  Axis.horizontal,
                            itemCount: cast!.length,
                            itemBuilder: (context, index){
                              final actor =  cast![index];
                              return Container(
                                width: 130,
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Card(
                                      elevation: 20,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: actor.profilePath != null
                                            ? FadeInImage(
                                                width: 160,
                                                height: 150,
                                                placeholderFit: BoxFit.cover,
                                                fit: BoxFit.cover,
                                                placeholder: const AssetImage('assets/loading.gif'),
                                                image: NetworkImage(actor.fullProfilePath),
                                                imageErrorBuilder: (context, error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/no_image.png',
                                                    width: 160,
                                                    height: 150,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )
                                            : Container(
                                                height: 150,
                                                width: 160,
                                                color: Colors.grey,
                                                child: const Icon(
                                                  Icons.person,
                                                  size: 50,
                                            )
                                        ),
                                      )
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      actor.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5),
                                        Text(
                                          actor.character ?? 'No character',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                  ],
                                ),
                              );
                            },
                        )
                      )
                    ],
                  ),
                ),
                      ],
                    )
                  )
                
                
                
              ],
            ),
    );
  }
}
