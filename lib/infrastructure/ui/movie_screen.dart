import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/infrastructure/ui/state/login_state.dart';
import 'package:projeto_cinema/infrastructure/ui/state/movie_state.dart';
import 'package:projeto_cinema/infrastructure/ui/util/text_form.dart';
import 'package:projeto_cinema/infrastructure/util/snack_bar.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<MovieState>(
      create: (context) =>
          MovieState(movieUseCase: Provider.of(context, listen: false)),
      child: Consumer<MovieState>(builder: (_, state, __) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await Navigator.pushNamed(
                    context,
                    'my_tickets',
                  );

                  await state.getListMovie();
                  await state.getListType();
                },
                icon: const Icon(
                  Icons.confirmation_num_outlined,
                  color: Colors.white,
                ),
              ),
              if (state.isAdm ?? false)
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                            value: state,
                            builder: (context, child) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: const _InsertMovie(),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.movie_creation_outlined,
                      color: Colors.white,
                    ))
            ],
            title: const Text(
              'Filmes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: const _ItemType(),
        );
      }),
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

                  await state.getListMovie();

                  if (context.mounted) {
                    snackBarDefault(
                      context: context,
                      severity: SnackBarSeverity.success,
                      message: 'Filme cadastrado com sucesso',
                    );

                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.red,
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

class _ItemType extends StatelessWidget {
  const _ItemType({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MovieState>(context);

    if (state.listMovie.isEmpty) {
      return const Center(
        child: Text(
          'Sem filmes para mostrar',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return ListView.builder(
      itemCount: state.listType.length,
      itemBuilder: (context, typeIndex) {
        final type = state.listType[typeIndex];
        final movies = state.listMovie
            .where(
              (element) => element.idType == type.id,
            )
            .toList();
        if (movies.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    type.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, movieIndex) {
                      final movie = movies[movieIndex];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.black87,
                                  context: context,
                                  builder: (context) {
                                    return ChangeNotifierProvider.value(
                                      value: state,
                                      child: _ModalHours(
                                        movie: movie,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 120,
                                height: 145,
                                color: Colors.grey[300],
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          height: 100,
                                          width: 80,
                                          'assetsapp/movie.png',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(movie.date ?? ''),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 110,
                              child: Text(
                                movie.title ?? '',
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}

class _ModalHours extends StatelessWidget {
  const _ModalHours({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MovieState>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8.0),
                border: const Border(
                  top: BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: Text(
                          'Horarios disponiveis',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      'Descrição: ${movie.description}',
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      top: 16,
                    ),
                    child: Text(
                      'Selecione um Horario Abaixo',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 54,
                    child: ListView.builder(
                      itemCount: movie.showTimes?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final time = movie.showTimes?[index];

                        return InkWell(
                          onTap: () {
                            state.hours = time;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 110,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: state.hours == time
                                      ? Colors.white
                                      : Colors.red,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$time horas',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: InkWell(
                              onTap: () async {
                                Navigator.pushNamed(
                                  context,
                                  'seat_selection',
                                  arguments: DetailArguments(
                                    movie: movie,
                                    hours: state.hours ?? '',
                                  ),
                                );
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
                                child: const Center(
                                  child: Text(
                                    'Selecionar',
                                    style: TextStyle(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySelector<T> extends StatefulWidget {
  final List<T> categories;
  final Function(int) onSelectedCategories;

  final int? idCategory;

  const CategorySelector(
      {super.key,
      required this.categories,
      required this.onSelectedCategories,
      this.idCategory});

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int? _selectedCategories;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.black),
      ),
      onPressed: () => _showCategorySelector(context),
      child: Text(
        widget.idCategory == null ? "Selecionar Categorias" : 'Mudar categoria',
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showCategorySelector(BuildContext context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
      backgroundColor: Colors.black,
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Selecione as Categorias',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.categories.length,
                      itemBuilder: (context, index) {
                        final category = widget.categories[index];
                        final isSelected = _selectedCategories == category.id;
                        return CheckboxListTile(
                          title: Text(
                            category.label,
                            style: const TextStyle(color: Colors.white),
                          ),
                          value: isSelected,
                          onChanged: (bool? selected) {
                            setState(() {
                              if (selected == true) {
                                _selectedCategories = category.id;
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 22.0,
                    ),
                    child: InkWell(
                      onTap: () async {
                        widget.onSelectedCategories(_selectedCategories ?? 0);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Confirmar',
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
            );
          },
        );
      },
    );
  }
}
