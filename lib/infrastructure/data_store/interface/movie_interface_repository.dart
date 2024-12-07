import '../../../domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<TypeMovie>> getTypeMovie();

  Future<List<Movie>> getMovie();

  /// insert Ticket
  Future<void> insertTicket(SelectPriceMovie? selectPriceMovie);

  /// insert Ticket
  Future<List<SelectPriceMovie>> getMyTickets();

  ///  solicitation Reimbursement
  Future<void> solicitationReimbursement(SelectPriceMovie selectPriceMovie);

  Future<void> insertMovie( Movie movie);
}
