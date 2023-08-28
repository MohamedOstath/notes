import 'dart:io';

import 'package:note_flutter_local_database/core/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _instance;
  }

  late Database _database;

  Database get database => _database;

  Future<void> initDatabase() async {
    // path
    Directory directory = await getApplicationCacheDirectory();
    String path = join(directory.path, Constants.databaseName);
    // build schema
    _database = await openDatabase(
      path,
      version: Constants.databaseFirstVersion,
      onCreate: (database, version) async {
        database.execute(
          'CREATE TABLE ${Constants.databaseNotesTableName} ('
          '${Constants.databaseIdColumnName} INTEGER PRIMARY KEY AUTOINCREMENT, '
          '${Constants.databaseContentColumnName} TEXT)',
        );
      },
      onOpen: (database) {},
      onUpgrade: (database, oldVersion, newVersion) {},
      onDowngrade: (database, oldVersion, newVersion) {},
    );
  }
}
