import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:split_eth_flutter/router.dart';

import 'repos/local_group_repo.dart';

void main() {
  // TODO shared prefs
  GetIt.I.registerSingleton(LocalGroupRepo());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetIt.I.allReady(),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        return MaterialApp.router(
          routerConfig: router,
        );
      },
    );
  }
}
