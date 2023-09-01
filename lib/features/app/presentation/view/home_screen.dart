import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_flutter_local_database/core/constants.dart';
import 'package:note_flutter_local_database/core/resources/manager_colors.dart';
import 'package:note_flutter_local_database/core/resources/manager_font_sizes.dart';
import 'package:note_flutter_local_database/core/resources/manager_icon_sizes.dart';
import 'package:note_flutter_local_database/core/resources/manager_radius.dart';
import 'package:note_flutter_local_database/core/resources/manager_strings.dart';
import 'package:note_flutter_local_database/features/app/presentation/controller/home_controller.dart';
import 'package:note_flutter_local_database/routes/routes.dart';

import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_width.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // List names = [
    //   'mmmm',
    //   'dfdfd',
    //   'lllllll',
    //   'mmmm',
    //   'dfdfd',
    //   'lllllll',
    //   'mmmm',
    //   'dfdfd',
    //   'lllllll',
    //   'mmmm',
    //   'dfdfd',
    //   'lllllll',
    //   'mmmm',
    //   'dfdfd',
    //   'lllllll',
    // ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ManagerColors.transparent,
        title: Text(
          ManagerStrings.appName,
          style: TextStyle(
            fontSize: ManagerFontSizes.s20,
            color: ManagerColors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: ManagerIconSizes.s26,
          color: ManagerColors.secondaryColor,
        ),
        shape: CircleBorder(),
        backgroundColor: ManagerColors.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, Routes.addNoteScreen);
        },
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              ManagerColors.primaryColor,
              ManagerColors.white,
            ],
          )),
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: controller.notes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.noteDetailsScreen,
                        arguments: {
                          Constants.databaseIdColumnName:
                              _homeController.notes[index].id,
                          Constants.databaseNotesTitleColumnName:
                              _homeController.notes[index].title
                        },
                      );
                    },
                    child: Card(
                      color: ManagerColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ManagerRadius.r12),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: ManagerWidth.w8,
                              vertical: ManagerHeight.h14,
                            ),
                            child: Text(
                              controller.notes[index].content,
                              style: TextStyle(
                                color: ManagerColors.white,
                                fontSize: ManagerFontSizes.s12,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.topEnd,
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                size: ManagerIconSizes.s20,
                              ),
                              onPressed: () {
                                _homeController.delete(index,context);
                              },
                              color: ManagerColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )

          // child: ListView(
          //   children: [
          //     ...List.generate(
          //       names.length,
          //       (index) => Card(
          //         color: ManagerColors.red,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(ManagerRadius.r12),
          //         ),
          //         child: Container(
          //           height: 50,
          //           width: double.infinity,
          //           child: Text('data ${names[index]}'),
          //         ),
          //       ),
          //     )

          // for (int i = 0; i < 10; i++)
          //   Card(
          //     color: ManagerColors.red,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(ManagerRadius.r12),
          //     ),
          //     child: Container(
          //       height: 50,
          //       width: double.infinity,
          //       child: Text('data'),
          //     ),
          //   ),
          // ],
          ),

      // child: GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     mainAxisSpacing: 10,
      //     crossAxisSpacing: 10,
      //   ),
      //   itemCount: 10,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       color: ManagerColors.brown200,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(
      //           ManagerRadius.r12,
      //         ),
      //       ),
      //       child: Center(
      //         child: Text(
      //           '$index',
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
