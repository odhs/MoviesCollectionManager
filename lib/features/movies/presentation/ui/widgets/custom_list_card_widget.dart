import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/utils/api.utils.dart';
import '/features/movies/domain/entities/movie_details_entity.dart';
import '/features/movies/presentation/ui/views/pages/details_page.dart';

/// Shows a movie card with summary information
class CustomListCardWidget extends StatelessWidget {
  final MovieDetailsEntity movie;
  const CustomListCardWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;

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
            aspectRatio: 3.5 / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                movieCover(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: Theme.of(context).textTheme.headline6,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          movie.originalTitle.toString() +
                              ' (' +
                              movie.releaseDate.substring(0, 4) +
                              ')',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        dataRow(
                          context,
                          AppLocalizations.of(context)!.popularity,
                          movie.popularity.toString(),
                        ),
                        dataRow(
                          context,
                          AppLocalizations.of(context)!.ratting,
                          movie.voteAverage.toString(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
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
                                label:
                                    Text(AppLocalizations.of(context)!.seeMore),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget movieCover() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: Colors.black,
            spreadRadius: -50,
            blurRadius: 50,
            offset: Offset(30, 0), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        child: Hero(
          tag: movie.id,
          child: CachedNetworkImage(
            imageUrl: API.requestImg(movie.posterPath),
          ),
        ),
      ),
    );
  }


  Widget dataRow(BuildContext context, String name, String value) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(
              fontWeight: FontWeight.bold, overflow: TextOverflow.fade),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(value),
      ],
    );
  }
}
