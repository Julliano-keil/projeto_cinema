import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:projeto_cinema/domain/interface/section_interface_use_case.dart';
import 'package:projeto_cinema/domain/use_case/login_use_case.dart';
import 'package:projeto_cinema/domain/use_case/section_use_case.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/login_repository.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/movie_repository.dart';
import 'package:projeto_cinema/infrastructure/data_store/repository/section_repository.dart';
import 'package:provider/provider.dart';

import 'domain/interface/login_interface_use_case.dart';

import 'domain/interface/movie_interface_use_case.dart';
import 'domain/use_case/movie_use_case.dart';
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

  final movieRepository = newMovieRepository(
    db,
  );

  final sectionRepository = newSectionRepository(
    db,
  );

//  -=-=-=-=-=-=-=-=-=-=-=-= use case -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=
  final loginInterface = newLoginInterfaceUseCase(
    logRepository,
  );

  final movieUseCase = newMovieUseCase(
    movieRepository,
  );

  final sectionUseCase = newSectionUseCase(
    sectionRepository,
  );

  runApp(
    MyApp(
      loginInterfaceUseCase: loginInterface,
      movieUseCase: movieUseCase,
      sectionUseCase: sectionUseCase,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.loginInterfaceUseCase,
    required this.movieUseCase,
    required this.sectionUseCase,
  });

  final LoginInterfaceUseCase loginInterfaceUseCase;
  final MovieUseCase movieUseCase;
  final SectionUseCase sectionUseCase;

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
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
        Locale.fromSubtags(languageCode: 'en'),

      ],
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          Provider<LoginInterfaceUseCase>.value(
            value: widget.loginInterfaceUseCase,
          ),  Provider<MovieUseCase>.value(
            value: widget.movieUseCase,
          ),Provider<SectionUseCase>.value(
            value: widget.sectionUseCase,
          ),
        ],
        builder: (context, child) {
          return const Login();
        },
      ),
    );
  }
}
