import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../util/dark_notifier.dart';

class Details extends StatelessWidget {
  final Note note;

  const Details({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat _dateFormat = DateFormat('hh:mm, d MMMM yy');
    bool _isDark = Provider.of<DarkNotifier>(context, listen: false).isDark;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: _isDark
            ? Theme.of(context).accentColor
            : Theme.of(context).primaryColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
