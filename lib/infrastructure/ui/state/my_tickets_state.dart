import 'package:flutter/cupertino.dart';
import 'package:projeto_cinema/domain/interface/movie_interface_use_case.dart';

import '../../../domain/entities/movie.dart';

class MyTicketsState extends ChangeNotifier {
  MyTicketsState({
    required MovieUseCase movieUseCase,
  }) : _movieUseCase = movieUseCase {
    _init();
  }

  final MovieUseCase _movieUseCase;

  final _listMyTickets = <SelectPriceMovie>[];

  List<SelectPriceMovie> get listMyTickets => _listMyTickets;

  Future<void> _init() async {
    await getMyTickets();
  }

  Future<void> getMyTickets() async {
    final list = await _movieUseCase.getMyTickets();

    _listMyTickets
      ..clear()
      ..addAll(list);
    notifyListeners();
  }

  Future<void> solicitationReimbursement(
      SelectPriceMovie selectPriceMovie) async {

    _movieUseCase.solicitationReimbursement(selectPriceMovie.copyWith(
      reimbursement: true,
    ));

    notifyListeners();
  }
}
