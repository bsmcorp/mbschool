import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_card.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/features/panel/panel.dart';
import 'package:mbschool/models/cours.dart';

class CourseManagerScreen extends StatefulWidget {
  static const routeName = '/course_manager';
  const CourseManagerScreen({Key? key}) : super(key: key);

  @override
  State<CourseManagerScreen> createState() => _CourseManagerScreenState();
}

class _CourseManagerScreenState extends State<CourseManagerScreen> {
  CourseManagerService courseManagerService = CourseManagerService();
  List<Cours> cours = [];
  @override
  void initState() {
    getAllCourses();

    super.initState();
  }

  void getAllCourses() async {
    cours = await courseManagerService.getAllCourses(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 1,
        title: Text("Gestionnaire de cours"),
      ),
      body: cours == null
          ? Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            )
          : cours.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                      itemCount: cours.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(context, PlanScreen.routeName,
                      arguments:cours[i]),
                          child: CustomCard(cours: cours[i]));
                      }),

                  // child: Column(
                  //   children: [CustomCard()],
                  // ),
                ),
    );
  }
}
