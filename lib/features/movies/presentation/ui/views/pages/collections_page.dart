import 'package:flutter/material.dart';

import 'settings_view.dart';
import '/features/movies/presentation/ui/components/float_appbar.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  // TODO mudar variávies para settings view e incluir nos serviços
  bool _pinned = false;
  bool _snap = true;
  bool _floating = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            floatAppBar(
              context,
              floating: _floating,
              actionsIcons: [
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
            SliverToBoxAdapter(
              child: toolBarOrder(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return SizedBox(
                    height: 100.0,
                    child: Center(
                      child: Text('$index', textScaleFactor: 5),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO mudar para Settings View
  BottomAppBar settingsBottomNavigationBar() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: OverflowBar(
          overflowAlignment: OverflowBarAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('pinned'),
                Switch(
                  onChanged: (bool val) {
                    setState(() {
                      _pinned = val;
                    });
                  },
                  value: _pinned,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('snap'),
                Switch(
                  onChanged: (bool val) {
                    setState(() {
                      _snap = val;
                      // Snapping only applies when the app bar is floating.
                      _floating = _floating || _snap;
                    });
                  },
                  value: _snap,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('floating'),
                Switch(
                  onChanged: (bool val) {
                    setState(() {
                      _floating = val;
                      _snap = _snap && _floating;
                    });
                  },
                  value: _floating,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // TODO mover para widgets
  Widget toolBarOrder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Collections"),
              Text("24"),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.star_border_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.filter_list_rounded),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }
}
