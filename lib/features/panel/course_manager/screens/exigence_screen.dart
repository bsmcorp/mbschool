import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mbschool/common/widgets/custom_app_bar_panel.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_button_box_panel.dart';
import 'package:mbschool/common/widgets/custom_textfield_exigence.dart';
import 'package:mbschool/common/widgets/loader.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/features/panel/course_manager/services/exigence_service.dart';
import 'package:mbschool/models/cours.dart';
import 'package:mbschool/models/exigence.dart';

class ExigenceScreen extends StatefulWidget {
  static const routeName = 'exigence-screen';
  final Cours cours;
  const ExigenceScreen({Key? key, required this.cours}) : super(key: key);

  @override
  State<ExigenceScreen> createState() => _ExigenceScreenState();
}

class _ExigenceScreenState extends State<ExigenceScreen> {
  final controllers = <TextEditingController>[];
  TextEditingController? control;
  List<CustomTextFieldExigence> _listExigences = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  bool isCharging = false;
  ExigenceService exigenceService = ExigenceService();
  List<Exigence> exigences = [];
  final _addExigenceFormKey = GlobalKey<FormState>();


  void addExigence() {
    for (int i = 0; i < _listExigences.length; i++)
      exigenceService.addExigence(
          context, _listExigences[i].controller!.text, widget.cours, () {
        setState(() {
          isCharging = false;
        });
      });

    showSnackBar(context, "Exigences ajoutées avec succès");
  }

  void getAllExigences() async {
    exigences = await exigenceService.getAllExigences(context, widget.cours);
    print(exigences.length);
  }

  @override
  void initState() {
    super.initState();
    getAllExigences();
    setState(() {});
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // void _addCourseExigence() {
  //   _listExigences.insert(
  //       0, "Ajouter une exigence ${_listExigences.length + 1}");
  //   _key.currentState!.insertItem(
  //     0,
  //     duration: const Duration(seconds: 1),
  //   );
  // }

  // void _removeCourseExigence(int index) {
  //   _key.currentState!.removeItem(
  //     index,
  //     (_, animation) {
  //       return SizeTransition(
  //           sizeFactor: animation,
  //           child: Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: 50,
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.all(Radius.circular(8)),
  //                 color: Colors.red),
  //             child: Center(
  //               child: Text(
  //                 "Supprimé",
  //                 style: TextStyle(color: Colors.white, fontSize: 25),
  //               ),
  //             ),
  //           ));
  //     },
  //     duration: const Duration(milliseconds: 300),
  //   );
  //   _listExigences.removeAt(index);
  // }

  void _removeCourseExigence(int index) {
    AnimatedContainer(
      duration: Duration(seconds: 3),
      curve: Curves.easeInOut,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          "Supprimé",
          style: TextStyle(color: textWhite),
        ),
      ),
    );
    _listExigences.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < exigences.length; i++) {
      final control = TextEditingController();
      control.text = exigences[i].nom;
      setState(() {
        _listExigences.add(
            CustomTextFieldExigence(hintText: "Exigence", controller: control));
        controllers.add(control);
      });
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBarPanel(texte: "Exigences"),
        body: isCharging == true || exigences == null
            ? Loader()
            : Form(
                key: _addExigenceFormKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding - 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // IconButton(
                        //     onPressed: _addCourseExigence,
                        //     icon: const Icon(
                        //       Icons.add,
                        //       color: primary,
                        //     )),
                        // Expanded(
                        //   child: AnimatedList(
                        //     key: _key,
                        //     initialItemCount: 0,
                        //     padding: const EdgeInsets.all(10),
                        //     itemBuilder: (context, index, animation) {
                        //       final controller =
                        //           TextEditingController();
                        //       return SizeTransition(
                        //         key: UniqueKey(),
                        //         sizeFactor: animation,
                        //         child: Row(
                        //           children: [
                        //             CustomTextFieldExigence(
                        //                 hintText: "${_listExigences[index]}",
                        //                 controller: controller),
                        //             IconButton(
                        //               onPressed: () {
                        //                 _removeCourseExigence(index);
                        //               },
                        //               icon: Icon(
                        //                 Icons.do_not_disturb_on,
                        //                 color: Colors.red,
                        //               ),
                        //               iconSize: 30,
                        //             )
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),

                        for (int i = 0; i < _listExigences.length; i++)
                          Row(
                            children: [
                              _listExigences[i],
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    // selected = !selected;
                                    _listExigences.removeAt(i);
                                  });
                                },
                                icon: Icon(
                                  Icons.do_not_disturb_on,
                                  color: Colors.red,
                                ),
                                iconSize: 30,
                              )
                            ],
                          ),

                        Row(
                          children: [
                            InkWell(
                                splashColor: textBlack,
                                onTap: () {
                                  final controller = TextEditingController();

                                  setState(() {
                                    controllers.add(controller);
                                    _listExigences.add(CustomTextFieldExigence(
                                        hintText: "Exigence",
                                        controller: controller));
                                  });
                                },
                                child: CustomButtonBoxPanel(
                                  title: "+Ajouter",
                                  width: 100,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (_addExigenceFormKey.currentState!
                                    .validate()) {
                                  print(_listExigences.length);
                                  setState(() {
                                    isCharging = true;
                                    addExigence();
                                  });
                                }
                              },
                              splashColor: textBlack,
                              child: CustomButtonBoxPanel(
                                title: "Envoyer",
                                width: 100,
                              ),
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(appPadding - 5),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       CustomTextFieldExigence(
                        //           hintText: "Saisir exigence",
                        //           controller: exigenceController),
                        //       IconButton(
                        //         onPressed: () {},
                        //         icon: Icon(
                        //           Icons.do_not_disturb_on,
                        //           color: Colors.red,
                        //         ),
                        //         iconSize: 30,
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
