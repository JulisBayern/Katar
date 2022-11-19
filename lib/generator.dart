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
      lazyValues = substitutors.map((key, value) => MapEntry(key, value()));
      yield substitute(event);
      await Future.delayed(const Duration(seconds: 1));
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
  static List<int> taken = [];

  GeneratorPool(this.generators);

  TickerEventGenerator getGenerator(Random random) {
    var id = random.nextInt(generators.length);
    if (taken.contains(id)) return getGenerator(random);
    taken.add(id);
    return generators[id];
  }

  Stream<TickerEvent> source() async* {
    taken = [];
    var random = Random();
    int time = 1;
    var sa = 0;
    var sb = 0;
    while (time < 90) {
      var gen = getGenerator(random);
      var readLen = 0;
      yield* gen.source().mapAsync((event) async {
        await Future.delayed(Duration(milliseconds: readLen));
        time += random.nextInt(9) + 1;
        readLen = getDurationForTextLength(event.title + (event.description??""));
        if (event.scoreChange == 1) sa++;
        else if (event.scoreChange == -1) sb++;
        return event.copyWith(time: time, score: "$sa:$sb");
      });
      await Future.delayed(Duration(milliseconds: readLen));
    }
  }

}

extension on Stream<TickerEvent> {
  Stream<T> mapAsync<T>(Future<T> Function(TickerEvent) fun) async* {
    var events = await toList();
    for (var event in events) {
      var result = await fun(event);
      yield result;
    }
  }

}
/// Gets the recommended visibility time for a popup with the text [text] in ms.
int getDurationForTextLength(String text) => max(100 + ((text.length / 42) * 1000).toInt(), 750);