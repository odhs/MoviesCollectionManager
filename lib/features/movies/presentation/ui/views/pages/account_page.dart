import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  static const routeName = '/accountPage';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.account),
        ),
        body: ListView(
            padding: const EdgeInsets.all(4.0),
            shrinkWrap: false,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 1.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/avatar.jpg'),
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.username,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      ListTile(
                          leading: const Icon(Icons.rate_review_outlined),
                          title: Text(
                              AppLocalizations.of(context)!.numberOfComments),
                          onTap: () {}),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 1.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Profile",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Premium'),
                        subtitle:
                            Text(AppLocalizations.of(context)!.accountType),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('email@example.com'),
                        subtitle: Text(AppLocalizations.of(context)!.email),
                        onTap: () {
                          // EditUser()
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }
}
