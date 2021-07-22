# Flutter Workshop

This repository is a part of workshop conducted for learning the Flutter framework. Conducted on <code>22<sup>nd</sup> July 2021</code>.

The app done in the workshop is a simple note taking app. It allows users to create notes, edit them and delete them.

## Getting Started

### Prerequisites

-   [Flutter SDK](https://flutter.dev/docs/get-started/install)
-   [Android Studio](https://developer.android.com/studio) or [VSCode](https://code.visualstudio.com/download)

To setup Flutter in Android Studio check [here](https://flutter.dev/docs/development/tools/android-studio)

To setup Flutter in VSCode check [here](https://flutter.dev/docs/development/tools/vs-code)

### Running the app

-   Make sure you have the Flutter SDK installed and other prerequisites.
-   Fork the repository and clone it to your local machine.
-   Open Android Studio or VSCode and import the project.
-   To download the dependencies run `flutter pub get` in the root of the project.
-   To run the app run `flutter run` in the root of the project.

## Additional Features

-   These are some additional features that are not part of the workshop but are included in the app for further knowledge.

### Basic Features Implemented

-   Update and delete operations for notes.
-   Add new separate screen to display note details.

### Intermediate Features Implemented

-   Added Dark Theme.
-   Add [provider](https://pub.dev/packages/provider) package for state management.
-   Separated theme data to be changed on theme toggle.
-   Add [shared preferences](https://pub.dev/packages/shared_preferences) package to store the theme preference.

### Advanced Features Implemented

-   Added [sqllite](https://pub.dev/packages/sqflite) database to store notes.
-   Add CRUD operations in database for notes.

## Guide for implementing additional features:

### Basic Features:

-   Install Packages :

    -   To install any package run `flutter pub add <package name>` in the root of the project.
    -   [flutter_slidable](https://pub.dev/packages/flutter_slidable)
    -   [intl](https://pub.dev/packages/intl)

-   Add `date` property in `Note` model to store the `DateTime` of note creation.

    -   After this the constructor of `Note` model will look like this:

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
    -   Code for details page is given below:

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

-   Add `snackbar` to show on note's CRUD operations.

    -   Docs for `SnackBar` class cab be found [here](https://api.flutter.dev/flutter/material/SnackBar-class.html)
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
    -   After this the `ListTile` with `Slidable` as a parent widget will look like this:
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
-   Finished with the **Basic Additional Features** of the app🎉.
