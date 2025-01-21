import 'package:flutter/material.dart';
import 'package:projeto_cinema/infrastructure/ui/my_tickets.dart';
import 'package:projeto_cinema/infrastructure/ui/state/seat_selection_state.dart';
import 'package:projeto_cinema/infrastructure/util/snack_bar.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/movie.dart';

class SeatSeScreen extends StatelessWidget {
  const SeatSeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as DetailArguments;

    final movie = arguments.movie;
    final hoursMovie = arguments.hours;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Seleção de acento',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _SelectSeat(
        movie: movie,
        hoursMovie: hoursMovie,
      ),
    ).animate1();
  }
}

class _SelectSeat extends StatelessWidget {
  const _SelectSeat({
    super.key,
    required this.movie,
    required this.hoursMovie,
  });

  final Movie movie;
  final String hoursMovie;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SeatSelectionState>(
      create: (context) => SeatSelectionState(
          movieUseCase: Provider.of(context, listen: false),
          hours: hoursMovie,
          movie: movie),
      child: Column(
        children: [
          _InfoMovie(
            hoursMovie: hoursMovie,
            movie: movie,
          ),
          Column(
            children: [
              Center(
                child: Text(
                  'Selecionar acento : $hoursMovie',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 400,
                child: _SeatsItemScreen(
                  movie: movie,
                ).animate1(),
              ),
              _ScreenMovie(),
              const _InfoColorsSelection(),
              const _SelectPrice()
            ],
          ),
        ],
      ),
    );
  }
}

class _SelectPrice extends StatelessWidget {
  const _SelectPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SeatSelectionState>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: state.seat == null
                  ? () {
                      snackBarDefault(
                        context: context,
                        severity: SnackBarSeverity.warning,
                        message: 'Selecione um acento',
                      );
                    }
                  : () async {
                      showModalBottomSheet(
                        backgroundColor: Colors.black,
                        context: context,
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                            value: state,
                            child: const _ModalPrice(),
                          );
                        },
                      );
                    },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: state.seat != null ? Colors.red : Colors.grey,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
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
          )
        ],
      ),
    );
  }
}

class _ModalPrice extends StatelessWidget {
  const _ModalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SeatSelectionState>(context);
    final item = state.selectPriceMovie;
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
                    'Selecionar Preços',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    itemCount: state.selectPriceList.length,
                    itemBuilder: (context, typeIndex) {
                      final item = state.selectPriceList[typeIndex];

                      return _ItemSelectPrice(
                        type: item.type ?? '',
                        price: item.price ?? 0.0,
                        index: typeIndex,
                      );
                    },
                  ),
                ),
                if (state.selectPriceMovie != null)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 8.0, bottom: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Finalizar pagamento de : R\$ ${item?.price}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: InkWell(
                                      onTap: () async {
                                        final pop = await _showPaymentDialog(
                                          context,
                                          state.selectPriceMovie,
                                          state,
                                        );
                                        if (pop ?? false) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                            'movie',
                                            (Route<dynamic> route) => false,
                                          );
                                        }
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
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              'Finalizar',
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
                          ),
                        )
                      ],
                    ).animate2(),
                  )
              ],
            ).animate2(),
          ),
        )
      ],
    );
  }
}

Future<bool?> _showPaymentDialog(BuildContext context,
    SelectPriceMovie? selectPriceMovie, SeatSelectionState state) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.red, width: 2), // Borda vermelha
        ),
        backgroundColor: Colors.black, // Fundo preto
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Você tem um pagamento pendente",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              "Tipo: ${selectPriceMovie?.type}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              "Total a pagar: ${selectPriceMovie?.price}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              "local de acento: ${selectPriceMovie?.seat}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              "Filme: ${selectPriceMovie?.movieName}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              "Data: ${selectPriceMovie?.hours}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Escaneie para pagar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            if (!(state.isLoad ?? false))
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1024px-QR_code_for_mobile_English_Wikipedia.svg.png',
                // Link para uma imagem QR code de exemplo
                height: 150,
                width: 150,
                color: Colors.white,
              ),
            if ((state.isLoad ?? false))
              const CircularProgressIndicator(
                color: Colors.red,
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () {
                  state.insertTicket();

                  snackBarDefault(
                      context: context,
                      severity: SnackBarSeverity.success,
                      message: 'Pagamento efetuado com sucesso');

                  Navigator.of(context).pop(true);
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
                      'Pagar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
}

class _ItemSelectPrice extends StatelessWidget {
  const _ItemSelectPrice({
    super.key,
    required this.type,
    required this.price,
    required this.index,
  });

  final String type;
  final double price;
  final int index;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SeatSelectionState>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          state.index = index;
          state.selectPriceMovie = SelectPriceMovie(
            movieId: state.movie.id,
            movie: state.movie,
            price: price,
            type: type,
            seat: state.seat,
            hours: '${state.movie.date} as ${state.hours}',
            movieName: state.movie.title,
          );
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.red,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.confirmation_num_outlined,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            type,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'R\$ $price',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (state.index == index)
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoColorsSelection extends StatelessWidget {
  const _InfoColorsSelection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Legenda',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    color: Colors.red,
                    height: 15,
                    width: 15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'indisponivel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    color: Colors.grey[300],
                    height: 15,
                    width: 15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Disponivel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    color: Colors.blue,
                    height: 15,
                    width: 15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Selecionado',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SeatsItemScreen extends StatelessWidget {
  const _SeatsItemScreen({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final List<String> rows =
        List.generate(10, (index) => String.fromCharCode(65 + index)); // A-J
    final List<String> columns =
        List.generate(10, (index) => (index + 1).toString()); // 1-10

    final List<String> seats = [
      for (var row in rows)
        for (var column in columns) '$row$column',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          childAspectRatio: 1.0,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: seats.length,
        itemBuilder: (context, index) {
          return SeatTile(
            label: seats[index],
            movie: movie,
          );
        },
      ),
    );
  }
}

class SeatTile extends StatelessWidget {
  const SeatTile({super.key, required this.label, required this.movie});

  final String label;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SeatSelectionState>(context);

    bool? isExistSeat = false;
    bool? isSelected = false;

    for (final item in movie.showSeat ?? <String>[]) {
      if (item.trim() == label.trim()) {
        isExistSeat = true;
      }
    }

    if (state.seat != null) {
      if (state.seat == label) {
        isSelected = true;
      }
    }

    var color = (isExistSeat ?? false)
        ? (isSelected ?? false)
            ? Colors.blue
            : Colors.grey[300]
        : Colors.red;

    return InkWell(
      onTap: (isExistSeat ?? false)
          ? () {
              state.seat = label;
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _ScreenMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipPath(
        clipper: CustomTopBottomClipper(),
        child: Container(
          color: Colors.grey,
          width: 350,
          height: 25,
          child: const Center(
            child: Text(
              'Tela',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTopBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height);

    path.lineTo(size.width * 0.15, 0);

    path.lineTo(size.width * 0.85, 0);

    path.lineTo(size.width, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _InfoMovie extends StatelessWidget {
  const _InfoMovie({
    super.key,
    required this.movie,
    required this.hoursMovie,
  });

  final Movie movie;
  final String hoursMovie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 120,
                height: 145,
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
                          'assets_app/movie.png',
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Voce escolheu o filme ${movie.title} para o horario das $hoursMovie',
                    maxLines: 3,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    '\nSelecione os acentos disponiveis para o seu horario abaixo',
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
