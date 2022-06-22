import 'package:flutter/material.dart';
// TODO temporário para teste
class FixedTopBar extends StatelessWidget with PreferredSizeWidget {
  const FixedTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(kToolbarHeight)),
          color: Theme.of(context).colorScheme.onInverseSurface,
          /*boxShadow: [
              BoxShadow(
                  color: Theme.of(context).primaryColor,
                  offset: const Offset(0, -5),
                  blurRadius: 32.0)
            ]*/
        ),
        height: kToolbarHeight - 12,
        padding: const EdgeInsets.all(0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              width: 3.0,
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Search in Collections",
                    overflow: TextOverflow.fade,
                  ),
                  /*
                  Text(
                    "Patches Manager",
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.fade,
                  )*/
                ],
              ),
            ),
            const SizedBox(
              width: 2.0,
            ),
            IconButton(icon: const Icon(Icons.filter_alt), onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // TODO receber por parametro nomeado a funcao
                //Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kMinInteractiveDimension);
}


