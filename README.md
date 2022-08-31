# [Flutter Workshop]()

This is a crash course to learn a few of the advanced topics in flutter such as state management, changing themes, storing data in local storage, etc.

Final Demo video of the app:

<img src="https://github.com/VarunSAthreya/flutter_workshop/blob/main/assets/demo.gif?raw=true" alt="Demo video" height="20%" width="20%"/>

## Getting Started

### Prerequisites

- Basic Knowledge about Flutter and Dart.
-   [Flutter SDK](https://flutter.dev/docs/get-started/install)
-   [Android Studio](https://developer.android.com/studio) or [VSCode](https://code.visualstudio.com/download)

To setup Flutter in Android Studio check [here](https://flutter.dev/docs/development/tools/android-studio)

To setup Flutter in VSCode check [here](https://flutter.dev/docs/development/tools/vs-code)

### Running the app

-   Make sure you have the Flutter SDK installed and other prerequisites.
-   Fork the repository and clone it to your local machine.
-   Open Android Studio or VSCode and import the project.
-   To download the dependencies run `flutter pub get` at the project's root directory.
-   To run the app run `flutter run` at the project's root directory.

## Features

- The features are divided into 3 parts
  - [Basic](#beginner-level-features)
  - [Intermediate](#intermediate-level-features)
  - [Advance](#advance-level-features)
- But first, let's start with the [Starter](#starter) code for the app.

### Starter
- In the starter code there is a `MyHomePage` class which is the `Home page`, used to show the notes.
- Also I have created a `custom textfiled` to use in other places.
- And at last, there is a `Note` model which would contain the `title` and  `description` of the note.

Below is the list of features that can be used to learn the topics.

### Beginner level Features

- Add `date` to the `Note` model.
- Create a new screen to show the `Note.title` and `Note.desc`.
-   Update and delete operations for notes.
- Create a `Snackbar` on the Update and Delete operation.
- Add [`Slidable`](https://pub.dev/packages/flutter_slidable) to denote the Update and Delete feature.
-   If you get stuck anywhere you can find the code [here](https://github.com/VarunSAthreya/flutter_workshop/tree/basic), and the guide can be found [here](#guide-basic-level-features).

### Intermediate level Features

-   Add [provider](https://pub.dev/packages/provider) package for state management.
-   Separate theme data to be changed on theme toggle.
-   Add [shared preferences](https://pub.dev/packages/shared_preferences) package to store the theme preference.
-   Dynamic theme changing. (Light/Dark Theme)
-    If you get stuck anywhere you can find the code  [here](https://github.com/VarunSAthreya/flutter_workshop/tree/intermediate), and the guide can be found [here](#guide-intermediate-level-features).

### Advanced level Features

-   Add [sqllite](https://pub.dev/packages/sqflite) database to store notes.
-   Add CRUD operations in the database for notes.
-    If you get stuck anywhere you can find the code  [here](https://github.com/VarunSAthreya/flutter_workshop/tree/advanced), and the guide can be found [here](#guide-advanced-level-features).

## Guide for implementing features:

### Guide: Basic level Features:

-   Code for basic level features can be found [here](https://github.com/VarunSAthreya/flutter_workshop/tree/basic).
-   Install Packages :

    -   To install any package run `flutter pub add <package name>` in the root of the project.
    -   [flutter_slidable](https://pub.dev/packages/flutter_slidable)
    -   [intl](https://pub.dev/packages/intl)

-   Add the `date` property in the `Note` model to store the `DateTime` of note creation.

    -   After this, the constructor of the `Note` model will look like this: [note.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/basic/lib/models/note.dart)

        ```dart
        class Note {
            final String title;
            final String desc;
            final DateTime date;

            Note({
                required this.title,
                required this.desc,
                required this.date,
            });
        }
        ```

-   Add `details.dart` screen to display note details.

    -   Navigate to `details.dart` file when the `ListTile` is pressed.
    -   Code for details page is given below: [details.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/basic/lib/screens/details.dart)

        ```dart
            import 'package:flutter/material.dart';
            import 'package:intl/intl.dart';

            import '../models/note.dart';

            class Details extends StatelessWidget {
                final Note note;

                const Details({
                    Key? key,
                    required this.note,
                }) : super(key: key);

                @override
                Widget build(BuildContext context) {
                    DateFormat _dateFormat = DateFormat('hh:mm, d MMMM yy');

                    return Scaffold(
                    backgroundColor: Theme.of(context).backgroundColor,
                    appBar: AppBar(
                        backgroundColor: Theme.of(context).primaryColor,
                        title: Text('Note Details!'),
                    ),
                    body: Center(
                        child: Container(
                        width: double.infinity,
                        color: Theme.of(context).accentColor,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            children: [
                            Text(
                                note.title,
                                textScaleFactor: 2,
                                style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                ),
                            ),
                            SizedBox(height: 20),
                            Text(
                                'Date: ${_dateFormat.format(note.date)}',
                                textScaleFactor: 1.3,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(height: 30),
                            Text(
                                note.desc,
                                textScaleFactor: 1.2,
                                ),
                            ]),
                        ),
                    ),
                );
                }
            }
        ```

-   Add a `snackbar` to show on note's CRUD operations.

    -   Docs for `SnackBar` class can be found [here](https://api.flutter.dev/flutter/material/SnackBar-class.html)
    -   Code for snackbar is given below:
        ```dart
            void snackbar(String message) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
            }
        ```

-   Add `Slidable` as a parent widget to the `ListTile` and add update and delete operations to the `actions` and `secondaryActions` of the widget.
    -   Docs for `Slidable` package can be found [here](https://pub.dev/documentation/flutter_slidable/latest/)
    -   With `update` and `delete` features to the `_notes` list ie. `_notes[index] = <Updated Note>` and `_notes.removeAt(index);` respectively.
    -   (Note: I have modified the `addNote` function to `_addUpdateNote` with optional parameters to update the note.)
    -   After this, the `ListTile` with `Slidable` as a parent widget will look like this: [home.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/basic/lib/screens/home.dart)
        ```dart
            Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: [
                IconSlideAction(
                caption: 'Update',
                color: Colors.blue,
                icon: Icons.update,
                onTap: () => _addUpdateDialog(
                    title: _notes[index].title,
                    desc: _notes[index].desc,
                    type: 'Update',
                    index: index,
                    id: _notes[index].id,
                ),
                ),
            ],
            secondaryActions: [
                IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () async {
                    setState(() {
                    _notes.removeAt(index);
                    });
                    snackbar("Deleted Note!");
                },
                ),
            ],
            child: ListTile(
                leading: Icon(
                    Icons.note,
                    color: Theme.of(context).primaryColor,
                ),
                title: Text(
                    _notes[index].title,
                    textScaleFactor: 1.2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(_notes[index].desc),
                trailing: Icon(
                    CupertinoIcons.forward,
                    color: Theme.of(context).primaryColor,
                    size: 35,
                ),
                onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Details(
                    note: _notes[index],
                    ),
                ),
                ),
            ),
        );
        ```
-   Finished with the **Basic level Features** of the app🎉.

### Guide: Intermediate level Features:

-   Code for intermediate-level features can be found [here](https://github.com/VarunSAthreya/flutter_workshop/tree/intermediate)
-   Install Packages :

    -   To install any package run `flutter pub add <package name>` in the root of the project.
    -   [provider](https://pub.dev/packages/provider)
    -   [shared_preferences](https://pub.dev/packages/shared_preferences)

-   Create a `theme.dart` inside the `util` folder for storing theme-related constants.

    -   Add the `isDark` property to change the theme data of the app based on the value.
    -   The `theme.dart` file will look like this: [theme.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/intermediate/lib/util/theme.dart)

        ```dart
            import 'package:flutter/material.dart';

            class Styles {
            static ThemeData themeData({
                required bool isDark,
            }) {
                return ThemeData(
                primarySwatch: Colors.red,
                primaryColor: Colors.red,
                accentColor: isDark ? const Color(0xFF161B22) : Colors.white,
                backgroundColor:
                    isDark ? const Color(0xFF010409) : const Color(0xFFEEEEEE),
                brightness: isDark ? Brightness.dark : Brightness.light,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                );
            }
            }
        ```

-   Add `dark_notifier.dart` for retrieving from local storage and notify the listeners of theme change

    -   Docs for `SharedPreferences` package can be found [here](https://pub.dev/documentation/shared_preferences/latest/)
    -   Docs for `Provider` package can be found [here](https://pub.dev/documentation/provider/latest/)
    -   More details about local storage and theming be found [video](https://www.youtube.com/watch?v=uCbHxLA9t9E&t=2213s).
    -   The `dark_notifier.dart` file will look like this: [dark_notifier.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/intermediate/lib/util/dark_notifier.dart)

        ```dart
            import 'package:flutter/material.dart';
            import 'package:shared_preferences/shared_preferences.dart';

            class DarkNotifier with ChangeNotifier {
            PrefsState _currentPrefs = const PrefsState();

            DarkNotifier() {
                _loadDarkPref();
            }

            Future<void> _loadDarkPref() async {
                await SharedPreferences.getInstance().then((prefs) {
                    final bool darkPref = prefs.getBool('isDark') ?? false;
                    _currentPrefs = PrefsState(darkMode: darkPref);
                });

                notifyListeners();
            }

            Future<void> _saveDarkPref() async {
                await SharedPreferences.getInstance().then((prefs) {
                    prefs.setBool('isDark', _currentPrefs.darkMode);
                });
            }

            bool get isDark => _currentPrefs.darkMode;

            set darkMode(bool newValue) {
                if (newValue == _currentPrefs.darkMode) return;
                    _currentPrefs = PrefsState(darkMode: newValue);
                    notifyListeners();
                    _saveDarkPref();
                }
            }

            class PrefsState {
                final bool darkMode;

                const PrefsState({this.darkMode = false});
            }

        ```

-   Changes at `main.dart` has to be done for state management and theming.

    -   The `main.dart` file will look like this: [main.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/intermediate/lib/main.dart)

        ```dart
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

        ```

-   Add the `Switch` button on the home screen for switching the theme.

    -   Code for the `Switch` button is given below: [home.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/intermediate/lib/screens/home.dart)
        ```dart
            Switch(
                value: _isDark,
                onChanged: (value) {
                _isDark = value;
                Provider.of<DarkNotifier>(context, listen: false).darkMode =
                    _isDark;
                },
            ),
        ```

-   Congratulations! Finished with the **Intermediate level Features** of the app🎉.

### Guide: Advanced level Features:

-   Code for advanced level features can be found [here](https://github.com/VarunSAthreya/flutter_workshop/tree/advanced)
-   Install Packages :

    -   To install any package run `flutter pub add <package name>` in the root of the project.
    -   [sqflite](https://pub.dev/packages/sqflite)
    -   [path](https://pub.dev/packages/path)

-   Add `SQlite` database to store notes.
-   Create SQL Table in the `main` function in the database for storing notes.
-   Docs of `SQlite` package can be found [here](https://pub.dev/documentation/sqflite/latest/)
-   Flutter example for `SQlite` can be found [here](https://flutter.dev/docs/cookbook/persistence/sqlite).
-   Code to create table in `main` function is given below: [main.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/advanced/lib/main.dart)

    ```dart
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
    ```

-   Add CRUD operations for notes SQlite database in `models/note.dart`.

    -   Add the `id` property inside the `Note` class as the primary key for the database.
    -   Code for CRUD operations in `note.dart` is given below: [note.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/advanced/lib/models/note.dart)

        ```dart
            import 'package:path/path.dart';
            import 'package:sqflite/sqflite.dart';

            class Note {
                final int id;
                final String title;
                final String desc;
                final DateTime date;
                static late final Future<Database> _database;

                Note({
                    required this.id,
                    required this.title,
                    required this.desc,
                    required this.date,
                });

                static Future<void> _loadDatabase() async {
                    _database = openDatabase(
                    join(await getDatabasesPath(), 'notes_database.db'),
                    version: 1,
                    );
                }

                Map<String, dynamic> toMap() {
                    return {
                    'id': id,
                    'title': title,
                    'desc': desc,
                    'date': date.toString(),
                    };
                }

                @override
                String toString() {
                    return 'Note{id: $id, title: $title, desc: $desc, data: ${date.toString()}}';
                }

                static Future<void> insertNote(Note note) async {
                    final db = await _database;

                    await db.insert(
                    'note',
                    note.toMap(),
                    conflictAlgorithm: ConflictAlgorithm.replace,
                    );
                    print('Note Inserted');
                }

                static Future<List<Note>> getNotes() async {
                    // Get a reference to the database.
                    await _loadDatabase();
                    final db = await _database;

                    // Query the table for all The Notes.
                    final List<Map<String, dynamic>> maps = await db.query('note');
                    print('Note Got');

                    // Convert the List<Map<String, dynamic> into a List<Note>.
                    return List.generate(maps.length, (i) {
                    return Note(
                        id: maps[i]['id'],
                        title: maps[i]['title'],
                        desc: maps[i]['desc'],
                        date: DateTime.parse(maps[i]['date']),
                    );
                    });
                }

                static Future<void> updateNote(Note note) async {
                    // Get a reference to the database.
                    final db = await _database;

                    // Update the given Note.
                    await db.update(
                    'note',
                    note.toMap(),
                    // Ensure that the Note has a matching id.
                    where: 'id = ?',
                    // Pass the Note's id as a whereArg to prevent SQL injection.
                    whereArgs: [note.id],
                    );
                    print('Note Updated: ${note.id}');
                }

                static Future<void> deleteNote(int id) async {
                    // Get a reference to the database.
                    final db = await _database;

                    // Remove the Note from the database.
                    await db.delete(
                    'note',
                    // Use a `where` clause to delete a specific Note.
                    where: 'id = ?',
                    // Pass the Note's id as a whereArg to prevent SQL injection.
                    whereArgs: [id],
                    );
                    print('Note Deleted: $id');
                }
            }

        ```

    -   Check the addition of CRUD operations of `note` database in [home.dart](https://github.com/VarunSAthreya/flutter_workshop/blob/advanced/lib/screens/home.dart)

-   Congratulations! Finished with the **Advanced level Features** of the app🎉.

## Further reading:

-   Topics to be covered upon the completion for more understanding of the Flutter app:
    -   Firebase integration. [link](https://flutter.dev/docs/development/data-and-backend/firebase)
    -   API calls using http package. [link](https://pub.dev/documentation/http/latest/)
    -   Flutter hooks. [link](https://pub.dev/documentation/flutter_hooks/latest/)
    -   [Riverpod](https://pub.dev/packages/riverpod) / [Bloc](https://pub.dev/packages/flutter_bloc)
    -   Provider Architecture in flutter. [link](https://medium.com/flutter-community/flutter-architecture-provider-implementation-guide-d33133a9a4e8)
    -   MVC Architecture in flutter. [link](https://medium.com/follow-flutter/your-next-mvc-flutter-project-1fabe2069b01)
