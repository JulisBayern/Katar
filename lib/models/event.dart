import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katar/models.dart';

class TickerEvent {

  TEType type;
  String title;
  int time;
  String? description;
  String? revision;
  String? explainId;
  ImageProvider? image;
  int? scoreChange;
  String? score;

//<editor-fold desc="Data Methods">

  TickerEvent({
    required this.type,
    required this.title,
    this.time = 0,
    this.description,
    this.revision,
    this.explainId,
    this.image,
    this.scoreChange,
    this.score,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TickerEvent &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          title == other.title &&
          time == other.time &&
          description == other.description &&
          revision == other.revision &&
          explainId == other.explainId &&
          image == other.image &&
          scoreChange == other.scoreChange &&
          score == other.score);

  @override
  int get hashCode =>
      type.hashCode ^
      title.hashCode ^
      time.hashCode ^
      description.hashCode ^
      revision.hashCode ^
      explainId.hashCode ^
      image.hashCode ^
      scoreChange.hashCode ^
      score.hashCode;

  @override
  String toString() {
    return 'TickerEvent{' +
        ' type: $type,' +
        ' title: $title,' +
        ' time: $time,' +
        ' description: $description,' +
        ' revision: $revision,' +
        ' explainId: $explainId,' +
        ' image: $image,' +
        ' scoreChange: $scoreChange,' +
        ' score: $score,' +
        '}';
  }

  TickerEvent copyWith({
    TEType? type,
    String? title,
    int? time,
    String? description,
    String? revision,
    String? explainId,
    ImageProvider? image,
    int? scoreChange,
    String? score,
  }) {
    return TickerEvent(
      type: type ?? this.type,
      title: title ?? this.title,
      time: time ?? this.time,
      description: description ?? this.description,
      revision: revision ?? this.revision,
      explainId: explainId ?? this.explainId,
      image: image ?? this.image,
      scoreChange: scoreChange ?? this.scoreChange,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': this.type,
      'title': this.title,
      'time': this.time,
      'description': this.description,
      'revision': this.revision,
      'explainId': this.explainId,
      'image': this.image,
      'scoreChange': this.scoreChange,
      'score': this.score,
    };
  }

  factory TickerEvent.fromMap(Map<String, dynamic> map) {
    return TickerEvent(
      type: map['type'] as TEType,
      title: map['title'] as String,
      time: map['time'] as int,
      description: map['description'] as String,
      revision: map['revision'] as String,
      explainId: map['explainId'] as String,
      image: map['image'] as ImageProvider,
      scoreChange: map['scoreChange'] as int,
      score: map['score'] as String,
    );
  }

//</editor-fold>
}

enum TEType {
  kickoff,
  end,
  goal,
  yellowCard,
  redCard,
  gameEvent,
  event,
}

extension TypeExtensions on TEType {
  IconData get icon {
    switch(this) {
      case TEType.kickoff:
        return Icons.sports_sharp;
      case TEType.end:
        return Icons.sports_score;
      case TEType.goal:
        return Icons.sports_soccer;
      case TEType.yellowCard:
        return Icons.sim_card_alert;
      case TEType.redCard:
        return Icons.sim_card_alert;
      case TEType.gameEvent:
        return Icons.accessibility;
      case TEType.event:
        return Icons.info;
    }
  }

  Color get iconColor {
    switch(this) {
      case TEType.yellowCard:
        return Colors.yellow;
      case TEType.redCard:
        return Colors.red;
      default: return Color(0xFF3D3D3D);
    }
  }
}