import 'package:flutter/material.dart';
import 'package:projeto_cinema/domain/use_case/login_use_case.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/login_repository.dart';

import 'package:provider/provider.dart';

import 'domain/interface/login_interface_use_case.dart';

import 'infrastructure/data_store/repository/data_base/movie_data_base.dart';
import 'infrastructure/ui/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = MovieDataBase();
  await db.getDatabase();

//  -=-=-=-=-=-=-=-=-=-=-=-= Repository -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=
  final logRepository = newLoginInterfaceRepository(
    db,
  );

//  -=-=-=-=-=-=-=-=-=-=-=-= use case -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=
  final loginInterface = newLoginInterfaceUseCase(
    logRepository,
  );

  runApp(
    MyApp(
      loginInterfaceUseCase: loginInterface,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.loginInterfaceUseCase,
  });

  final LoginInterfaceUseCase loginInterfaceUseCase;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          Provider<LoginInterfaceUseCase>.value(
            value: widget.loginInterfaceUseCase,
          ),
        ],
        builder: (context, child) {
          return const Login();
        },
      ),
    );
  }
}
