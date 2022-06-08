import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/core/utils/device_screen_info_utils.dart';
import '/core/utils/api_utils.dart';
import '/features/movies/domain/entities/movie_details_entity.dart';

/// Shows the synopsis about a movie
///
/// Body decides about build for tablet or mobile depends on width
class DetailsPage extends StatelessWidget {
  final MovieDetailsEntity movie;
  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  static const routeName = '/detailsPage';

  @override
  Widget build(BuildContext context) {

    // TODO maybe future localization var section: var txt_synopsis = AppLocalizations.of(context)!.synopsis;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Movie Details"),
        ),
        body: LayoutBuilder(builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          if (constraints.maxWidth >= DeviceScreenInfoUtils.tablet) {
            return _bodyTabletLayout(context);
          } else {
            return _bodyMobileLayout(context);
          }
        }));
  }

  //////////////////////////////////////////////////////////////////////////
  ///
  ///     |-----------------|
  ///     |   HERO POSTER   |
  ///     |    Fragment     |
  ///     |-----------------|
  ///
  //////////////////////////////////////////////////////////////////////////

  /// FRAGMENT: Left Side of the page: Movie Poster
  Widget _fragmentHeroPoster() {
    return Hero(
      tag: movie.id,
      child: CachedNetworkImage(
        imageUrl: API.requestImg(movie.posterPath),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////
  ///
  ///     |----------------|
  ///     |   MOVIE INFO   |
  ///     |    Fragment    |
  ///     |----------------|
  ///
  //////////////////////////////////////////////////////////////////////////

  /// Title with subline and edges distances, used in _fragmentMovieInfo
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

  /// Row with name and value, used in _fragmentMovieInfo
  Widget _nameValueListTile(String name, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      subtitle: Text(value),
    );
  }

  /// FRAGMENT: Right/bottom side of the page: Movie Information
  Widget _fragmentMovieInfo(BuildContext context) {

    // Max-with of the synopsis text: 33% of the longest side on landscape
    var maxWidthInfo = double.infinity;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      maxWidthInfo = MediaQuery.of(context).size.longestSide * .33;
    }

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
        // Synopsis Text
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidthInfo),
          child: Text(
            movie.overview,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.justify,
            softWrap: true,
          ),
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

////////////////////////////////////////////////////////////////////////////
  ///
  ///     | TABLET LAYOUT -----------------|
  ///     |                                |
  ///     | LEFT Fragment | RIGHT Fragment |
  ///     |                                |
  ///     |--------------------------------|
  ///
////////////////////////////////////////////////////////////////////////////

  /// Body: TABLET
  Widget _bodyTabletLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // LEFT Fragment
        Expanded(
          flex: 6,
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: _fragmentHeroPoster(),
              ),
            ),
          ),
        ),
        // RIGHT Fragment
        Expanded(
          flex: 6,
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: _fragmentMovieInfo(context),
            ),
          ),
        ),
      ],
    );
  }

////////////////////////////////////////////////////////////////////////////
  ///
  ///     | HANDSET LAYOUT ---|
  ///     |                   |
  ///     |                   |
  ///     |   TOP Fragment    |
  ///     |                   |
  ///     |                   |
  ///     |                   |
  ///     |                   |
  ///     |  BOTTOM Fragment  |
  ///     |                   |
  ///     |                   |
  ///     |-------------------|
  ///
////////////////////////////////////////////////////////////////////////////

  /// Body: MOBILE
  Widget _bodyMobileLayout(BuildContext context) {
    return ListView(
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
        children: [
          // TOP Fragment
          _fragmentHeroPoster(),
          const SizedBox(height: 16),
          // BOTTOM Fragment
          _fragmentMovieInfo(context),
        ]);
  }
}
