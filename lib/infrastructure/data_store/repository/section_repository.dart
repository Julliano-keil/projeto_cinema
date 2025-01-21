import '../interface/section_interface_repository.dart';
import 'data_base/movie_data_base.dart';

SectionRepository newSectionRepository(
    MovieDataBase movieDataBase,
    ) {
  return _SectionRepository(movieDataBase);
}

class _SectionRepository implements SectionRepository {
  _SectionRepository(this._movieData);

  final MovieDataBase _movieData;

}