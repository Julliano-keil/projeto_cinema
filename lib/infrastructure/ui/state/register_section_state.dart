import 'package:flutter/cupertino.dart';
import 'package:projeto_cinema/domain/entities/movie.dart';

import '../../../domain/interface/section_interface_use_case.dart';

class RegisterSectionState extends ChangeNotifier {
  RegisterSectionState({
    required SectionUseCase sectionUseCase,
  }) : _sectionUseCase = sectionUseCase {
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

  final _listRoomSelect = <Room>[];

  final _listDateFilter = <DateTime>[
    // DateTime(2025,10,10),
    // DateTime(2025,10,11),
    // DateTime(2025,10,12),
    // DateTime(2025,10,13),
  ];

  final formKey = GlobalKey<FormState>();

  final TextEditingController _controllerDate = TextEditingController();

  int? _idRoom;

  int? get idRoom => _idRoom;

  TextEditingController get controllerDate => _controllerDate;

  List<Room> get listRoomSelect => _listRoomSelect;

  List<DateTime> get listDateFilter => _listDateFilter;

  List<Room> get listRoom => _listRoom;

  set idRoom(int? value) {
    _idRoom = value;
  }

  void _init() async {
    await getListRoomSelect();
  }

  Future<void> getListRoomSelect() async {
    final list = await _sectionUseCase.getRoomSelection();

    _listRoomSelect
      ..clear()
      ..addAll(list);

    notifyListeners();
  }
}
