import 'package:flutter/material.dart';
import 'package:jakojast/common/constants.dart';
import 'package:jakojast/files/app_preferences/app_preferences.dart';
import 'package:jakojast/widgets/app_bar_widget.dart';

import 'package:shimmer/shimmer.dart';

import 'package:jakojast/files/generic_methods/utility_methods.dart';

class LoadingPage extends StatelessWidget{
  final String? pageTitleTag;
  final bool showAppBar;
  final bool showBackOption;
  final Function()? onBackPressed;

  LoadingPage({
    Key? key,
    this.pageTitleTag,
    this.showAppBar = false,
    this.showBackOption = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: !showAppBar ? null : AppBarWidget(
        appBarTitle: getTitle(context, pageTitleTag!),
        automaticallyImplyLeading: showBackOption,
        onBackPressed: onBackPressed,
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: AppThemePreferences().appTheme.shimmerEffectBaseColor!,
                  highlightColor: AppThemePreferences().appTheme.shimmerEffectHighLightColor!,
                  enabled: true,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTitle(BuildContext context, String titleTag){
    if(titleTag == filterPageTitleTag){
      return UtilityMethods.getLocalizedString("filters");
    }
    return "";
  }

}