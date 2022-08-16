import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_course_lecon.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/lecon.dart';
import 'package:mbschool/models/section.dart';

class CustomCourseSection extends StatefulWidget {
  final Section sections;
  const CustomCourseSection({Key? key, required this.sections})
      : super(key: key);

  @override
  State<CustomCourseSection> createState() => _CustomCourseSectionState();
}

class _CustomCourseSectionState extends State<CustomCourseSection> {
  List<Lecon> lecons = [];
  CourseManagerService courseManagerService = CourseManagerService();

  @override
  void initState() {
    super.initState();
    getAllLecons();
  }

  void getAllLecons() async {
    lecons = await courseManagerService.getAllLecons(context, widget.sections);
    setState(() {
      print(lecons.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: lecons == null
          ? Loader()
          : lecons.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.sections.titre),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.more_horiz))
                        ],
                      ),
                      // BOuble pour afficher le nombre de lecons appartenant à cette section
                      for (int i = 0; i < lecons.length; i++)
                        CustomCourseLecon(
                          lecon: lecons[i],
                        ),

                      // ListView.builder(
                      //     itemCount: lecons.length,
                      //     itemBuilder: (context, i) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(
                      //           top: 35.0,
                      //         ),
                      //         child: CustomCourseLecon(),
                      //       );
                      //     }),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.sections.titre),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.more_horiz))
                        ],
                      ),
                      // BOuble pour afficher le nombre de lecons appartenant à cette section
                      for (int i = 0; i < lecons.length; i++)
                        CustomCourseLecon(
                          lecon: lecons[i],
                        ),

                      // ListView.builder(
                      //     itemCount: lecons.length,
                      //     itemBuilder: (context, i) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(
                      //           top: 35.0,
                      //         ),
                      //         child: CustomCourseLecon(),
                      //       );
                      //     }),
                    ],
                  ),
                ),
    );
  }
}
