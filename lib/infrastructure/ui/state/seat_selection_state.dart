import 'package:flutter/cupertino.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/interface/movie_interface_use_case.dart';

class SeatSelectionState extends ChangeNotifier {
  SeatSelectionState({
    required MovieUseCase movieUseCase,
    required Movie movie,
    required String hours,
  })  : _movieUseCase = movieUseCase,
        _hours = hours,
        _movie = movie {
    _init();
  }

  final MovieUseCase _movieUseCase;

  final Movie _movie;

  final String _hours;

  bool? _isLoad;

  String? _seat;

  SelectPriceMovie? _selectPriceMovie;
  final _selectPriceList = <SelectPriceMovie>[];

  int? _index;

  int? get index => _index;

  bool? get isLoad => _isLoad;

  List<SelectPriceMovie> get selectPriceList => _selectPriceList;

  SelectPriceMovie? get selectPriceMovie => _selectPriceMovie;

  String? get seat => _seat;

  Movie get movie => _movie;

  String get hours => _hours;

  set seat(String? value) {
    _seat = value;
    notifyListeners();
  }

  set index(int? value) {
    _index = value;
    notifyListeners();
  }

  set selectPriceMovie(SelectPriceMovie? value) {
    _selectPriceMovie = value;
    notifyListeners();
  }

  void _init() {
    _selectPriceList
      ..clear()
      ..addAll([
        SelectPriceMovie(price: 35, type: 'Inteira'),
        SelectPriceMovie(price: 15, type: 'Meia'),
        SelectPriceMovie(price: 15.95, type: '50% de desconto lince tech'),
        SelectPriceMovie(price: 25.55, type: 'Convenio Santo andre'),
      ]);
  }

  Future<void> insertTicket() async {

    _isLoad = true;

    _movieUseCase.insertTicket(selectPriceMovie);

    Future.delayed(const Duration(seconds: 4));

    _isLoad = false;
  }
}
