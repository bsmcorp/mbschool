import 'package:flutter/material.dart';
import 'package:mbschool/common/animations/opacity_tween.dart';
import 'package:mbschool/common/animations/slide_right_tween.dart';
import 'package:mbschool/common/animations/slide_up_tween.dart';
import 'package:mbschool/common/widgets/custom_app_bar.dart';
import 'package:mbschool/common/widgets/custom_course_card.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_my_courses_card.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/datas/courses_json.dart';
import 'package:mbschool/features/course/screens/detail_course_screen.dart';
import 'package:mbschool/features/panel/course_manager/services/course_manager_service.dart';
import 'package:mbschool/models/cours.dart';

class AllCourseScreen extends StatefulWidget {
  static const routeName = '/all-course-screen';
   AllCourseScreen({Key? key,  required this.cours}) : super(key: key);
   List<Cours> cours =[];

  @override
  State<AllCourseScreen> createState() => _AllCourseScreenState();
}

class _AllCourseScreenState extends State<AllCourseScreen> {
  // CourseManagerService courseManagerService = CourseManagerService();
  // List<Cours> cours = [];
  // @override
  // void initState() {
  //   getAllCourses();

  //   super.initState();
  // }

  // void getAllCourses() async {
  //   cours = await courseManagerService.getAllCourses(context);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            action: true,
            actionIcon: 'search_icon.svg',
          ),
          preferredSize: Size.fromHeight(40)),
      body: widget.cours == null
          ? Loader()
          : widget.cours.isNotEmpty
              ? getBody()
              : Center(child: Text("Pas d'informations")),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: spacer,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const CustomHeading(
                //     title: "Tous les cours",
                //     subTitle: "Reprenons",
                //     color: textBlack),
                SlideUpTween(
                  offset: 40,
                  child: Text(
                    "${widget.cours.length} Cours",
                    style: const TextStyle(
                      fontSize: 20,
                      color: secondary,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: spacer,
            ),
            Column(
              children: List.generate(widget.cours.length, (index) {
                return SlideRightTween(
                  duration: Duration(milliseconds: index* 500),
                  curve: Curves.easeInOutCubic,
                  offset: 80,
                  child: OpacityTween(
                    begin: 0,
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, DetailCourseScreen.routeName,
                                  arguments: widget.cours[index]);
                            },
                            child: CustomCourseCardShrink(
                                thumbNail: widget.cours[index].vignette,
                                title: widget.cours[index].titre,
                                nom: widget.cours[index].nom,
                                prenom: widget.cours[index].prenom,
                                price: widget.cours[index].prix.isEmpty
                                    ? "Gratuit"
                                    : widget.cours[index].prix))),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
