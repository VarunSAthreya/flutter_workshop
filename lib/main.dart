import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home.dart';
import 'util/dark_notifier.dart';
import 'util/theme.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => DarkNotifier(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Workshop',
      theme: Styles.themeData(
        isDark: Provider.of<DarkNotifier>(context).isDark,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
