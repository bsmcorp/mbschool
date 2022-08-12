import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbschool/common/widgets/custom_button_box.dart';
import 'package:mbschool/common/widgets/custom_heading.dart';
import 'package:mbschool/common/widgets/custom_place_holder.dart';
import 'package:mbschool/common/widgets/custom_textfield.dart';
import 'package:mbschool/common/widgets/custom_title.dart';
import 'package:mbschool/constants/colors.dart';
import 'package:mbschool/constants/global.dart';
import 'package:mbschool/constants/padding.dart';
import 'package:mbschool/constants/utils.dart';
import 'package:mbschool/datas/account_menu_json.dart';
import 'package:mbschool/datas/user_profile.dart';
import 'package:mbschool/features/account/screens/edit_profile_screen.dart';
import 'package:mbschool/features/auth/services/auth_service.dart';
import 'package:mbschool/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void logOut(BuildContext context) {
    accountService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(appPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: spacer,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomHeading(
                      title: "Compte",
                      subTitle: "${user.role == "1" ? "Etudiant" : ""}",
                      color: secondary),
                  // IconButton(onPressed: (){
                  //    Navigator.pushNamed(
                  //                     context, EditProfileScreen.routeName);
                  // }, icon: Icon(Icons.edit, color: primary),)
                  InkWell(
                    hoverColor: primary,
                      onTap: () {
                        Navigator.pushNamed(
                            context, EditProfileScreen.routeName);
                      },
                      child: SvgPicture.asset(
                        assetImg + 'edit_icon.svg', height: 17,
                        color: primary,
                      ))
                ],
              ),
              const SizedBox(
                height: spacer,
              ),
              user.photo.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Image.network(
                        user.photo,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Image.asset(
                            UserProfile['image'].toString(),
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 65, left: 65),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: background,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, EditProfileScreen.routeName);
                                },
                                hoverColor: primary,
                                icon: Icon(
                                  Icons.edit,
                                  color: textBlack,
                                )),
                          ),
                        )
                      ],
                    ),
              const SizedBox(
                height: spacer - 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTitle(
                    title: '${user.nom.toUpperCase()}',
                    extend: false,
                  ),
                ],
              ),
              const SizedBox(
                height: spacer - 40,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //         onTap: () {
              //           Navigator.pushNamed(
              //               context, EditProfileScreen.routeName);
              //         },
              //         child: const Text(
              //           "Modifier profile",
              //           style: TextStyle(color: primary),
              //         ))
              //   ],
              // ),
              const SizedBox(
                height: spacer,
              ),
              const CustomTitle(
                title: "Support",
                extend: false,
              ),
              const SizedBox(
                height: spacer,
              ),
              Column(
                children: List.generate(AccountMenuJson.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CunstomPlaceHolder(
                        title: AccountMenuJson[index]['title']),
                  );
                }),
              ),
              const SizedBox(
                height: spacer,
              ),
              GestureDetector(
                  onTap: () {
                    logOut(context);
                  },
                  child: const CustomButtonBox(title: "Se déconnecter")),
              const SizedBox(
                height: spacer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
