import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: const Text("Movie Details"),
        ),
        body: LayoutBuilder(builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          if (constraints.maxWidth > 600) {
            return _buildTabletBody(context);
          } else {
            return _buildMobileBody(context);
          }
        }));
  }

  // TODO tablet body
  Widget _buildTabletBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Hero(
          tag: movie.id,
          child: CachedNetworkImage(
            imageUrl: API.requestImg(movie.posterPath),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          movie.title,
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          movie.originalTitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).secondaryHeaderColor),
        ),
        _titleH3(context, AppLocalizations.of(context)!.synopsis),
        Text(
          movie.overview,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.justify,
          softWrap: true,
        ),
        const SizedBox(height: 16),
        // TODO incluir na internacionalização
        nameValueListTile("Data de Lançamento", movie.releaseDate,
            Icons.calendar_month_rounded),
        // TODO incluir na internacionalização
        nameValueListTile(
            "Língua Original", movie.originalLanguage, Icons.flag_rounded),
      ],
    );
  }

  Widget _buildMobileBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Hero(
          tag: movie.id,
          child: CachedNetworkImage(
            imageUrl: API.requestImg(movie.posterPath),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          movie.title,
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          movie.originalTitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).secondaryHeaderColor),
        ),
        _titleH3(context, AppLocalizations.of(context)!.synopsis),
        Text(
          movie.overview,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.justify,
          softWrap: true,
        ),
        const SizedBox(height: 16),
        // TODO incluir na internacionalização
        nameValueListTile("Data de Lançamento", movie.releaseDate,
            Icons.calendar_month_rounded),
        // TODO incluir na internacionalização
        nameValueListTile(
            "Língua Original", movie.originalLanguage, Icons.flag_rounded),
      ],
    );
  }

  Widget _titleH3(BuildContext context, String str) {
    return Container(
      margin: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 0.0,
      ),
      child: Text(
        str,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Theme.of(context).dividerColor.withAlpha(50),
          ),
        ), // This will create top borders for the rest
      ),
    );
  }

  Widget nameValueListTile(String name, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      subtitle: Text(value),
    );
  }
}
