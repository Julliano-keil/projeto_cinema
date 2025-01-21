import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/infrastructure/ui/state/my_tickets_state.dart';
import 'package:provider/provider.dart';

import '../util/snack_bar.dart';

class MyTickets extends StatelessWidget {
  const MyTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyTicketsState>(
      create: (context) => MyTicketsState(
        movieUseCase: Provider.of(context, listen: false),
      ),
      child: Consumer<MyTicketsState>(builder: (_, state, __) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: const Text(
              'Meus ingreços',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: const ListMyTickets(),
        );
      }),
    );
  }
}

class ListMyTickets extends StatelessWidget {
  const ListMyTickets({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyTicketsState>(context);

    return ListView.builder(
      itemCount: state.listMyTickets.length,
      itemBuilder: (context, index) {
        final item = state.listMyTickets[index];

        return _MyTicketsItem(
          item: item,
        );
      },
    );
  }
}

class _MyTicketsItem extends StatelessWidget {
  const _MyTicketsItem({super.key, required this.item});

  final SelectPriceMovie item;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyTicketsState>(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: (item.reimbursement ?? false)
                ? null
                : () {
                    showModalBottomSheet(
                      backgroundColor: Colors.black,
                      context: context,
                      builder: (context) {
                        return ChangeNotifierProvider.value(
                          value: state,
                          child: ModalReimbursement(
                            item: item,
                          ),
                        );
                      },
                    );
                  },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        height: 80,
                        width: 80,
                        'assets_app/movie.png',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item.movieName ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Horario: ${item.hours}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'local do acento: ${item.seat}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          top: 8,
                        ),
                        child: Text(
                          'R\$ ${item.price}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        if (item.reimbursement ?? false)
          Padding(
            padding: const EdgeInsets.only(
              top: 22.0,
            ),
            child: Transform.rotate(
              angle: pi / -5,
              child: Container(
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Reembolsado',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}

class ModalReimbursement extends StatelessWidget {
  const ModalReimbursement({super.key, required this.item});

  final SelectPriceMovie item;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MyTicketsState>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
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
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Solicitar reenbolso',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 8.0,
                    right: 8.0,
                    bottom: 22.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              height: 80,
                              width: 80,
                              'assets_app/movie.png',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                item.movieName ?? '',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Horario: ${item.hours}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                'local do acento: ${item.seat}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 8),
                              child: Text(
                                'R\$ ${item.price}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 18.0,
                  ),
                  child: InkWell(
                    onTap: () async {
                      snackBarDefault(
                        context: context,
                        severity: SnackBarSeverity.success,
                        message: 'O valor sera retornado em menos de 24 horas',
                      );

                      await state.solicitationReimbursement(item);

                      await state.getMyTickets();

                      Navigator.of(context).pop();
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
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Solicitar reenbolso de R\$${item.price}',
                            style: const TextStyle(
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
        )
      ],
    );
  }
}

extension AnimateWidgetExtensions on Widget {
  Animate animate1() {
    return animate(
      autoPlay: true,
    ).slide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      begin: const Offset(2, 0),
    );
  }

  Animate animate2() {
    return animate(
      autoPlay: true,
    ).slide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      begin: const Offset(0, 1),
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
