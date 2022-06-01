import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:movieapp/features/movies/presentation/ui/views/pages/settings_view.dart';

import '/features/movies/domain/entities/movie_entity.dart';
import '/features/movies/presentation/controllers/movie_controller.dart';
import '/features/movies/presentation/ui/widgets/custom_list_card_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  static const routeName = '/moviesPage';

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late final MovieController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I.get<MovieController>();
  }

// TODO mudar variávies para settings view e incluir nos serviços
  final bool _pinned = false;
  final bool _floating = true;
  //final bool _snap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO develop the drawer with Title, About, etc
      drawer: Container(),
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            leading: Container(),
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.transparent,
            //backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            pinned: _pinned,
            snap: _floating,
            floating: _floating,
            toolbarHeight: 60.0,
            expandedHeight: 56.0,
            flexibleSpace: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: AppBar(
                titleSpacing: 0.0,
                title: GestureDetector(
                  onTap: () {},
                  // Glue the MovieController to the text field.
                  child: ValueListenableBuilder<MovieEntity?>(
                    valueListenable: _controller.movies,
                    builder: (__, movies, _) {
                      return Visibility(
                        visible: movies != null,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                onChanged: _controller.onChanged,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)!
                                      .searchAMovie,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                centerTitle: false,
                elevation: 0.0,
                backgroundColor:
                    //Theme.of(context).colorScheme.onSurface.withAlpha(25),
                    Theme.of(context).colorScheme.onInverseSurface,
                shape: const StadiumBorder(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.filter_alt),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.restorablePushNamed(
                          context, SettingsView.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            // Glue the MoviesController in the ListView
            child: ValueListenableBuilder<MovieEntity?>(
              valueListenable: _controller.movies,
              builder: (_, movies, __) {
                return movies != null
                    // TODO arranjar outra solução para ListView ter performance na memória
                    ? ListView.builder(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: movies.listMovies.length,
                        itemBuilder: (_, idx) => CustomListCardWidget(
                          movie: movies.listMovies[idx],
                        ),
                      )
                    // Shows a loader
                    : Lottie.asset('assets/lottie.json', repeat: true);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
