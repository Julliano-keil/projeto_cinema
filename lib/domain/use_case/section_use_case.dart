import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/infrastructure/data_store/interface/section_interface_repository.dart';
import '../interface/section_interface_use_case.dart';

SectionUseCase newSectionUseCase(
    SectionRepository repository,
    ) {
  return _SectionUseCase(repository);
}

class _SectionUseCase implements SectionUseCase {
  _SectionUseCase(this._repository);

  final SectionRepository _repository;

  @override
  Future<List<Room>> getRoomSelection() => _repository.getRoomSelection();

}