import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katar/blocs/event.dart';
import 'package:katar/models.dart';
import 'package:katar/widgets/competitor.dart';
import 'package:octo_image/octo_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tt = Theme.of(context).textTheme;
    var mq = MediaQuery.of(context);
    var width = mq.size.width;
    var flagWidth = min(width / 4, 200.0);
    return Column(
      children: [
        Container(
          height: 250,
          child: Stack(
            children: [
              _buildBackground(),
              Positioned.fill(child: Container(color: Colors.black54)),
              // Dark color overlay
              _buildHeaderBar(tt),
              _buildCenterScore(tt)
            ],
          ),
        ),
      ],
    );
  }

  Positioned _buildBackground() {
    return Positioned.fill(
        child: OctoImage(
      image: const AssetImage("assets/background.jpg",),
      fit: BoxFit.fitWidth,
      placeholderBuilder: OctoPlaceholder.blurHash(
        "qBGS^x%g03R\$ICogRRof^=4mM}t9ait7WBof8_t8?doeR%WAWBj[oyxxM_D#ogogofaxD*W=M^t8%5Ria}WBbFt8jYxwR%NEt8ay",
      ),
    ));
  }

  Container _buildHeaderBar(TextTheme tt) => Container(
      height: 42,
      color: Colors.pink.withOpacity(.88),
      child: Stack(
        children: [
          Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                  child: Image.asset(
                "assets/julis-logo.png",
                width: 24,
                height: 24,
              ), onTap: () => launchUrlString("https://julis-bayern.de"),)),
          Center(
              child: Text(
            "WM 2022 KATAR",
            style: tt.headlineSmall!.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          )),
          Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () async {
                  await Share.share("https://boycott.de",
                      subject: "#boycottqatar2022");
                },
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ))
        ],
      ));

  Positioned _buildCenterScore(TextTheme tt) {
    return Positioned(
      bottom: 0,
      top: 42,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Competitor(name: "Katar", url: Competitor.qatar),
          SizedBox(
            width: 64,
            child: BlocBuilder<EventCubit, List<TickerEvent>>(
              builder: (context, state) {
                return Text(
                  "${state.goalsA}:${state.goalsB}",
                  style: tt.headlineLarge!.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          Competitor(name: "Menschenrechte", url: Competitor.un)
        ],
      ),
    );
  }
}
