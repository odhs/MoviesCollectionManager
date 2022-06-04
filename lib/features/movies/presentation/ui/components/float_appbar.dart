import 'package:flutter/material.dart';

/// Persistent Search Bar / Floating AppBar of Material You Design
///
/// The intent is to use along with Flutter Slivers widgets
Widget floatAppBar(
  BuildContext context, {
  final List<Widget>? actionsIcons,
  bool? pinned,
  bool? snap,
  bool? floating,
}) {
  return SliverAppBar(
    leading: Container(),
    scrolledUnderElevation: 0.0,
    //backgroundColor: Colors.transparent,
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    pinned: pinned ?? false,
    snap: snap ?? true,
    floating: floating ?? true,
    toolbarHeight: 60.0,
    expandedHeight: 56.0,
    flexibleSpace: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: AppBar(
        titleSpacing: 0.0,
        title: GestureDetector(
          onTap: () {},
          child: Text(
            "Search in Collections",
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.5)),
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.onSurface.withAlpha(25),
        shape: const StadiumBorder(),
        actions: actionsIcons,
      ),
    ),
  );
}
