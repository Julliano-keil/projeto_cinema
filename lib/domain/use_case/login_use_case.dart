import 'package:projeto_cinema/domain/entities/user.dart';

import '../../infrastructure/data_store/interface/login_interface_repository.dart';
import '../interface/login_interface_use_case.dart';

///Interface to deal with the benefits
LoginInterfaceUseCase newLoginInterfaceUseCase(
  LoginInterfaceRepository repository,
) {
  return _LoginInterfaceUseCase(repository);
}

class _LoginInterfaceUseCase implements LoginInterfaceUseCase {
  _LoginInterfaceUseCase(this._repository);

  final LoginInterfaceRepository _repository;

  @override
  Future<void> registerUser(UserAccount userAccount) =>
      _repository.registerUser(userAccount);

  @override
  Future<UserAccount?> getUser(UserAccount userAccount) =>
      _repository.getUser(userAccount);
}
