import 'package:flutter/material.dart';

class Competitor extends StatelessWidget {

  const Competitor({Key? key, required this.name, required this.url}) : super(key: key);

  final ImageProvider url;
  final String name;

  static ImageProvider qatar = const NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFyVfHm-L3Muxn4dzFPLqBvpRIGU2eVotBlg&usqp=CAU");
  static ImageProvider un = const NetworkImage("https://upload.wikimedia.org/wikipedia/commons/1/11/Flag_of_the_United_Nations.png");

  @override
  Widget build(BuildContext context) {
    var tt = Theme.of(context).textTheme;
    var mq = MediaQuery.of(context);
    var width = mq.size.width;
    var flagWidth = width / 4;
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
          Text(name, style: tt.titleSmall!.copyWith(color: Colors.white, fontSize: 10), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.fade,)
        ],
      ),
    );
  }
}
