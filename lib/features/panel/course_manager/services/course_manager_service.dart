import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mbschool/constants/error_handling.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/section.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CourseManagerService {
  Future<List<Cours>> getAllCourses(BuildContext context) async {
    List<Cours> coursList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response coursRes = await http.get(
        Uri.parse('$uri/getAllCourses'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: coursRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(coursRes.body).length; i++) {
              coursList.add(
                Cours.fromJson(
                  jsonEncode(
                    jsonDecode(coursRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return coursList;
  }

   Future<List<Section>> getAllSections(BuildContext context, Cours cours) async {
    List<Section> sectionList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response sectionRes = await http.get(
        Uri.parse('$uri/getAllSections/${cours.id_cours}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: sectionRes,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(sectionRes.body).length; i++) {
              sectionList.add(
                Section.fromJson(
                  jsonEncode(
                    jsonDecode(sectionRes.body)[i],
                  ),
                ),
              );
            }
          },
          onFailed: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return sectionList;
  }
}
