import 'package:note_flutter_local_database/core/constants.dart';
import 'package:note_flutter_local_database/core/resources/manager_strings.dart';

class Note {
  late int id;
  late String content;

  Note(this.id, this.content);

  Note.fromMap(Map<String, dynamic> map) {
    id = map[Constants.databaseIdColumnName];
    content = map[Constants.databaseContentColumnName];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Constants.databaseContentColumnName: content,
    };
  }
}
