import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:projeto_cinema/domain/interface/movie_interface_use_case.dart';
import 'package:projeto_cinema/infrastructure/util/app_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/sharedPreferences_keys.dart';

class MovieState extends ChangeNotifier {
  MovieState({required MovieUseCase movieUseCase})
      : _movieUseCase = movieUseCase {
    _init();
  }

  final MovieUseCase _movieUseCase;

  final _controllerName = TextEditingController();
  final _controllerDate = TextEditingController();
  final _controllerDescription = TextEditingController();

  final formKey = GlobalKey<FormState>();

  TextEditingController get controllerName => _controllerName;

  TextEditingController get controllerDate => _controllerDate;

  TextEditingController get controllerDescription => _controllerDescription;
  final _listMovie = <Movie>[];
  final _listType = <TypeMovie>[];

  bool? isAdm = false;

  List<Movie> get listMovie => _listMovie;

  List<TypeMovie> get listType => _listType;

  int? _idCategory;

  String? _hours;

  int? get idCategory => _idCategory;

  Future<bool?> get _isAdm async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getBool(SharedPreferencesKeys.isAdm);
  }

  String? get hours => _hours;

  set hours(String? value) {
    _hours = value;
    notifyListeners();
  }

  set idCategory(int? value) {
    _idCategory = value;
    notifyListeners();
  }

  Future<void> _init() async {
    isAdm = (await _isAdm) ?? false;
    await getListMovie();
    await getListType();
  }

  Future<void> getListType() async {
    final list = await _movieUseCase.getTypeMovie();

    _listType
      ..clear()
      ..addAll(list);
    logInfo('ÇÇÇÇ', _listType.length);

    notifyListeners();
  }

  Future<void> getListMovie() async {
    final list = await _movieUseCase.getMovie();

    _listMovie
      ..clear()
      ..addAll(list);
    notifyListeners();
  }

  Future<void> insertMovie() async {
    final movie = Movie(
      idType: _idCategory,
      title: _controllerName.text,
      date: _controllerDate.text,
      description: _controllerDescription.text,
    );

    await _movieUseCase.insertMovie(movie);

    _controllerDate.clear();
    _controllerDescription.clear();
    _controllerName.clear();
    _idCategory = null;

    notifyListeners();
  }
}
