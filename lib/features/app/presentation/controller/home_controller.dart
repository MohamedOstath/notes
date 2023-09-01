import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_flutter_local_database/core/storage/local/database/controller/note_database_controller.dart';
import 'package:note_flutter_local_database/core/widgets/Helpers.dart';

import '../../../../core/storage/local/database/modle/note.dart';

class HomeController extends GetxController with Helpers{
  List<Note> notes = [];

  final NoteDatabaseController noteDatabaseController =
      NoteDatabaseController();

  Note currentNote = Note.fillData(
    id: 0,
    content: '',
    title: '',
  );

  Future<void> read() async {
    notes = await noteDatabaseController.read();
    update();
  }

  Future<void> show(int id) async {
    currentNote = await noteDatabaseController.show(id) ?? Note();
    update();
  }

  Future<bool> create({required Note note}) async {
    int id = await noteDatabaseController.create(note);

    if (id != 0) {
      note.id = id;
      notes.add(note);
      update();
    }
    return id != 0;
  }

  Future<bool> updateNote({required Note note}) async {
    bool updated = await noteDatabaseController.update(note);

    if (updated) {
      notes[notes.indexWhere((element) => element.id == note.id)] = note;
      update();
      return true;
    }
    return false;
  }

  Future<void> delete(int index,BuildContext context) async{
    int noteId = notes[index].id;
    if(await noteDatabaseController.delete(noteId)){
      notes.remove(notes[index]);
      showSnackBar(context: context, message: 'deleted successfully');
      update();
    }else{
      showSnackBar(context: context, message: 'delete note failed');
    }
  }

  @override
  void onInit() {
    super.onInit();
    read();
    // Note note = Note();
    // note.id = 1;
    // note.content = 'test content ';
    // notes.add(note);
    // notes.add(note);
    // notes.add(note);
    // notes.add(note);
  }
}
