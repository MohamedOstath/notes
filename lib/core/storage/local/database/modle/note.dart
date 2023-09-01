import 'package:note_flutter_local_database/core/constants.dart';
import 'package:note_flutter_local_database/core/resources/manager_strings.dart';

class Note {
  late int id;
  late String content;
  late String title;

  Note();

  Note.fillData({
    required this.id,
    required this.content,
    required this.title,
  });

  Note.fromMap(Map<String, dynamic> map) {
    id = map[Constants.databaseIdColumnName];
    content = map[Constants.databaseContentColumnName];
    title = map[Constants.databaseNotesTitleColumnName];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Constants.databaseContentColumnName: content,
      Constants.databaseNotesTitleColumnName: title,
    };
  }
}
