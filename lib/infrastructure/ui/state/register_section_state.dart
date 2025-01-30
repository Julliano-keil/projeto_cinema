import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:projeto_cinema/domain/entities/movie.dart';
import 'package:projeto_cinema/infrastructure/util/app_log.dart';
import 'package:projeto_cinema/infrastructure/util/text_form.dart';

import '../../../domain/interface/section_interface_use_case.dart';

class RegisterSectionState extends ChangeNotifier {
  RegisterSectionState({
    required SectionUseCase sectionUseCase,
    required Movie movie,
  })  : _sectionUseCase = sectionUseCase,
        _movie = movie {
    _init();
  }

  final SectionUseCase _sectionUseCase;

  final _listRoom = <Room>[
    // Room(
    //   id: 1,
    //   label: 'Norte shopping',
    //   local: 'Rod BR-470- setor cinemas',
    //   sections: <SectionEntity>[
    //     SectionEntity(
    //       date: '12:20',
    //     ),
    //     SectionEntity(
    //       date: '14:30',
    //     ),
    //     SectionEntity(
    //       date: '16:35',
    //     ),
    //     SectionEntity(
    //       date: '18:45',
    //     ),
    //   ],
    // ),
    // Room(
    //   id: 2,
    //   label: 'Norte shopping cinema centro',
    //   local: 'Cruzero BR-470- setor cinemas',
    //   sections: <SectionEntity>[
    //     SectionEntity(
    //       date: '18:20',
    //     ),
    //     SectionEntity(
    //       date: '19:30',
    //     ),
    //     SectionEntity(
    //       date: '20:35',
    //     ),
    //     SectionEntity(
    //       date: '22:45',
    //     ),
    //     SectionEntity(
    //       date: '23:45',
    //     ),
    //     SectionEntity(
    //       date: '23:45',
    //     ),
    //     SectionEntity(
    //       date: '23:45',
    //     ),
    //   ],
    // ),
  ];

  final Movie _movie;

  DateTime? _selectDate;

  final _listRoomSelect = <Room>[];

  final _listDateFilter = <DateTime>[];

  final formKey = GlobalKey<FormState>();

  final TextEditingController _controllerDate = TextEditingController();

  final TextEditingController _controllerHours = TextEditingController();

  DateTime? get selectDate => _selectDate;

  int? _idRoom;

  int? get idRoom => _idRoom;

  Movie get movie => _movie;

  TextEditingController get controllerDate => _controllerDate;

  TextEditingController get controllerHours => _controllerHours;

  List<Room> get listRoomSelect => _listRoomSelect;

  List<DateTime> get listDateFilter => _listDateFilter;

  List<Room> get listRoom => _listRoom;

  set selectDate(DateTime? value) {
    _selectDate = value;
    notifyListeners();
  }

  set idRoom(int? value) {
    _idRoom = value;
  }

  void _init() async {
    await getListRoomSelect();
    await getListRoomAndSection();
    await getListDateFilter();
    notifyListeners();
  }

  Future<void> getListRoomSelect() async {
    final list = await _sectionUseCase.getRoomSelection();

    _listRoomSelect
      ..clear()
      ..addAll(list);

    notifyListeners();
  }

  Future<void> setDateFilter(DateTime date) async {
    getListRoomAndSection();
  }

  Future<void> getListRoomAndSection() async {
    final list = await _sectionUseCase.getListRoomAndSection(
      _movie.id ?? 0,
      search: _selectDate,
    );

    _listRoom
      ..clear()
      ..addAll(list);

    notifyListeners();
  }

  Future<void> getListDateFilter() async {
    final list = await _sectionUseCase.getListDateFilter(_movie.id ?? 0);

    _listDateFilter
      ..clear()
      ..addAll(list);

    notifyListeners();
  }

  Future<void> insertSection() async {
    final date = tryParseDate(
        'dd/MM/yyyy HH:mm', '${_controllerDate.text} ${_controllerHours.text}');

    final dateFormat = tryFormatDate('dd/MM/yyyy HH:mm', date);

    await _sectionUseCase.insertSection(SectionEntity(
      date: dateFormat,
      idMovie: _movie.id,
      idRoom: _idRoom,
    ));

    await getListRoomAndSection();
    await getListRoomSelect();
    await getListDateFilter();

    _controllerHours.clear();
    _controllerDate.clear();
    _idRoom = null;

    notifyListeners();
  }
}
