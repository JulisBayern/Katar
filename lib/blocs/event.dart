import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katar/generator.dart';
import 'package:katar/models/event.dart';
import 'package:katar/variables/names.dart';

final random = Random();

class EventCubit extends Cubit<List<TickerEvent>> {
  EventCubit() : super([]);

  GeneratorPool pool = GeneratorPool([
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: -1,
          title: "Fifa wirbt mit Menschenrechten",
          description: "Öffentlichkeitswirksam bekennt sich die Fifa zu der Einhaltung der Menschenrechte und sieht sich selbst auch in Verantwortung.",
          explainId: "fifa-menschenrechte-pr"
      ),
      TickerEvent(
          type: TEType.goal, scoreChange: 1,
          title: "Fifa verbietet Trikotaufdruck für Menschenrechte",
          description: "Gegentor! Die dänische Nationalmannschaft wollte ihr Trainingstrikot mit der Aufschrift \"Human Rights for all\" versehen. Das wollte die Fifa allerdings nicht genehmigen."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.redCard,
          title: "Arbeiter %name% wird die Heimreise untersagt",
          description: "Arbeiter können sich nicht auf Lohnzahlungen verlassen. Teilweise kommt der Lohn viel zu spät, oft wird auch weniger gezahlt als vereinbart.",
          explainId: "kein-lohn")
    ], {"name": () => getIndianName()}),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.yellowCard,
          title: "Arbeiter %name% wartet auf Lohn",
          description: "Einige Arbeitsmigranten aus Nepal berichteten, dass ihnen nach dem Erdbeben im April 2015 die Heimreise verweigert wurde und sie deswegen nicht nach ihren Familien sehen konnten.",
          explainId: "heimreise")
    ], {"name": () => getNepalName()}),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.redCard,
          title: "Brand in Arbeiterunterkunft",
          description: "Die Wohnbedingungen für Arbeiter sind katastrophal. Teilweise leben acht Menschen auf 15 Quadratmetern, 42 Personen teilen sich eine Küche ohne hygienische Standards.",
          explainId: "unterkunft-brand")
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: 1,
          title: "Fans machen Stimmung auf die WM",
          description: "In Katar ziehen Fanparaden durch die Städte, die gute Stimmung wird in sozialen Netzwerken geteilt. Es kommt der Verdacht auf, dass ein großer Teil dieser Fans bezahlt wird. Frauen sucht man bei diesen Paraden vergeblich.",
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
        type: TEType.gameEvent,
        title: "Team Menschenrechte kontert nicht schnell genug",
        description: "Das Team will das Spiel bei einem Einwurf schnell machen. Der zuständige Balljunge ist wegen der Hitze auf der Suche nach Wasser und kann dem Team den Ball nicht geben. Ihm drohen harte Konsequenzen.",
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
        type: TEType.gameEvent,
        title: "Flitzerin rennt über das Feld",
        description: "Eine leicht bekleidete Frau stört das Spiel. Sie wird von der Polizei abgeführt, da sie gegen die strenge Kleiderordnung im Land verstoßen hat.",
        explainId: "female-rights-imaginative"
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.event,
          title: "Zwei Männer im Fanblock küssen sich",
          description: "Aufruhr in der Kurve! Zwei Männer haben sich geküsst. Homosexualität wurde vom WM-Botschafter erst kurz vor Turnierbeginn als Sünde bezeichnet. Die Männer werden sofort aus der Kurve gezogen.",
          explainId: "gay-rights-imaginative"
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.gameEvent,
          title: "Elfmeter? LSVD fordert Reisewarnung",
          description: "Der Lesben- und Schwulenverband Deutschland fordert das Auswärtige Amt auf, eine Reisewarnung für LGTBQ-Personen bei der Reise nach Katar auszusprechen.",
      ),
      TickerEvent(
        type: TEType.gameEvent,
        title: "Kein Elfmeter",
        description: "Das Auswärtige Amt verlässt sich auf eine Sicherheitsgarantie, die Katar ausgesprochen hat.",
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
        type: TEType.goal, scoreChange: 1,
        title: "Kritik prallt am Veranstalter ab",
        description: "Kritik an der WM in Katar wird schlicht als arrogant und  \"rassistisch motiviert\" abgebügelt.",
        explainId: "criticism-is-racist"
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: 1,
          title: "Staatsvertreter besuchen die WM",
          description: "Trotz Menschenrechtsverletzungen und Kritik aus der Bevölkerung reisen Vertreter diverser Staaten zu WM-Spielen"
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: 1,
          title: "Tor Katar Fifa-Präsident spielt Todeszahlen herunter",
          description: "Der Fifa-Präsident, der selbst in Katar lebt, behauptet, dass lediglich drei Tode von Arbeitern direkt auf die WM zurückzuführen seien.",
        explainId: "3-deaths"
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: -1,
          title: "Gaststätten wollen WM nicht zeigen",
          description: "Viele Gaststätteninhaber schließen sich unter #keinkatarinmeinerkneipe zusammen und zeigen die WM nicht."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: 1,
          title: "WM-Stimmung auf dem Weihnachtsmarkt",
          description: "Nach drei Glühwein findet ein Fan sich damit ab, dass \"andere Länder einfach andere Politik machen und wir das akzeptieren müssen\"."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: -1,
          title: "Trikot in Trauerflor",
          description: "Das Trikot der dänischen Mannschaft ist komplett in schwarz gehalten und soll als Trauerflor an die verstorbenen Arbeiter erinnern."
      ),
      TickerEvent(
        type: TEType.event,
        title: "Verkaufsschlager!",
        description: "Das Trikot wird am Tag der Veröffentlichung so oft verkauft wie kein anderes Trikot in der Verbandsgeschichte.",
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
        type: TEType.gameEvent,
        title: "Chance für Menschenrechte",
        description: "Organisationen für Arbeitsrecht dürfen nach Katar reisen.",
      ),
    ]),
    TickerEventGenerator([
      TickerEvent(
        type: TEType.gameEvent,
        title: "Chance für Menschenrechte",
        description: "Fans großer Fußballclubs wollen nicht, dass ihre Vereine mit Katar zusammenarbeiten.",
      ),
      TickerEvent(
        type: TEType.gameEvent,
        title: "Ball geklärt!",
        description: "Uli Hoeneß nennt den Auftritt von Fanvertretern bei der Jahreshauptversammlung des FC Bayern München \"peinlich\"",
      ),
    ]),
    TickerEventGenerator([
      TickerEvent(
        type: TEType.gameEvent,
        title: "Chance für Menschenrechte",
        description: "Verschiedene Mannschaftskapitäne wollen eine #OneLove-Armbinde tragen.",
      ),
    ]),
    TickerEventGenerator([
      TickerEvent(
        type: TEType.gameEvent,
        title: "Chance für Katar",
        description: "Geld regiert die Welt! Die FIFA sieht darüber hinweg, dass der WM-Botschafter Frauen als Süßigkeiten und Homosexualität als geistige Störung bezeichnet. Inwiefern Schmiergeldzahlungen dabei eine Rolle spielen, kann nicht abschließend geklärt werden.",
      ),
    ]),
    TickerEventGenerator([
      TickerEvent(
        type: TEType.gameEvent,
        title: "Die Partie wird unterbrochen",
        description: "Da die Kühlung im Stadion ausgefallen ist, wird es unerträglich heiß auf dem Spielfeld. Das Spiel kann erst weitergehen, wenn die Arbeiter das System repariert haben.",
      ),
      TickerEvent(
        type: TEType.gameEvent,
        title: "Die Partie wird fortgesetzt",
        description: "Den Gastgebern ist das Problem egal.",
      ),
    ]),
    TickerEventGenerator([
      TickerEvent(
        type: TEType.event,
        title: "Probleme auf den Rängen",
        description: "Der Wasservorrat im Stadion ist alle. Die Fans sind dehydriert und werden ungehalten. Da im Stadion auch kein Bier verkauft werden darf, müssen sie die Leistung ihrer Teams nun durstig und nüchtern ertragen.",
      ),
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: 1,
          title: "WM-Boykott aufgegeben",
          description: "Als eine Tippspielrunde beschließt, als Gewinn für den besten Tipper einen neuen Grill auszuloben, entschließen sich zwei der Teilnehmer dafür, das Turnier nun doch nicht zu boykottieren."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.yellowCard,
          title: "Chaos vor dem Stadion",
          description: "Die Infrastruktur rund um das neu gebaute Stadion ist nicht für Massenereignisse wie eine WM ausgelegt. In der U-Bahn-Station drängen sich Menschen eng aneinander."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.redCard,
          title: "Frauenrechte Fehlanzeige!",
          description: "Eine Niederländerin zeigt einen Katari wegen Vergewaltigung an. Er behauptet jedoch, dass der Sex einvernehmlich war. Die Frau wird wegen außerehelichem Sex zu einer Geldstrafe von umgerechnet 750 verurteilt.",
        explainId: "frauenrechte-fail"
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.gameEvent,
          title: "Abseits: Brauerei über Alkoholverbot empört",
          description: "Die Brauerei Budweiser ist ein großer Sponsor der WM. Ursprünglich sollte allein Budweiser-Bier bei der WM verkauft werden, doch Katar verhängt zwei Tage vor WM-Beginn ein Alkoholverbot rund um die Stadien."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.gameEvent,
          title: "Freistoß für die Menschenrechte",
          description: "Eine böse Grätsche in Strafraumnähe wird mit einem Freistoß geahndet."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.yellowCard,
          title: "Taktisches Foul",
          description: "Ein Spieler hält seinen Gegner am Trikot fest, um einen Konter zu unterbinden."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.event,
          title: "Stimmung im Stadion schlecht",
          description: "Da viele Fanclubs die WM boykottieren, ist die Atmosphäre im Stadion eher träge."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.event,
          title: "Behandlungspause",
          description: "Ein Spieler liegt mit einem Krampf am Boden. Das Ärzteteam eilt ihm zu Hilfe."
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: 1,
          title: "Kretschmann und Habeck wollen WM schauen",
          description: "Wirtschaftsminister Habeck und der Ministerpräsident von Baden-Württemberg, Winfried Kretschmann, beide von den Grünen, sind zwar keine Fans der WM, wollen sie aber trotzdem ansehen.",
        explainId: "habeck-kretschmann"
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: 1,
          title: "David Beckham wirbt für WM",
          description: "Der englische Fußballstar tritt als \"Botschafter der Sportnation Katar\" auf und verdient dabei über zehn Millionen Euro im Jahr.",
          explainId: "beckham"
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: -1,
          title: "Ex-Fifa-Präsident bereut Vergabe an Katar",
          description: "Sepp Blatter bezeichnet die Vergabe der WM an Katar im Nachhinein als Irrtum.",
          explainId: "blatter"
      )
    ]),
    TickerEventGenerator([
      TickerEvent(
          type: TEType.goal, scoreChange: 1,
          title: "Arbeiter %name% stirbt und bekommt keinen Lohn mehr",
          description: "Nach einem Hitzschlag bricht der Arbeiter zusammen und ist sofort tot. Menschenrechtsorganisationen fordern einen Entschädigungsfonds für Opfer, doch Katar weigert sich.",
          explainId: "worker-death"
      )
    ], {"name": () => getIndianName()}),
  ]);

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
