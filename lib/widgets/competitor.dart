import 'dart:math';

import 'package:flutter/material.dart';
import 'package:katar/main.dart';

class Competitor extends StatelessWidget {

  const Competitor({Key? key, required this.name, required this.url}) : super(key: key);

  final ImageProvider url;
  final String name;

  static ImageProvider qatar = const AssetImage("assets/qatar.jpg");
  static ImageProvider un = const AssetImage("assets/un.png");

  @override
  Widget build(BuildContext context) {
    var tt = Theme.of(context).textTheme;
    var mq = MediaQuery.of(context);
    var width = mq.size.width;
    var flagWidth = min(width / 4, 200.0);
    var flagHeight = (flagWidth / 3) * 2;
    return SizedBox(
      width: flagWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: flagWidth, height: flagHeight, child: ClipRRect(child: Image(image: url, fit: BoxFit.fill,), borderRadius: BorderRadius.circular(4),), decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 10, offset: Offset(1,1), color: Colors.black54)]
          ),),
          SizedBox(height: 4,),
          Text(name, style: tt.titleSmall!.copyWith(color: Colors.white, fontSize: isDesktop ? 16 : 10), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.fade,)
        ],
      ),
    );
  }
}
