import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/group_factory.dart';
import 'package:split_eth_flutter/router.dart';
import 'package:split_eth_flutter/vendor/web3/config.dart';
import 'package:split_eth_flutter/vendor/web3/service.dart';

import 'repos/local_group_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // local storage
  GetIt.I.registerSingleton(await SharedPreferences.getInstance());
  GetIt.I.registerLazySingleton(() => LocalGroupRepo());

  // web3 config
  GetIt.I.registerSingletonAsync(() async {
    final jsonStr = await rootBundle.loadString('lib/contracts/config.json');
    return Config.fromJson(jsonDecode(jsonStr));
  });

  // smart contracts
  GetIt.I.registerSingletonAsync(
    () async => GroupFactoryContract.init("0x50665e1d7A94891034506C2D51b409945a37C5E4", Web3Service().ethClient),
  );

  // GetIt.I.get<LocalGroupRepo>().removeAllGroups();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        return MaterialApp.router(
          routerConfig: createRouterConfig(),
        );
      },
    );
  }

  Future<void> _init() async {
    await GetIt.I.allReady();
    await Web3Service().init(GetIt.I.get<Config>());
  }
}
