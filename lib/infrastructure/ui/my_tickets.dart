import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/domain/use_case/movie_use_case.dart';
import 'package:projeto_cinema/infrastructure/ui/state/my_tickets_state.dart';
import 'package:provider/provider.dart';

class MyTickets extends StatelessWidget {
  const MyTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyTicketsState>(
      create: (context) => MyTicketsState(
        movieUseCase: Provider.of(context,listen: false),
      ),
      child: Consumer<MyTicketsState>(
        builder: (_,state,__) {
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
        }
      ),
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

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.black,
          context: context,
          builder: (context) {
            return ChangeNotifierProvider.value(
              value: state,
              child: const ModalReimbursement(),
            );
          },
        );

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(8)

          ),

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
                    'assetsapp/movie.png',
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
                    Text(item.movieName ??'',
                    style: const TextStyle(
                      color: Colors.white
                    ),
                    ),

                    Text('Horario: ${item.hours}',
                      style: const TextStyle(
                          color: Colors.white
                      ),
                    ),
                Text('local do acento: ${item.seat}',
                  style: const TextStyle(
                      color: Colors.white
                  ),),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0,top: 8),
                    child: Text('R\$ ${item.price}',
                      style: const TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ModalReimbursement extends StatelessWidget {
  const ModalReimbursement({super.key});

  @override
  Widget build(BuildContext context) {
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

              ],
            ).animate2(),
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


