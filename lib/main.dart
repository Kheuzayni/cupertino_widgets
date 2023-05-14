import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_cupertino_widgets/adaptive_page.dart';
import 'package:learn_cupertino_widgets/android_page.dart';
import 'package:learn_cupertino_widgets/ios_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final platform = Theme.of(context).platform;
    //For Test
    final platform = TargetPlatform.iOS;
    bool isOS = (platform == TargetPlatform.iOS);
    return isOS ? iOSBase(platform: platform) : androidBase(platform: platform);
  }

  CupertinoApp iOSBase({required TargetPlatform platform}) {
    return CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate
      ],
      theme: CupertinoThemeData(
        primaryColor: Colors.red,
      ),

      title: 'Learn Cupertino',
      home: AdaptivePage(platform: platform),
    );
  }

  MaterialApp androidBase({ required TargetPlatform platform}) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red
      ),
      title: 'Learn Cupertino',
      home: AdaptivePage(platform: platform),
    );
  }
}

