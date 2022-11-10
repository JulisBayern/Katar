import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katar/widgets/event_tile.dart';

import '../models.dart';

class EventStream extends StatelessWidget {
  EventStream({Key? key}) : super(key: key);

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, List<TickerEvent>>(
      builder: (context, state) {
        var tiles = state.map((e) => EventTile(e,false)).toList();
        tiles.last.isAnimated = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
        });
        return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(controller: scrollController, children: tiles,)
        );
      },
    );
  }
}
