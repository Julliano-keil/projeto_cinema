import '../../../domain/entities/user.dart';

abstract class LoginInterfaceRepository{


  /// register user
  Future<void> registerUser(UserAccount userAccount);
  /// get user
  Future<UserAccount?> getUser(UserAccount userAccount);

}