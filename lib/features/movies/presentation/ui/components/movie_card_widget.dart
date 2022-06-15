import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/utils/api_utils.dart';
import '/features/movies/domain/entities/movie_details_entity.dart';
import '/features/movies/presentation/ui/views/pages/details_page/details_page.dart';


/// Shows a movie card with the data from [movie]
///
///     | Movie Card Widget -------------|
///     |               |                |
///     | LEFT Fragment | RIGHT Fragment |
///     |               |                |
///     |--------------------------------|
/// 
/// This layout doesn't change between screens, only the density.
/// The parent layout that calls this widget must show more or less cards,
/// depending on the screen size.
/// 
////////////////////////////////////////////////////////////////////////////
class MovieCardWidget extends StatelessWidget {
  final MovieDetailsEntity movie;
  const MovieCardWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailsPage(movie: movie),
              fullscreenDialog: true,
            ),
          );
        },
        child: Card(
          elevation: 1.0,
          margin: const EdgeInsets.all(8),
          child: AspectRatio(
            aspectRatio: 5 / 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _moviePosterFragmentLeft(context),
                _movieDataFragmentRight(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Movie Card Left Side, with the movie poster/cover about a movie
  ///
  /////////////////////////////////////////////////////////////////////////////
  ///
  ///     |-----------------|
  ///     |  MOVIE POSTER   |
  ///     |    Fragment     |
  ///     |-----------------|
  ///
  //////////////////////////////////////////////////////////////////////////
  Widget _moviePosterFragmentLeft(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      color: Theme.of(context).cardTheme.color,
      child: Hero(
        tag: movie.id,

        /// From package cached_network_image
        child: CachedNetworkImage(
          /// Builds the poster
          imageBuilder: (context, imageProvider) => AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                boxShadow: const [
                  /// Puts a shadow behind the poster
                  BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: Colors.black,
                    spreadRadius: -50,
                    blurRadius: 50,
                    offset: Offset(30, 0),
                  ),
                ],
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// If the poster is not available show a Error icon
          errorWidget: (context, url, error) {
            return AspectRatio(
              aspectRatio: 2 / 3,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: const Icon(Icons.error),
              ),
            );
          },

          /// When is loading shows a loader animation
          placeholder: (context, url) => AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          imageUrl: API.requestImg(movie.posterPath),
          //imageUrl: "http://4568976s213noexist.com.br/",
        ),
      ),
    );
  }

  ///  Card right side, with data about a movie
  ///
  /////////////////////////////////////////////////////////////////////////////
  ///
  ///     |-----------------|
  ///     |   MOVIE DATA    |
  ///     |    Fragment     |
  ///     |-----------------|
  ///
  //////////////////////////////////////////////////////////////////////////
  Widget _movieDataFragmentRight(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Movie Title
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headline6,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            /// Original Title + (Released Year)
            Text(
              movie.originalTitle.toString() +
                  ' (' +
                  movie.releaseDate.substring(0, 4) +
                  ')',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            /// Popularity
            _dataRow(
              context,
              AppLocalizations.of(context)!.popularity,
              movie.popularity.toString(),
            ),
            /// Ratting
            _dataRow(
              context,
              AppLocalizations.of(context)!.ratting,
              movie.voteAverage.toString(),
            ),
            const SizedBox(
              height: 8,
            ),
            /// App specifics, Favorite Button and See More Chip
            Align(
              alignment: Alignment.bottomRight,
              child: Wrap(
                textDirection: TextDirection.ltr,
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.star_border_outlined),
                  ),
                  Chip(
                    avatar: const Icon(Icons.chevron_right_rounded),
                    label: Text(AppLocalizations.of(context)!.seeMore),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Used in Movie Data, returns a widget with a line formated data with [name] and [value]
  Widget _dataRow(BuildContext context, String name, String value) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.fade,
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(value),
      ],
    );
  }
}
