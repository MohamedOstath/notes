import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_flutter_local_database/core/resources/manager_height.dart';
import 'package:note_flutter_local_database/core/resources/manager_width.dart';
import 'package:note_flutter_local_database/core/storage/local/database/modle/note.dart';
import 'package:note_flutter_local_database/core/widgets/Helpers.dart';
import 'package:note_flutter_local_database/core/widgets/base_button.dart';
import 'package:note_flutter_local_database/features/app/presentation/controller/home_controller.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_strings.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> with Helpers {
  late TextEditingController _textEditingController;
  final HomeController _homeController = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ManagerColors.transparent,
        title: Text(
          ManagerStrings.addNewNoteTitle,
          style: TextStyle(
            fontSize: ManagerFontSizes.s20,
            color: ManagerColors.white,
          ),
        ),
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
        child: GetBuilder<HomeController>(builder: (context) {
          return Container(
            margin: const EdgeInsetsDirectional.only(top: ManagerHeight.h100),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: _textEditingController,
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
                const SizedBox(
                  height: ManagerHeight.h50,
                ),
                BaseButton(
                  elevation: 0,
                  title: ManagerStrings.addNewNoteTitle,
                  bgColor: ManagerColors.secondaryColor,
                  onPressed: () {
                    performCreateNote();
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> performCreateNote() async {
    if (checkData()) {
      save();
    }
  }

  bool checkData() {
    if (_textEditingController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> save() async {
    Note note = Note();
    note.content = _textEditingController.text.toString();
    note.title = 'title: ${_textEditingController.text}';
    bool created = await _homeController.create(note: note);
    if (created) {
      showSnackBar(
        context: context,
        message: 'success',
      );
      Navigator.pop(context);
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
    _textEditingController.dispose();
  }
}
