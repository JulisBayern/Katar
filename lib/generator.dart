import 'dart:math';

import 'models/event.dart';

class TickerEventGenerator {

  List<TickerEvent> tickerEvents;
  Map<String, String Function()> substitutors;

  late Map<String, String> lazyValues;

  TickerEventGenerator(this.tickerEvents, [this.substitutors = const {}]) {
    lazyValues = substitutors.map((key, value) => MapEntry(key, value()));
  }

  Stream<TickerEvent> source() async* {
    for (var event in tickerEvents) {
      yield substitute(event);
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  TickerEvent substitute(TickerEvent event) => event.copyWith(
    title: performSubstitution(event.title),
    description: event.description == null ? null : performSubstitution(event.description??""),
    revision: event.revision == null ? null : performSubstitution(event.revision??""),
  );

  String performSubstitution(String source) {
    var buffer = source;
    for (var pair in lazyValues.entries) {
     buffer = buffer.replaceAll("%${pair.key}%", pair.value);
    }
    return buffer;
  }

}

class GeneratorPool {

  List<TickerEventGenerator> generators;

  GeneratorPool(this.generators);

  TickerEventGenerator getGenerator(Random random) {
    return generators[random.nextInt(generators.length)];
  }

  Stream<TickerEvent> source() async* {
    var random = Random();
    int time = 1;
    var sa = 0;
    var sb = 0;
    while (time < 90) {
      var gen = getGenerator(random);
      yield* gen.source().map((event) {
        time += random.nextInt(9) + 1;
        if (event.scoreChange == 1) sa++;
        else if (event.scoreChange == -1) sb++;
        return event.copyWith(time: time, score: "$sa:$sb");
      });
    }
  }

}