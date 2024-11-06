import 'package:flutter/foundation.dart';
import 'package:projeto_cinema/domain/interface/movie_interface_use_case.dart';
import 'package:projeto_cinema/infrastructure/util/app_log.dart';

import '../../../domain/entities/movie.dart';

class MovieState extends ChangeNotifier {
  MovieState({required MovieUseCase movieUseCase})
      : _movieUseCase = movieUseCase{
    _init();
  }

  final MovieUseCase _movieUseCase;

final _listMovie = <Movie>[];
  final _listType = <TypeMovie>[];

  List<Movie> get listMovie => _listMovie;
  List<TypeMovie> get listType => _listType;

   String? _hours;


  String? get hours => _hours;

  set hours(String? value) {
    _hours = value;
    notifyListeners();
  }

  Future<void> _init()async{
    await getListMovie();
    await getListType();

  }



  Future<void> getListType()async{
    final list = await _movieUseCase.getTypeMovie();
    _listType..clear()..addAll(list);

    notifyListeners();

  }

  Future<void> getListMovie()async{
    final list = await _movieUseCase.getMovie();


    _listMovie..clear()..addAll(list);
    notifyListeners();

  }


}
