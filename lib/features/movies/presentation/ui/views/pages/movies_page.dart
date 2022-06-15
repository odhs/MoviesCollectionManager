import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

import '/features/movies/domain/entities/movie_entity.dart';
import '/features/movies/presentation/controllers/movies_controller.dart';
import '/features/movies/presentation/ui/views/pages/settings_view.dart';
import '/features/movies/presentation/ui/components/movie_card_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  static const routeName = '/moviesPage';

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late final MoviesController _controller;
  bool _fetchError = false;

  late ScrollController _scrollControler;

  // TODO mudar variáveis para settings view e incluir no services e no controller
  final bool _pinned = false;
  final bool _floating = true;

// FAB Animation
  final duration = const Duration(milliseconds: 300);
  var _showScrollFAB = false;
  var _isScrollToTopEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = GetIt.I.get<MoviesController>();
    _initScrollController();
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
  void _initScrollController() {
    _scrollControler = ScrollController();

    _scrollControler.addListener(() {
      if (!mounted) return;

      /// Hide FAB arrow when the list is on the top
      if (_scrollControler.position.pixels < 1) {
        setState(
          () {
            _showScrollFAB = false;
            _isScrollToTopEnabled = false;
          },
        );
      } else {
        setState(
          () {
            _showScrollFAB = true;
          },
        );
      }

      if (_scrollControler.position.pixels >=
          _scrollControler.position.maxScrollExtent) {
        /// Arrow UP
        _isScrollToTopEnabled = true;
      } else {
        /// Reverse == scroll bar to Bottom
        if (_scrollControler.position.userScrollDirection ==
            ScrollDirection.reverse) {
          /// Scrolling to Bottom
          /// Content up
          /// Shows FAB Arrow UP
          _isScrollToTopEnabled = false;
        } else {
          /// Scrolling to Top
          /// Content down
          /// Shows FAB Arrow DOWN
          _isScrollToTopEnabled = true;
        }
      }
    });
  }

  void _scrollToTop() {
    _scrollControler.animateTo(
      0.0,
      duration: duration * 2,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _scrollToBottom() {
    _scrollControler.animateTo(
      _scrollControler.position.maxScrollExtent,
      duration: duration * 2,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _scrollControler.dispose(); // dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // TODO NEXT FUTURE: develop the drawer with Title, About, and with Navigation Rail
      drawer: Container(),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollControler,
          slivers: [
            _sliverLogoTMDB(),
            _sliverAppBarFloatingPersistentSearch(),
            _sliverGridMoviesList(),
            /*DeviceScreenInfoUtils.getFormFactor(context) == ScreenType.tablet
                ? _sliverGridMoviesList()
                : _sliverMoviesListHandSet(),*/

            const SliverToBoxAdapter(
              // Space to a FAB button as the height of AppBar + 8.0
              child: SizedBox(height: kToolbarHeight + 16.0),
            )
          ],
        ),
      ),
      floatingActionButton: _floatingActionButtonScrollUp(),
    );
  }

  /// Scroll Up Floating Action Buttons
  Widget _floatingActionButtonScrollUp() {
    return AnimatedSlide(
      duration: duration,
      offset: _showScrollFAB ? Offset.zero : const Offset(0, 2),
      child: AnimatedOpacity(
        duration: duration,
        opacity: _showScrollFAB ? 1 : 0,
        child: FloatingActionButton(
          elevation: 3.0,
          child: AnimatedRotation(
            turns: _isScrollToTopEnabled ? 0 : .5,
            duration: duration,
            child: const Icon(
              Icons.arrow_upward_rounded,
            ),
          ),
          onPressed: () {
            if (_isScrollToTopEnabled) {
              // Arrow to UP
              _scrollToTop();
            } else {
              // Arrow to DOWN
              _scrollToBottom();
            }
          },
        ),
      ),
    );
  }

  Widget _sliverLogoTMDB() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: SvgPicture.asset(
            color: Theme.of(context).colorScheme.inverseSurface,
            'assets/tmdb-logo.svg',
            semanticsLabel: 'TMDB logo',
          ),
        ),
      ),
    );
  }

  /// Persistent Search Floating App Bar
  // TODO move to components
  Widget _sliverAppBarFloatingPersistentSearch() {
    return SliverAppBar(
      leading: Container(),
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.transparent,
      pinned: _pinned,
      snap: _floating,
      floating: _floating,
      toolbarHeight: 56.0,
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

// TODO Mover para componentes
  /// Layout to Handset
  Widget _sliverMoviesListHandSet() {
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
                  itemBuilder: (_, index) => MovieCardWidget(
                    movie: movies.listMovies[index],
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

  /// Layout to Tablet
  Widget _sliverGridMoviesList() {
    return SliverToBoxAdapter(
      // Glue the MoviesController in the ListView
      child: ValueListenableBuilder<MovieEntity?>(
        valueListenable: _controller.movies,
        builder: (_, movies, __) {
          return movies != null
              ? OrientationBuilder(
                  builder: (context, orientation) {
                    return GridView.count(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount:
                          orientation == Orientation.portrait ? 1 : 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 5 / 3,
                      children: List.generate(
                        movies.listMovies.length,
                        (index) {
                          return MovieCardWidget(
                            movie: movies.listMovies[index],
                          );
                        },
                      ),
                    );
                  },
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
                Text(
                  // TODO translate
                  "There was a problem!",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              // TODO translate
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
