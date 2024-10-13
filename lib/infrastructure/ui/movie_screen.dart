import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_cinema/infrastructure/ui/util/text_form.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            showModalBottomSheet(
              context: context, builder: (context) {
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
            },);
          }, icon:const Icon(Icons.movie_creation_outlined,
          color: Colors.white,
          ))
        ],
        title: const Text('Filmes',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
         return Container();
          },)
        ],
      ),
    );
  }
}


class _ItemMovieCategory extends StatelessWidget {
  const _ItemMovieCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

