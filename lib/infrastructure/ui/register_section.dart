import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';

class RegisterSection extends StatelessWidget {
  const RegisterSection({super.key});

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
          'Cadastro de sessão',
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
      ],
    );
  }
}

class _InfoMovie extends StatelessWidget {
  const _InfoMovie({
    super.key,
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
                    movie.description ?? '',
                    maxLines: 3,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      movie.labelType ?? '',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
