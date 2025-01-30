import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_cinema/infrastructure/ui/my_tickets.dart';
import 'package:projeto_cinema/infrastructure/ui/state/register_section_state.dart';
import 'package:projeto_cinema/infrastructure/util/app_log.dart';
import 'package:projeto_cinema/infrastructure/util/modal_defalt.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/movie.dart';
import '../util/snack_bar.dart';
import '../util/text_form.dart';
import 'movie_screen.dart';

class RegisterSection extends StatelessWidget {
  const RegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as DetailArguments;

    final movie = arguments.movie;
    return ChangeNotifierProvider(
      create: (context) => RegisterSectionState(
        movie: movie,
        sectionUseCase: Provider.of(context, listen: false),
      ),
      child: Consumer<RegisterSectionState>(
        builder: (_, value, __) {
          return Scaffold(
            backgroundColor: Colors.black,
            floatingActionButton: FloatingActionButton.extended(
              label: const Text(
                'Cadastrar sessão',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.deepPurple,
              onPressed: () {
                modalDefault(
                  context: context,
                  maxHeight: 1000.0,
                  widget: ChangeNotifierProvider.value(
                    value: value,
                    child: const _ModalRegisterSection(),
                  ),
                );
              },
            ),
            appBar: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: const Text(
                'Visualizar sessões',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: _Body(
              movie: movie,
            ),
          );
        },
      ),
    );
  }
}

class _ModalRegisterSection extends StatelessWidget {
  const _ModalRegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegisterSectionState>(context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: state.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormFieldDefault(
                controller: state.controllerDate,
                label: 'Dia de cartaz',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormFieldDefault(
                controller: state.controllerHours,
                label: 'Horario',
                textInputFormatter: [MaskTextInputFormatter(mask: '##:## h')],
                keyboardType: TextInputType.number,
                validator: (text) {
                  if (text != null && text.trim().isEmpty) {
                    return 'O campo nao pode estar vazio';
                  }
                  return null;
                },
              ),
            ),
            CategorySelector(
              idCategory: state.idRoom,
              categories: state.listRoomSelect,
              onSelectedCategories: (item) {
                state.idRoom = item;
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

                  if (state.idRoom == null) {
                    FocusScope.of(context).unfocus();
                    return snackBarDefault(
                      context: context,
                      severity: SnackBarSeverity.warning,
                      message: 'Escolha uma sala',
                    );
                  }

                  await state.insertSection();

                  if (context.mounted) {
                    snackBarDefault(
                      context: context,
                      severity: SnackBarSeverity.success,
                      message: 'Sessão cadastrada com sucesso',
                    );

                    Navigator.pop(context);
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

class _Body extends StatelessWidget {
  const _Body({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegisterSectionState>(context);

    var validate = (state.listRoom.any(
      (element) => element.sections!.isNotEmpty,
    ));

    return Column(
      children: [
        _InfoMovie(
          movie: movie,
        ),
        if (state.listDateFilter.isNotEmpty) const _InsertSection(),

        if (!validate) const _PlaceListEmpty(),

        if (validate)...[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                itemCount: state.listRoom.length,
                itemBuilder: (context, index) {
                  final room = state.listRoom[index];

                  if (room.sections?.isNotEmpty ?? false) {
                    return _CardSection(
                      room: room,
                    ).animate2();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          )
        ]

        //const _InsertSection()
      ],
    );
  }
}

class _PlaceListEmpty extends StatelessWidget {
  const _PlaceListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 120.0,
            ),
            child: Lottie.asset(
              'assets_app/lottie_animation/animation_01.json',
              repeat: true,
              addRepaintBoundary: true,
            ),
          ),
        ),
        const Text(
          'Nenhuma sessão cadastrada',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        )
      ],
    );
  }
}

class _InfoMovie extends StatelessWidget {
  const _InfoMovie({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 145,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: Colors.deepPurple,
                  ),
                ),
                child: Image.asset(
                  fit: BoxFit.fill,
                  'assets_app/place_image.png',
                ),
              ),
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
          SizedBox(
            width: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Descrição:',
                    maxLines: 3,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    movie.description ?? '',
                    maxLines: 3,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Categoria:',
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 4.0),
                        child: Text(
                          movie.labelType ?? '',
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Data de lançamento:',
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    movie.date ?? '',
                    maxLines: 3,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _InsertSection extends StatelessWidget {
  const _InsertSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegisterSectionState>(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white10,
                ),
                child: SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemCount: state.listDateFilter.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final itemDate = state.listDateFilter[index];

                      return _ItemFilterDate(
                        dateFilter: itemDate,
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _CardSection extends StatelessWidget {
  const _CardSection({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegisterSectionState>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.movie_filter_outlined,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.label ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        room.local ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  for (final item in room.sections ?? <SectionEntity>[])
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(
                          'seat_selection',
                              arguments: DetailArguments(
                                movie: state.movie,
                                section: item,
                              )
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 4,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.purple),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 12.0,
                            ),
                            child: Text(
                              item.hoursFormat ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ItemFilterDate extends StatelessWidget {
  const _ItemFilterDate({
    super.key,
    required this.dateFilter,
  });

  final DateTime dateFilter;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RegisterSectionState>(context);

    var local = Intl.defaultLocale = 'pt_BR';

    final weekDay = DateFormat('EEE', local).format(dateFilter);

    final validateColor = state.selectDate == dateFilter;

    return InkWell(
      onTap: () {
        state.selectDate = dateFilter;
        state.setDateFilter(dateFilter);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekDay,
              style: TextStyle(color:validateColor ?  Colors.purpleAccent :Colors.purple , fontSize: 24),
            ),
            Text(
              DateFormat('dd/MM').format(dateFilter),
              style:  TextStyle(
                color: validateColor ?  Colors.purpleAccent :Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}
