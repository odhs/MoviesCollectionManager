import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/core/utils/api.utils.dart';
import '/features/movies/domain/entities/movie_details_entity.dart';

/// Shows sinopsis about a movie
class DetailsPage extends StatelessWidget {
  final MovieDetailsEntity movie;
  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  static const routeName = '/detailsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .55,
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: movie.id,
                child: CachedNetworkImage(
                  imageUrl: API.requestImg(movie.posterPath),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Synopsis",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              movie.overview,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
