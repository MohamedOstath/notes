import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_flutter_local_database/core/constants.dart';
import 'package:note_flutter_local_database/core/resources/manager_height.dart';
import 'package:note_flutter_local_database/core/resources/manager_icon_sizes.dart';
import 'package:note_flutter_local_database/core/resources/manager_width.dart';
import 'package:note_flutter_local_database/core/storage/local/database/modle/note.dart';
import 'package:note_flutter_local_database/core/widgets/Helpers.dart';
import 'package:note_flutter_local_database/core/widgets/base_button.dart';
import 'package:note_flutter_local_database/features/app/presentation/controller/home_controller.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_strings.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({super.key});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> with Helpers {
  late TextEditingController _titleTextEditingController;
  late TextEditingController _contentTextEditingController;
  final HomeController _homeController = Get.find<HomeController>();
  int noteId = 0;
  String? title;

  @override
  void initState() {
    super.initState();
    _titleTextEditingController = TextEditingController(text: 'hiiiiiiiiiiiiii');
    _contentTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    ModalRoute? modalRoute = ModalRoute.of(context);

    if (modalRoute != null &&
        modalRoute.settings != null &&
        modalRoute.settings.arguments != null) {
      Map<String, dynamic> args =
          modalRoute.settings.arguments as Map<String, dynamic>;
      noteId = args[Constants.databaseIdColumnName];
      title = args[Constants.databaseNotesTitleColumnName];
    }

    return GetBuilder<HomeController>(builder: (controller) {
      _homeController.show(noteId);
      // _textEditingController.text = _homeController.currentNote.content;

      // _contentTextEditingController.text = _homeController.currentNote.content;

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ManagerColors.transparent,
          title: Text(
            controller.currentNote.title,
            style: TextStyle(
              fontSize: ManagerFontSizes.s20,
              color: ManagerColors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                performUpdateNote();
              },
              icon: Icon(
                Icons.save,
                color: ManagerColors.black,
                size: ManagerIconSizes.s34,
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: ManagerHeight.h14,
            horizontal: ManagerWidth.w14,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ManagerColors.primaryColor,
                ManagerColors.white,
              ],
            ),
          ),
          child: Container(
            margin: const EdgeInsetsDirectional.only(top: ManagerHeight.h100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title'),
                TextField(
                  // initialValue: controller.currentNote.content ?? '',
                  keyboardType: TextInputType.text,
                  controller: _titleTextEditingController,
                  decoration: InputDecoration(
                    hintText: 'add content note',
                    hintStyle: TextStyle(
                      fontSize: ManagerFontSizes.s20,
                      color: ManagerColors.secondaryColor,
                    ),
                  ),
                  minLines: 1,
                  maxLines: 10,
                ),
                Text('Content'),
                TextField(
                  // initialValue: controller.currentNote.content ?? '',
                  keyboardType: TextInputType.text,
                  controller: _contentTextEditingController,
                  decoration: InputDecoration(
                    hintText: 'add content note',
                    hintStyle: TextStyle(
                      fontSize: ManagerFontSizes.s20,
                      color: ManagerColors.secondaryColor,
                    ),
                  ),
                  minLines: 1,
                  maxLines: 10,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> performUpdateNote() async {
    if (checkData()) {
      save();
    }
  }

  bool checkData() {
    if (_titleTextEditingController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> save() async {
    Note note = _homeController.currentNote;
    // note.id = noteId;
    note.content = _contentTextEditingController.text.toString();
    note.title = _titleTextEditingController.text.toString();
    bool updated = await _homeController.updateNote(note: note);
    if (updated) {
      showSnackBar(
        context: context,
        message: 'success',
      );
      // Navigator.pop(context);
    } else {
      showSnackBar(
        context: context,
        message: 'fail',
        error: true,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTextEditingController.dispose();
  }
}
