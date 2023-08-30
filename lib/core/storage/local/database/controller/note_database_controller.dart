import 'package:note_flutter_local_database/core/constants.dart';
import 'package:note_flutter_local_database/core/extension/extensions.dart';
import 'package:note_flutter_local_database/core/storage/local/database/modle/note.dart';
import 'package:note_flutter_local_database/core/storage/local/database/provider/database_operations.dart';
import 'package:note_flutter_local_database/core/storage/local/database/provider/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabaseController extends DataBaseOperations<Note> {
  Database database = DatabaseProvider().database;

  @override
  Future<int> create(Note object) async {
    int id =
        await database.insert(Constants.databaseNotesTableName, object.toMap());
    return id;
  }

  @override
  Future<bool> delete(int id) async {
    return await database.delete(Constants.databaseNotesTableName,
            where: '${Constants.databaseIdColumnName} = ?', whereArgs: [id]) >
        0;
  }

  @override
  Future<List<Note>> read() async {
    List<Map<String, Object?>> data =
        await database.query(Constants.databaseNotesTableName);

    // List<Note> notes = [];
    // for(Map<String,Object?> note in data){
    //   notes.add(Note.fromMap(note));
    // }

    return data.map((e) => Note.fromMap(e)).toList();
  }

  @override
  Future<Note?> show(int id) async {
    var data = await database.query(Constants.databaseNotesTableName,
        where: '${Constants.databaseIdColumnName} = ?', whereArgs: [id]);

    if (data.isNotEmpty) {
      return Note.fromMap(data.first);
    }
    return null;
  }

  @override
  Future<Note?> searchByNameOrId(int? id, String? name) async {
    var data = await database.query(
      Constants.databaseNotesTableName,
      where:
          '${Constants.databaseIdColumnName} = ? or ${Constants.databaseContentColumnName} = ?',
      whereArgs: [id.onNull(), name.onNull],
    );

    if (data.isNotEmpty) {
      return Note.fromMap(data.first);
    }
    return null;
  }

  @override
  Future<bool> update(Note object) async {
    int countOfRowsUpdated = await database.update(
      Constants.databaseNotesTableName,
      object.toMap(),
      where: '${Constants.databaseIdColumnName} = ?',
      whereArgs: [object.id],
    );

    return countOfRowsUpdated > 0;
  }
}
