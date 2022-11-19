import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katar/constants.dart';
import 'package:katar/generator.dart';
import 'package:katar/models/event.dart';
import 'package:katar/variables/names.dart';

final random = Random();

class EventCubit extends Cubit<List<TickerEvent>> {
  EventCubit() : super([]);

  GeneratorPool pool = GeneratorPool(eventGenerators);

  void start() async {
    var list = <TickerEvent>[];
    list.add(TickerEvent(type: TEType.kickoff, title: "Das Spiel startet.", time: 0));
    emit(list);
    await Future.delayed(const Duration(seconds: 1));
    await pool.source().forEach((element) {
      list.add(element);
      emit(list.toList()); // toList to force rebuild
    });
    await Future.delayed(const Duration(seconds: 1));
    list.add(TickerEvent(type: TEType.end, title: "Das Spiel endet.", time: list.last.time));
    emit(list.toList());
  }
}

extension EventListExtensions on List<TickerEvent> {
  int get goalsA => where((element) => element.scoreChange == 1).toList().length;
  int get goalsB => where((element) => element.scoreChange == -1).toList().length;
}
