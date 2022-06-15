import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return SafeArea(
      child: Scaffold(
        drawer: Container(),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: pages[_tabselected],
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          child: NavigationBar(
            selectedIndex: _tabselected,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            animationDuration: const Duration(seconds: 2),
            onDestinationSelected: (index) {
              setState(() {
                _tabselected = index;
              });
            },
            destinations: [
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
            ],
          ),
        ),
      ),
    );
  }
}
