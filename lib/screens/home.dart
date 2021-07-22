import 'package:flutter/material.dart';
import 'package:flutter_workshop/models/notes.dart';
import 'package:flutter_workshop/widgets/CusntomTextForm.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> _notes = [
    Note(title: 'First Note', desc: 'Description of First note'),
    Note(title: 'Second Note', desc: 'Description of Second note'),
    Note(title: 'Third Note', desc: 'Description of Third note'),
    Note(title: 'Forth Note', desc: 'Description of Forth note'),
  ];

  @override
  Widget build(BuildContext context) {
    String title = "";
    String desc = "";

    void addNote() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Add Note'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFrom(
                    title: 'Title',
                    icon: Icons.title,
                    onChnage: (String value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                  CustomTextFrom(
                      title: 'Description',
                      icon: Icons.description,
                      onChnage: (String value) {
                        setState(() {
                          desc = value;
                        });
                      }),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _notes.insert(0, Note(title: title, desc: desc));
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Add Note!'),
                  ),
                ],
              ),
            );
          });
    }

    ;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App!'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_notes[index].title),
                subtitle: Text(_notes[index].desc),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
