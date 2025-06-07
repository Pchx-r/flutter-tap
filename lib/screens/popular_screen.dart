import 'package:flutter/material.dart';
import 'package:flutter_tap2025/models/popular_model.dart';

class PopularScreen extends StatefulWidget {
  final List<PopularModel> movies;
  const PopularScreen({super.key, required this.movies});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Películas Populares")),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          return ItemPopular(widget.movies[index]);
        },
      ),
    );
  }

  Widget ItemPopular(PopularModel popular) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: popular,
              );
            },
            child: Hero(
              tag: 'movieImage_${popular.id}', 
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(popular.backdropPath),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                popular.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: popular.isFavorite ? Colors.red : Colors.white.withOpacity(0.5),
              ),
              onPressed: () {
                setState(() {
                  popular.isFavorite = !popular.isFavorite;
                });
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      popular.title,
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.white, size: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}