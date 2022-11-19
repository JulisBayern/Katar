import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:katar/generator.dart';
import 'package:katar/imprint.dart';
import 'package:katar/models.dart';
import 'package:katar/widgets/event_stream.dart';
import 'package:katar/widgets/header.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  runApp(const KatarApp());
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

class KatarApp extends StatelessWidget {
  const KatarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WM 2022 Katar Liveticker",
      theme: ThemeData(
        primarySwatch: magenta,
        textTheme: _overrideFamily(ThemeData.light().textTheme, "Montserrat")
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
                      const Spacer(),
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
                      launchUrlString("https://www.julis.de/qatar/");
                    }, child: const Text("#boycottqatar2022")),
                    TextButton(onPressed: () {
                      showDialog(context: context, builder: (_) => const Imprint());
                    }, child: const Text("Impressum"))
                  ],
                )
              ],
            )),
          ],
        ),
      );
  }
}

const MaterialColor magenta = MaterialColor(
  0xFFE5007D,
  <int, Color>{
    50: Color(0xFFfce5f1),
    100: Color(0xFFf8bddc),
    200: Color(0xFFf692c5),
    300: Color(0xFFf664ad),
    400: Color(0xFFf53d98),
    500: Color(0xFFf70082),
    600: Color(0xFFe5007e),
    700: Color(0xFFce0477),
    800: Color(0xFFb80472),
    900: Color(0xFF910468),
  },
);

TextTheme _overrideFamily(TextTheme textTheme, String fontFamily) {
  return TextTheme(
    displayLarge: textTheme.displayLarge?.copyWith(fontFamily: fontFamily),
    displayMedium: textTheme.displayMedium?.copyWith(fontFamily: fontFamily),
    displaySmall: textTheme.displaySmall?.copyWith(fontFamily: fontFamily),
    headlineLarge: textTheme.headlineLarge?.copyWith(fontFamily: fontFamily),
    headlineMedium: textTheme.headlineMedium?.copyWith(fontFamily: fontFamily),
    headlineSmall: textTheme.headlineSmall?.copyWith(fontFamily: fontFamily),
    titleLarge: textTheme.titleLarge?.copyWith(fontFamily: fontFamily),
    titleMedium: textTheme.titleMedium?.copyWith(fontFamily: fontFamily),
    titleSmall: textTheme.titleSmall?.copyWith(fontFamily: fontFamily),
    bodyLarge: textTheme.bodyLarge?.copyWith(fontFamily: fontFamily),
    bodyMedium: textTheme.bodyMedium?.copyWith(fontFamily: fontFamily),
    bodySmall: textTheme.bodySmall?.copyWith(fontFamily: fontFamily),
    labelLarge: textTheme.labelLarge?.copyWith(fontFamily: fontFamily),
    labelMedium: textTheme.labelMedium?.copyWith(fontFamily: fontFamily),
    labelSmall: textTheme.labelSmall?.copyWith(fontFamily: fontFamily),
  );
}