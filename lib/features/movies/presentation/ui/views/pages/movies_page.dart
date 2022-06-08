import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

import '/features/movies/domain/entities/movie_entity.dart';
import '/features/movies/presentation/controllers/movie_controller.dart';
import '/features/movies/presentation/ui/views/pages/settings_view.dart';
import '/features/movies/presentation/ui/components/custom_list_card_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  static const routeName = '/moviesPage';

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late final MovieController _controller;
  bool _fetchError = false;

  late ScrollController _hideButtonController;

  // TODO mudar variáveis para settings view e incluir no services e no controller
  final bool _pinned = false;
  final bool _floating = true;

// FAB Animation
  final duration = const Duration(milliseconds: 300);
  var _showFab = true;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I.get<MovieController>();
    _settingScrollBar();
    _fethMovies();
  }

  // TODO FUTURE: Create a state to represent WITHOUT A INTERNET CONNECTION on bloc provider
  void _fethMovies() async {
    var e = await _controller.fetch();

    // If the page was changed to another, return to avoid SetState() error
    if (!mounted) return;

    setState(() {
      if (e) {
        _fetchError = false;
      } else {
        _fetchError = true;
      }
    });
  }

  /// TODO MOVE TO CONTROLLER
  void _settingScrollBar() {
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.atEdge) {
        
        if (_showFab == false) {
          setState(() {
            _showFab = true;
          });
          return;
        }
      }

      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_showFab == true) {
          setState(() {
            _showFab = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_showFab == false) {
            setState(() {
              _showFab = true;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO NEXT FUTURE: develop the drawer with Title, About, and with Navigation Rail
      drawer: Container(),
      body: SafeArea(
        child: CustomScrollView(
          controller: _hideButtonController,
          slivers: [
            _sliverAppBarFloatPersistentSearch(),
            _moviesSliverList(),
            const SliverToBoxAdapter(
              // Space to a FAB button as the height of AppBar
              child: SizedBox(height: kToolbarHeight + 8.0),
            )
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  /// Scroll Up Floating Action Buttons
  Widget _floatingActionButton() {
    return AnimatedSlide(
      duration: duration,
      offset: _showFab ? Offset.zero : const Offset(0, 2),
      child: AnimatedOpacity(
        duration: duration,
        opacity: _showFab ? 1 : 0,
        child: FloatingActionButton(
          child: const Icon(
            Icons.arrow_upward_rounded,
          ),
          onPressed: () {
            _hideButtonController.animateTo(
              0.0,
              duration: duration * 2,
              curve: Curves.linear,
            );
          },
        ),
      ),
    );
  }

  /// Persistent Search Floating App Bar
  // TODO move to components
  Widget _sliverAppBarFloatPersistentSearch() {
    return SliverAppBar(
      leading: Container(),
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.transparent,
      pinned: _pinned,
      snap: _floating,
      floating: _floating,
      toolbarHeight: 60.0,
      expandedHeight: 56.0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: AppBar(
          titleSpacing: 0.0,
          title: ValueListenableBuilder<MovieEntity?>(
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
                          hintText: AppLocalizations.of(context)!.searchAMovie,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
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
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

// Mover para componentes
  Widget _moviesSliverList() {
    return SliverToBoxAdapter(
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
              : _fetchError
                  ? _noInternetConnectionMessage()
                  : Lottie.asset('assets/lottie.json', repeat: true);
        },
      ),
    );
  }

  Widget _noInternetConnectionMessage() {
    // TODO personalize and translate
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: Colors.amber),
                const SizedBox(width: 16),
                // TODO translate
                Text(
                  "There was a problem!",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          // TODO translate
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Unable to establish an Internet connection. Please verify your Data or Wifi connection.",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ButtonBar(
              children: [
                // TODO move to components (Material Design 3 style)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    // Foreground color
                    onPrimary:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                    // Background color
                    primary: Theme.of(context).colorScheme.secondaryContainer,
                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  onPressed: () {
                    setState(() {
                      _fetchError = false;
                      _fethMovies();
                    });
                  },
                  label: const Text('Try Again'),
                  icon: const Icon(Icons.replay),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
