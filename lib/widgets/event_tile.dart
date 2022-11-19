import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:katar/main.dart';
import 'package:katar/constants.dart';
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
  late Animation<double> fade1;
  late Animation<double> fade2;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    imageFadeIn = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.12, 0.33)));
    imageBounce = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0, 0.33)));
    fade1 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.0,0.50)));
    fade2 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.5,1)));

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
    var mq = MediaQuery.of(context);
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
                          .withOpacity(imageFadeIn.value)))),
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
                          style: tt.titleSmall!.copyWith(color: tt.titleSmall!.color!.withOpacity(fade1.value), fontWeight: FontWeight.w600),
                        ),
                        if (widget.event.description != null)
                          Text(
                            widget.event.description!,
                            style: tt.bodySmall!.copyWith(color: tt.bodySmall!.color!.withOpacity(fade2.value)),
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
                                    style: tt.bodySmall!.copyWith(decoration: TextDecoration.underline, color: tt.bodySmall!.color!.withOpacity(fade2.value)),
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
              Container(width: mq.size.width * fade2.value, margin: EdgeInsets.only(top: 8), height: 1, color: Colors.black12)
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
