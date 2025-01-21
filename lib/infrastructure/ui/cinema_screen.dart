import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projeto_cinema/infrastructure/ui/login.dart';

class CinemaScreen extends StatelessWidget {
  const CinemaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Celecione o cinema mais proximo de voce ou um de sua preferencia',
                      maxLines: 4,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: _ListCinema()),
          ],
        ).animate1());
  }
}

class _ListCinema extends StatelessWidget {
  const _ListCinema({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ItemCinema(
                  labelName: 'Shopping Park Europeu - cinema',
                  location: ' Rodovia Paul Fritz Kuehnrich, 1600',
                  status: 'Das 8:30 as 22:00',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _ItemCinema(
                  labelName: 'Neumarkt Shopping - cinema',
                  location: ' R. 7 de Setembro, 1213 - Centro,',
                  status: 'Das 8:30 as 22:00',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _ItemCinema(
                  labelName: 'Norte Shopping - cinema',
                  location: 'Rodovia, BR-470, 3000 - Salto Norte,',
                  status: 'Das 8:30 as 22:00',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _ItemCinema(
                  labelName: 'Nort shopping',
                  location: 'Itopava central',
                  status: 'Das 8:30 as 22:00',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemCinema extends StatelessWidget {
  const _ItemCinema({
    super.key,
    required this.labelName,
    required this.location,
    required this.status,
  });

  final String labelName;
  final String location;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    'assets_app/movie.png',
                    color: Colors.white,
                    width: 200,
                    height: 200,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 4.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _LabelItem(
                          label: 'Nome',
                          description: labelName,
                        ),
                        _LabelItem(
                          label: 'Localizaçao',
                          description: location,
                        ),
                        _LabelItem(
                          label: 'Horario de atendimento',
                          description: status,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'movie');
                        return;
                      },
                      child: Container(
                        height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                        ),
                        child: const Center(
                          child: Text(
                            'Ver filmes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ).animate1(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _LabelItem extends StatelessWidget {
  const _LabelItem({
    super.key,
    required this.label,
    required this.description,
  });

  final String label;

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 4,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(
            description,
            maxLines: 4,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ),
    );
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
