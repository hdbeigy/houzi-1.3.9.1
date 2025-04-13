import 'package:flutter/material.dart';
import 'package:jakojast/files/app_preferences/app_preferences.dart';
import 'package:jakojast/files/generic_methods/utility_methods.dart';
import 'package:jakojast/widgets/generic_text_widget.dart';

class FeaturedTagWidget extends StatelessWidget {
  const FeaturedTagWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5,3,5,5),
      child: GenericTextWidget(
        UtilityMethods.getLocalizedString("featured_tag"),
        strutStyle: const StrutStyle(forceStrutHeight: true),
        style: AppThemePreferences().appTheme.featuredTagTextStyle,
      ),
      decoration: BoxDecoration(
        color: AppThemePreferences().appTheme.featuredTagBackgroundColor,
        border: Border.all(color: AppThemePreferences().appTheme.featuredTagBorderColor!),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}
