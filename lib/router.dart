import 'package:flutter/material.dart';
import 'package:mbschool/common/widgets/bottom_bar.dart';
import 'package:mbschool/features/account/screens/account_screen.dart';
import 'package:mbschool/features/account/screens/edit_profile_screen.dart';
import 'package:mbschool/features/auth/screens/auth_screen.dart';
import 'package:mbschool/features/course/screens/course_screen.dart';
import 'package:mbschool/features/explore/screens/explore_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/course_manager_screen.dart';
import 'package:mbschool/features/panel/course_manager/screens/plan_screen.dart';
import 'package:mbschool/features/panel/create_course/screens/create_course_screen.dart';
import 'package:mbschool/main.dart';
import 'package:mbschool/models/cours.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case CourseScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CourseScreen());
    case ExploreScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ExploreScreen());
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());

    case EditProfileScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const EditProfileScreen());

    case AccountScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AccountScreen());

    case CreateCourseScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CreateCourseScreen());

    case CourseManagerScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CourseManagerScreen());

    case PlanScreen.routeName:
      var cours = routeSettings.arguments as Cours;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) =>  PlanScreen(cours: cours));

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("ERREUR 404"),
                ),
              ));
  }
}
