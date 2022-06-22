import 'package:flutter/material.dart';

// TODO temporário para teste
Widget fixedAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(56.0),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: AppBar(
        title: GestureDetector(
          onTap: () {},
          child: const Text("Search in Collections",
              style: TextStyle(fontSize: 16)),
        ),

        /*title: TextField(
                cursorHeight: 20,
                decoration: const InputDecoration(
                  hintText: 'Search in Collections',
                  border: InputBorder.none,
                ),
                onTap: () {
                  //showSearch(context: context, delegate: Datasearch());
                },
              ),*/
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(48),
              bottomRight: Radius.circular(48),
              topRight: Radius.circular(48),
              topLeft: Radius.circular(48)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              // TODO receber por parametro
              //Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
    ),
  );
}
