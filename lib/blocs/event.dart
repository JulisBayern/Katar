import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katar/generator.dart';
import 'package:katar/models/event.dart';

class EventCubit extends Cubit<List<TickerEvent>> {

  EventCubit() : super([]);

  GeneratorPool pool = GeneratorPool([
    TickerEventGenerator([TickerEvent(type: TickerEventType.yellowCard, title: "Yellow", description: "Gibt ne gelbe Kart!", explainId: "te")]),
    TickerEventGenerator([TickerEvent(type: TickerEventType.redCard, title: "Red", description: "DU SIMMULANT!")]),
    TickerEventGenerator([TickerEvent(type: TickerEventType.goal, title: "Katar Tor", scoreChange: 1, explainId: "da")]),
    TickerEventGenerator([TickerEvent(type: TickerEventType.goal, title: "UN Tor", scoreChange: -1)]),
    TickerEventGenerator([TickerEvent(type: TickerEventType.event, title: "Runner", description: "Jemand läuft auf das Spielfeld"), TickerEvent(type: TickerEventType.gameEvent, title: "Runner2", description: "Unterbrechung: Es werden Waffen eingesetzt.")])
  ]);


  void start() async {
    var list = <TickerEvent>[];
    list.add(TickerEvent(type: TickerEventType.kickoff, title: "Das Spiel startet.", time: 0));
    emit(list);
    print("-");
    await Future.delayed(const Duration(seconds: 1));
    await pool.source().forEach((element) {
      list.add(element);
      emit(list.toList()); // toList to force rebuild
      print("-");
    });
    await Future.delayed(const Duration(seconds: 1));
    list.add(TickerEvent(type: TickerEventType.end, title: "Das Spiel endet.", time: list.last.time));
    emit(list.toList());
    print("-");
  }

}

extension EventListExtensions on List<TickerEvent> {

  int get goalsA => where((element) => element.scoreChange == 1).toList().length;
  int get goalsB => where((element) => element.scoreChange == -1).toList().length;

}