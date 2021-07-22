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
