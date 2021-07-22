import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/note.dart';
import '../widgets/custom_text_form.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Note> _notes;

  void snackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _addUpdateDialog(
      {String title = "",
      String desc = "",
      String type = "Add",
      int index = 0,
      int id = 0}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$type Note!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextForm(
                initialValue: title,
                title: 'Title',
                icon: Icons.title,
                onChange: (String value) {
                  setState(() {
                    title = value;
                    debugPrint(title);
                  });
                },
              ),
              SizedBox(height: 20),
              CustomTextForm(
                initialValue: desc,
                title: 'Description',
                icon: Icons.title,
                onChange: (String value) {
                  setState(() {
                    desc = value;
                    debugPrint(desc);
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (type == "Add") {
                      addNote(title, desc);
                    } else {
                      updateNote(index, id, title, desc);
                    }
                  });
                  Navigator.pop(context);
                },
                child: Text("$type Note!"),
              ),
            ],
          ),
        );
      },
    );
  }

  void updateNote(int index, int id, String title, String desc) {
    _notes[index] = Note(
      title: title,
      desc: desc,
      date: DateTime.now(),
    );
    snackbar("Updated Note!");
  }

  void addNote(String title, String desc) {
    _notes.insert(
        0,
        Note(
          title: title,
          desc: desc,
          date: DateTime.now(),
        ));
    snackbar("Added Note!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Notes App!'),
      ),
      body: Center(
        child: _notes.isEmpty
            ? Container(
                child: Text('Add Notes!!'),
              )
            : ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      noteTile(index, context),
                      SizedBox(
                        width: 100,
                        child: Divider(
                          thickness: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUpdateDialog,
        tooltip: 'Add Note',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget noteTile(int index, BuildContext context) {
    return Slidable(
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
  }
}
