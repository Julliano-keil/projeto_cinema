import 'package:flutter/cupertino.dart';

import '../../domain/entities/movie.dart';

class SeatSeScreen extends StatelessWidget {
  const  SeatSeScreen({super.key, this.movie, this.hours});
  final Movie? movie;
  final String? hours;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
