/// Entity representing a user account with email and password.
class UserAccount {
  /// Creates a new `UserAccount` entity.
  UserAccount({
    required this.email,
    required this.password,
    required this.name,
     this.isAdm,
  });


  /// The user's email (used as primary identifier).
  final String email;

  /// The user's email (used as primary identifier).
  final bool? isAdm;

  /// The user's password.
  final String password;

  /// The user's password.
  final String name;


  /// Creates a new instance of `UserAccount` by copying the existing one
  /// and applying any changes specified in the parameters.
  ///
  /// Useful for immutability when updating certain fields of the entity.
  UserAccount copyWith({
    String? email,
    String? password,
    String? name,
  }) {
    return UserAccount(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name
    );
  }
}
