import 'package:flutter/cupertino.dart';
import 'package:projeto_cinema/domain/entities/user.dart';
import 'package:projeto_cinema/infrastructure/util/app_log.dart';

import '../../../domain/interface/login_interface_use_case.dart';

class LoginState extends ChangeNotifier {
  LoginState({
   required LoginInterfaceUseCase useCase,
  }): _useCase = useCase {
    _init();
  }

   LoginInterfaceUseCase _useCase;

  bool? _isRegister;
  bool _isRegistered = true;

  bool? get isRegister => _isRegister;
  bool? get isRegistered => _isRegistered;

  final key = GlobalKey<FormState>();

  final controllerEmail = TextEditingController();
  final controllerPassWord = TextEditingController();
  final controllerConfirmPassWord = TextEditingController();
  final controllerName = TextEditingController();

  set isRegister(bool? value) {
    _isRegister = value;
    notifyListeners();
  }
  set isRegistered(bool? value) {
    _isRegister = value;
    notifyListeners();
  }

  void _init(){



  }


  void reload() async {
    _isRegistered = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 3));
    _isRegistered = false;
    notifyListeners();
  }



  Future<void> insertUser() async {

    final user = UserAccount(
      email: controllerEmail.text.trim(),
      password: controllerPassWord.text.trim(),
      name: controllerName.text.trim(),
    );

    await _useCase.registerUser(user);

    controllerEmail.clear();
    controllerPassWord.clear();
    controllerName.clear();
    _isRegister = null;




  }

  Future<bool> logUser() async {
    final user = UserAccount(
      email: controllerEmail.text.trim(),
      password: controllerPassWord.text.trim(),
      name: controllerName.text.trim(),
    );

   final isUser = await _useCase.getUser(user);

  if(isUser == null){
    return false;
  }

  return true;
  }
}
