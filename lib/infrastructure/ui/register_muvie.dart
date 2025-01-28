import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_cinema/infrastructure/ui/state/movie_state.dart';
import 'package:projeto_cinema/infrastructure/util/text_form.dart';
import 'package:provider/provider.dart';

import '../util/snack_bar.dart';
import 'movie_screen.dart';

class RegisterMovie extends StatelessWidget {
  const RegisterMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieState>(
      create: (context) => MovieState(
        movieUseCase: Provider.of(context, listen: false),
      ),
      child: Consumer<MovieState>(
        builder: (_, state, __) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: const Text(
                'Cadastro de filme',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: const _InsertMovie(),
          );
        },
      ),
    );
  }
}

class _InsertMovie extends StatelessWidget {
  const _InsertMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MovieState>(context);

    return Container(
      color: Colors.black,
      child: Form(
        key: state.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                controller: state.controllerDescription,
                label: 'Descriçao',
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
                controller: state.controllerDate,
                label: 'Data de lançamento',
                textInputFormatter: [
                  MaskTextInputFormatter(mask: '##/##/####')
                ],
                keyboardType: TextInputType.datetime,
                validator: (text) {
                  if (text != null && text.trim().isEmpty) {
                    return 'O campo nao pode estar vazio';
                  }
                  return null;
                },
              ),
            ),
            CategorySelector(
              idCategory: state.idCategory,
              categories: state.listType,
              onSelectedCategories: (item) {
                state.idCategory = item;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 22.0,
              ),
              child: InkWell(
                onTap: () async {
                  if (!state.formKey.currentState!.validate()) {
                    return;
                  }

                  if (state.idCategory == null) {
                    FocusScope.of(context).unfocus();
                    return snackBarDefault(
                      context: context,
                      severity: SnackBarSeverity.warning,
                      message: 'Escolha uma categoria',
                    );
                  }

                  await state.insertMovie();

                  if (context.mounted) {
                    snackBarDefault(
                      context: context,
                      severity: SnackBarSeverity.success,
                      message: 'Filme cadastrado com sucesso',
                    );

                  }
                },
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cadastrar filme',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
