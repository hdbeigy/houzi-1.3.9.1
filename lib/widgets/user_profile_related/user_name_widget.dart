import 'package:flutter/material.dart';
import 'package:jakojast/common/constants.dart';
import 'package:jakojast/files/app_preferences/app_preferences.dart';
import 'package:jakojast/files/generic_methods/utility_methods.dart';
import 'package:jakojast/pages/home_screen_drawer_menu_pages/user_related/user_signin.dart';
import 'package:jakojast/widgets/button_widget.dart';
import 'package:jakojast/widgets/generic_text_widget.dart';

class UserNameWidget extends StatelessWidget {
  final bool isUserLogged;
  final String userName;

  const UserNameWidget({
    Key? key,
    required this.isUserLogged,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isUserLogged ?
    Container(
      padding: const EdgeInsets.all(15),
      child: ButtonWidget(
        text: UtilityMethods.getLocalizedString("log_in_to_your_account"),
        onPressed: () => onLogInTap(context)),
    ) : Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GenericTextWidget(
        userName,
        style: AppThemePreferences().appTheme.heading01TextStyle,
      ),
    );
  }

  onLogInTap(BuildContext context) {
    UtilityMethods.navigateToRoute(
      context: context,
      builder: (context) => UserSignIn(
            (String closeOption) {
          if (closeOption == CLOSE) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
