import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/movie.dart';

class RegisterSection extends StatelessWidget {
  const RegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as DetailArguments;

    final movie = arguments.movie;
    return Scaffold(
      backgroundColor: Colors.black,
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
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoMovie(
          movie: movie,
        ),

       // _PlaceListEmpty(),

        _InsertSection(),

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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
          color: Colors.deepPurple
          ),
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
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const _ItemFilterDate();
                    },
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class _ItemFilterDate extends StatelessWidget {
  const _ItemFilterDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Terça',
            style: TextStyle(color: Colors.purpleAccent, fontSize: 24),
          ),
          Text(
            '23/10',
            style: TextStyle(
              color: Colors.purpleAccent,
            ),
          )
        ],
      ),
    );
  }
}
