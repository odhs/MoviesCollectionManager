import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/utils/api_utils.dart';
import '/features/movies/domain/entities/movie_details_entity.dart';

/// Shows sinopsis about a movie
///
/// Body decides about build for tablet or mobile depends on width
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
            return _bodyTabletLayout(context);
          } else {
            return _bodyMobileLayout(context);
          }
        }));
  }

  /// Title with subline and edges distances, used in _fragmentRightMovieInfo
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
        ),
      ),
    );
  }

  /// Row with name and value, used in _fragmentRightMovieInfo
  Widget _nameValueListTile(String name, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      subtitle: Text(value),
    );
  }

  /// Left Side of the page
  Widget _fragmentLeftHeroPoster() {
    return Hero(
      tag: movie.id,
      child: CachedNetworkImage(
        imageUrl: API.requestImg(movie.posterPath),
      ),
    );
  }

  /// Right side of the page
  Widget _fragmentRightMovieInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          movie.originalTitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).disabledColor),
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
        _nameValueListTile("Data de Lançamento", movie.releaseDate,
            Icons.calendar_month_rounded),
        // TODO incluir na internacionalização
        _nameValueListTile(
            "Língua Original", movie.originalLanguage, Icons.flag_rounded),
      ],
    );
  }

  /// Body: TABLET
  Widget _bodyTabletLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: _fragmentLeftHeroPoster(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: _fragmentRightMovieInfo(context),
            ),
          ),
        ),
      ],
    );
  }

/*
  /// Body: MOBILE2
  Widget _bodyTabletLayout2(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        children: [
          _fragmentLeftHeroPoster(),
          _fragmentRightMovieInfo(context),
        ]);
  }
  */

  /// Body: MOBILE
  Widget _bodyMobileLayout(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        children: [
          _fragmentLeftHeroPoster(),
          const SizedBox(height: 16),
          _fragmentRightMovieInfo(context),
        ]);
  }
}
