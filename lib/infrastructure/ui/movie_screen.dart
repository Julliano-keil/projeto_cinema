import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/infrastructure/ui/state/movie_state.dart';
import 'package:projeto_cinema/infrastructure/ui/util/text_form.dart';
import 'package:provider/provider.dart';

import '../util/snack_bar.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key, });



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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Colors.black,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormFieldDefault(
                                  controller: TextEditingController(),
                                  label: 'Nome',
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormFieldDefault(
                                  controller: TextEditingController(),
                                  label: 'Categoria',
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
                                  controller: TextEditingController(),
                                  label: 'Data de lançamento',
                                  validator: (text) {
                                    if (text != null && text.trim().isEmpty) {
                                      return 'O campo nao pode estar vazio';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
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

class _ItemType extends StatelessWidget {
  const _ItemType({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MovieState>(context);
    return ListView.builder(
      itemCount: state.listType.length,
      itemBuilder: (context, typeIndex) {
        final type = state.listType[typeIndex];
        final movies = state.listMovie
            .where(
              (element) => element.idType == type.id,
            )
            .toList();

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
                height: 180,
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
                              height: 140,
                              color: Colors.grey[300],
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
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
                                        child: Text(movie.date),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            movie.title,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
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
                      itemCount: movie.showTimes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final time = movie.showTimes[index];

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
