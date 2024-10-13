import 'package:projeto_cinema/domain/entities/user.dart';

abstract class LoginInterfaceUseCase{

  /// register user
  Future<void> registerUser(UserAccount userAccount);


  /// get user
  Future<UserAccount?> getUser(UserAccount userAccount);


}

