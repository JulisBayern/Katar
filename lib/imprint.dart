import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:katar/markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Imprint extends StatelessWidget {
  const Imprint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Impressum")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const MarkdownBody(data: impressum, shrinkWrap: true,),
            SizedBox(height: 16,),
            ButtonBar(
              children: [
                ElevatedButton(onPressed: () {
                  launchUrlString("https://www.julis-bayern.de/datenschutz/");
                }, child: Text("Datenschutz")),
                ElevatedButton(onPressed: () {
                  showLicensePage(context: context);
                }, child: Text("Lizenzen"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
