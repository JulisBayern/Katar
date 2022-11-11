import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katar/generator.dart';
import 'package:katar/imprint.dart';
import 'package:katar/models.dart';
import 'package:katar/widgets/event_stream.dart';
import 'package:katar/widgets/header.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() async {
  runApp(const MyApp());
}

void showMarkdown(BuildContext context, String content, String title) {
  showDialog(
      context: context,
      builder: (ctx) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: FutureBuilder<String>(
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return Markdown(
                data: snapshot.data!,
                onTapLink: (text, href, title) {
                  var url = href ?? "";
                  launchUrlString(url);
                },
              );
            },
            future: Future.value(content),
          )));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      home: BlocProvider(
        create: (_) => EventCubit()..start(),
        child: SoccerView(),
      ),
    );
  }
}

bool isDesktop = false;

class SoccerView extends StatelessWidget {
  const SoccerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tt = Theme.of(context).textTheme;
    var mq = MediaQuery.of(context);
    isDesktop = mq.size.width > mq.size.height;
    return Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(),
                Container(height: 8,),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    children: [
                      Text("SPIELVERLAUF", style: tt.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                      Image.asset("assets/live.gif", width: 24, height: 24,),
                      Spacer(),
                      Text("SCORE / ZEIT", style: tt.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Container(height: 8,),
                Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: EventStream(),
                )),
                ButtonBar(
                  children: [
                    TextButton(onPressed: () {

                    }, child: Text("#boycottqatar2022")),
                    TextButton(onPressed: () {
                      showDialog(context: context, builder: (_) => const Imprint());
                    }, child: Text("Impressum"))
                  ],
                )
              ],
            )),
          ],
        ),
      );
  }
}