/*
navigation_page.dart
@author Sérgio Henrique D. de Oliveira
@version 1.0.19
*/

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movieapp/core/utils/device_screen_info_utils.dart';

import '/features/movies/presentation/ui/views/pages/account_page.dart';
import '/features/movies/presentation/ui/views/pages/collections_page.dart';
import '/features/movies/presentation/ui/views/pages/movies_page.dart';

/// Perfoms the navigation between pages
class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _tabselected = 0;

  final pages = [
    const MoviesPage(),
    const CollectionsPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    List<NavigationDestination> destinations = [
      NavigationDestination(
        icon: const Icon(Icons.movie_filter_outlined),
        label: AppLocalizations.of(context)!.movies,
        selectedIcon: const Icon(Icons.movie_creation_rounded),
      ),
      NavigationDestination(
        icon: const Icon(Icons.video_library_outlined),
        label: AppLocalizations.of(context)!.collections,
        selectedIcon: const Icon(Icons.video_library_rounded),
      ),
      NavigationDestination(
        icon: const Icon(Icons.account_circle_outlined),
        label: AppLocalizations.of(context)!.account,
        selectedIcon: const Icon(Icons.account_circle_rounded),
      ),
    ];

    List<NavigationRailDestination> destinationsRail = [
      NavigationRailDestination(
        icon: const Icon(Icons.movie_filter_outlined),
        label: Text(AppLocalizations.of(context)!.movies),
        selectedIcon: const Icon(Icons.movie_creation_rounded),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.video_library_outlined),
        label: Text(AppLocalizations.of(context)!.collections),
        selectedIcon: const Icon(Icons.video_library_rounded),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.account_circle_outlined),
        label: Text(AppLocalizations.of(context)!.account),
        selectedIcon: const Icon(Icons.account_circle_rounded),
      ),
    ];

    MediaQuery.of(context).size.width > DeviceScreenInfoUtils.large
        ? print("yes")
        : print("NOT");

    double navigationRailIconSize =
        MediaQuery.of(context).size.width > DeviceScreenInfoUtils.hd ? 86 : 72;

    return SafeArea(
      child: Scaffold(
        drawer: Container(),
        body: Row(
          children: [
            MediaQuery.of(context).size.width >= DeviceScreenInfoUtils.large
                ? NavigationRail(
                    /// Center the buttons vertically
                    groupAlignment: -0.2,
                    /// Shows a logo
                    leading: SizedBox(
                      height: navigationRailIconSize,
                      width: navigationRailIconSize,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          'assets/tmdb-logo_square.svg',
                          semanticsLabel: 'TMDB logo',
                        ),
                      ),
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.onInverseSurface,
                    // TODO inverter as dependecias e colocar como parametro o DeviceScreenInfoUtils para determinar o width
                    minWidth: navigationRailIconSize,
                    selectedIndex: _tabselected,
                    labelType: NavigationRailLabelType.all,
                    onDestinationSelected: (index) {
                      setState(() {
                        _tabselected = index;
                      });
                    },
                    destinations: destinationsRail,
                  )
                : Container(),
            Expanded(
              child: AnimatedSwitcher(
                /*duration: const Duration(milliseconds: 500),*/
                duration: kThemeAnimationDuration,
                child: pages[_tabselected],
              ),
            ),
          ],
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width <
                DeviceScreenInfoUtils.large
            ? NavigationBarTheme(
                data: NavigationBarThemeData(
                  backgroundColor:
                      Theme.of(context).colorScheme.onInverseSurface,
                ),
                child: NavigationBar(
                  selectedIndex: _tabselected,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  animationDuration: const Duration(seconds: 1),
                  onDestinationSelected: (index) {
                    setState(() {
                      _tabselected = index;
                    });
                  },
                  destinations: destinations,
                ),
              )
            : null,
      ),
    );
  }
}
