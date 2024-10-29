import 'package:flutter/foundation.dart';
import 'package:projeto_cinema/domain/interface/movie_interface_use_case.dart';

class MovieState extends ChangeNotifier {
  MovieState({required MovieUseCase movieUseCase})
      : _movieUseCase = movieUseCase;

  final MovieUseCase _movieUseCase;




}
