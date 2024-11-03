import 'package:flutter/material.dart';
import 'package:projeto_cinema/infrastructure/ui/movie_screen.dart';
import 'package:projeto_cinema/infrastructure/ui/state/login_state.dart';
import 'package:projeto_cinema/infrastructure/ui/util/text_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import ' seat_selection_screen.dart';
import '../util/snack_bar.dart';
import 'cinema_screen.dart';

/// log in
class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginScreen(),
        'cinema': (context) => const CinemaScreen(),
        'movie': (context) => const MovieScreen(),
        'seat_selection': (context) => const SeatSeScreen(),
      },
      initialRoute: '/',
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: ChangeNotifierProvider<LoginState>(
        create: (context) => LoginState(
          useCase: Provider.of(context, listen: false),
        ),
        child: Consumer<LoginState>(
          builder: (_, state, __) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 80.0,
                      ),
                      child: Image.network(
                          'https://tecnologiahojeemdia.com.br/wordpress/wp-content/files/tecnologiahojeemdia.com.br/2024/04/tecnologiahojeemdia-2-8-768x512.jpg'),
                    ).animate1()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 700,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(8.0),
                        border: const Border(
                          top: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (state.isRegister != null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () => state.isRegister = null,
                                    icon: const Icon(
                                      Icons.keyboard_return_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    'Voltar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ).animate2(),
                            if (state.isRegister != null) const _FormUser(),
                            if (state.isRegister == null) const _FormAction()
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FormAction extends StatelessWidget {
  const _FormAction({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginState>(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset(
              'assetsapp/movie.png',
              color: Colors.white,
              width: 200,
              height: 200,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      state.isRegister = false;
                    },
                    child: Container(
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      ),
                      child: const Center(
                        child: Text(
                          'Logar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                      onTap: () {
                        state.isRegister = true;
                      },
                      child: Container(
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                        ),
                        child: const Center(
                          child: Text(
                            'Cadastrar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ).animate1()),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _FormUser extends StatelessWidget {
  const _FormUser({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginState>(context);
    return Form(
        key: state.key,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormFieldDefault(
                controller: state.controllerEmail,
                label: 'Email',
                validator: (text) {
                  if (text != null && text.trim().isEmpty) {
                    return 'O campo nao pode estar vazio';
                  }
                  if (!text!.contains('@gmail.com')) {
                    return 'Email invalido';
                  }
                  return null;
                },
              ),
            ),
            if (state.isRegister ?? false)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormFieldDefault(
                  controller: state.controllerName,
                  label: 'Nome',
                  validator: (text) {
                    if (text != null && text.trim().isEmpty) {
                      return 'O campo nao pode estar vazio';
                    }
                    return null;
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormFieldDefault(
                controller: state.controllerPassWord,
                label: 'Senha',
                validator: (text) {
                  if (text != null && text.trim().isEmpty) {
                    return 'O campo nao pode estar vazio';
                  }
                  return null;
                },
              ),
            ),
            if (state.isRegister ?? false)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormFieldDefault(
                  controller: state.controllerConfirmPassWord,
                  label: 'Confirmar Senha',
                  validator: (text) {
                    if (text != null && text.trim().isEmpty) {
                      return 'O campo nao pode estar vazio';
                    }
                    if (state.controllerPassWord.text !=
                        state.controllerConfirmPassWord.text) {
                      return 'As senhas devem ser iguais';
                    }

                    return null;
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: InkWell(
                        onTap: () async {
                          if (!state.key.currentState!.validate()) {
                            return;
                          }

                          if (state.isRegister ?? false) {
                            state.insertUser();
                          } else {
                            final logUser = await state.logUser();

                            if (logUser) {
                              Navigator.pushNamed(context, 'cinema');
                              return;
                            } else {
                              return snackBarDefault(
                                  context: context,
                                  severity: SnackBarSeverity.warning,
                                  message: 'Usuario nao encontrado');
                            }
                          }

                          snackBarDefault(
                              context: context,
                              severity: SnackBarSeverity.success,
                              message: 'Cadastrado com succeso');
                        },
                        child: Container(
                          height: 35,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              state.isRegister == true ? 'Cadastrar' : 'Entrar',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ).animate1());
  }
}

extension on Widget {
  Animate animate1() {
    return animate(
      autoPlay: true,
    ).slide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      begin: const Offset(0, 1),
    );
  }

  Animate animate2() {
    return animate(
      autoPlay: true,
    ).slide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      begin: const Offset(1, 2),
    );
  }

  Animate animate3() {
    return animate(
      autoPlay: true,
    ).slide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      begin: const Offset(1, 2),
    );
  }
}
