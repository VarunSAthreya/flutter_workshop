import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'screens/home.dart';
import 'util/dark_notifier.dart';
import 'util/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await openDatabase(
    join(await getDatabasesPath(), 'notes_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT, desc Text, date Text)',
      );
    },
    version: 1,
  );

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
