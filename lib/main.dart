import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_eth_flutter/repos/remote_group_repo.dart';
import 'package:split_eth_flutter/repos/session_repo.dart';
import 'package:split_eth_flutter/router.dart';
import 'package:split_eth_flutter/vendor/web3/config.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/group_factory_contract.dart';
import 'package:split_eth_flutter/vendor/web3/contracts/session_account_manager.dart';
import 'package:split_eth_flutter/vendor/web3/service.dart';
import 'package:split_eth_flutter/vendor/web3/services/api/api.dart';
import 'package:split_eth_flutter/vendor/web3/services/auth/auth.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import 'repos/local_group_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // local storage
  GetIt.I.registerSingleton(await SharedPreferences.getInstance());
  GetIt.I.registerLazySingleton(() => LocalGroupRepo());
  GetIt.I.registerLazySingleton(() => LocalSessionRepo());

  // web3 config
  final jsonStr = await rootBundle.loadString('lib/assets/config.json');
  Config config = Config.fromJson(jsonDecode(jsonStr));
  GetIt.I.registerSingleton(config);
  GetIt.I.registerSingleton<Web3Service>(Web3Service());
  await GetIt.I.get<Web3Service>().init(config);

  // smart contracts
  GetIt.I.registerSingletonAsync(() async => GroupFactoryContract.init("0x616F422Cf3a9d2b7330Bb833b5C14Da685da8AC1"));
  GetIt.I.registerSingletonAsync(
    () async => SessionAccountManagerContract.init(
        "0x7349b4b271d3592a4a95cc3Bb0063F7B6dd1fe35",
        GetIt.I.get<Web3Service>().ethClient,
        EthereumAddress(hexToBytes("0x9126F8137B6321D7C4dc4c45BAcDF7442221a461"))),
  );

  GetIt.I
      .registerSingleton(AuthService(apiService: APIService(baseURL: 'https://spliteth-accounts.vercel.app/api/v1')));
  GetIt.I.registerLazySingleton(() => RemoteGroupRepo());

  // GetIt.I.get<LocalGroupRepo>().removeAllGroups();

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
          routerConfig: createRouterConfig(),
        );
      },
    );
  }
}
