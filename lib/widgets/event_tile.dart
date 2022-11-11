import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:katar/main.dart';
import 'package:katar/markdown.dart';
import 'package:katar/models.dart';
import 'package:katar/widgets/competitor.dart';

class EventTile extends StatefulWidget {
  EventTile(this.event, this.isAnimated, {Key? key}) : super(key: key);

  final TickerEvent event;
  bool isAnimated;

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> imageFadeIn;
  late Animation<double> imageBounce;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    imageFadeIn = _controller.drive(Tween(begin: 0, end: 3));
    imageBounce = _controller.drive(CurveTween(curve: Curves.easeInCubic));
    if (widget.isAnimated) {
      _controller.forward(from: 0);
    } else {
      _controller.value = 1;
    }
    _controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tt = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              child: Transform(
                  transform: Matrix4.rotationZ(1 - imageBounce.value),
                  child: Icon(widget.event.type.icon,
                      size: 32,
                      color: widget.event.type.iconColor
                          .withOpacity(max(0, imageFadeIn.value - 2))))),
          Container(
            width: 8,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.title,
                          style: tt.titleSmall,
                        ),
                        if (widget.event.description != null)
                          Text(
                            widget.event.description!,
                            style: tt.bodySmall,
                          ),
                        if (widget.event.explainId != null)
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => showMarkdown(context, explainMap[widget.event.explainId!]!, "Erklärung"),
                                  child: Text(
                                    "Erklärung",
                                    style: tt.titleSmall!.copyWith(decoration: TextDecoration.underline),
                                  ),
                                ))
                          )
                      ],
                    ),
                  ),
                  if (widget.event.scoreChange != null) Text(widget.event.score!, style: tt.titleSmall,),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        "${widget.event.time}´",
                        textAlign: TextAlign.right,
                        style: tt.titleSmall!.copyWith(color: Colors.black26),
                      ))
                ],
              ),
              Container(width: double.infinity, margin: EdgeInsets.only(top: 4), height: 1, color: Colors.black12)
            ],
          )),
        ],
      ),
    );
  }

  Flexible _buildScore() => Flexible(
      fit: FlexFit.tight,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: -1, color: Colors.black26)]
            ),
            child: Image(
              image: (widget.event.scoreChange ?? 0) > 0
                  ? Competitor.qatar
                  : Competitor.un,
              height: 24,
              width: 36,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ));
}
