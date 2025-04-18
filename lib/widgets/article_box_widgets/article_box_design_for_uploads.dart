import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jakojast/files/app_preferences/app_preferences.dart';
import 'package:jakojast/files/hooks_files/hooks_configurations.dart';
import 'package:jakojast/files/generic_methods/utility_methods.dart';
import 'package:jakojast/models/article.dart';

import 'package:jakojast/widgets/button_widget.dart';
import 'package:jakojast/widgets/custom_widgets/card_widget.dart';
import 'package:jakojast/widgets/generic_text_widget.dart';

class UploadsArticleBox extends StatelessWidget {
  final Article article;
  final int? progress;
  final bool isActiveUpload;

  const UploadsArticleBox({
    super.key,
    required this.article,
    required this.progress,
    required this.isActiveUpload,
  });

  @override
  Widget build(BuildContext context) {
    String _title = UtilityMethods.stripHtmlIfNeeded(article.title!);

    return Container(
      height: 270, //270
      padding: const EdgeInsets.only(bottom: 7.0 , left: 5.0 , right: 5.0 , top: 3.0),
      child: CardWidget(
        color: AppThemePreferences().appTheme.articleDesignItemBackgroundColor,
        shape: AppThemePreferences.roundedCorners(AppThemePreferences.articleDesignRoundedCornersRadius),
        elevation: AppThemePreferences.articleDeignsElevation,
        child: Stack(
          children: <Widget>[
            ImageWidget(imagePath: article.image!),
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleAndUploadStatusWidget(
                    title: _title,
                    isActiveUpload: isActiveUpload,
                    progress: progress,
                  ),
                  // FeaturesAndPriceRow(article: article),
                  // Center(child: GenericTextWidget('${progress ?? 0} %')),
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: 10),
                  //   child: LinearProgressIndicator(
                  //     value: progress != null ? (progress! / 100) : 0,
                  //     color: AppThemePreferences.appPrimaryColor,
                  //   ),
                  // ),
                  // featuresAndPriceRowWidget(article: article),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleAndUploadStatusWidget extends StatelessWidget {
  final String title;
  final bool isActiveUpload;
  final int? progress;

  const TitleAndUploadStatusWidget({
    super.key,
    required this.title,
    required this.isActiveUpload,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(child: TitleWidget(title: title)),
            ],
          ),
          if (!isActiveUpload) Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(child: GenericTextWidget(
                  'Queued',
                  style: TextStyle(color: AppThemePreferences.appPrimaryColor),
                )),
              ],
            ),
          ),
          if (isActiveUpload) Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                Expanded(child: GenericTextWidget('Uploading ${progress ?? 0} %')),
              ],
            ),
          ),
          if (isActiveUpload) Padding(
            padding: EdgeInsets.only(top: 5, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress != null ? (progress! / 100) : 0,
                    color: AppThemePreferences.appPrimaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Expanded(
          //   flex: 2,
          //   child: GenericTextWidget(
          //     isActiveUpload ? 'Uploading' : 'Queued',
          //     style: TextStyle(
          //       color: AppThemePreferences.appPrimaryColor,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}


class FeaturesAndPriceRow extends StatelessWidget {
  final Article article;

  const FeaturesAndPriceRow({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FeaturesWidget(item: article, padding: const EdgeInsets.fromLTRB(0, 0, 0, 0)),
          PriceWidget(item: article),
        ],
      ),
    );
  }
}


class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GenericTextWidget(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppThemePreferences().appTheme.titleTextStyle,
    );
  }
}

class PriceWidget extends StatelessWidget {
  final Article item;

  const PriceWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    String finalPrice = "";

    HidePriceHook hidePrice = HooksConfigurations.hidePriceHook;
    bool hide = hidePrice();
    if(!hide) {
      finalPrice = item.getCompactPrice();
    }

    return GenericTextWidget(
      finalPrice,
      style: AppThemePreferences().appTheme.articleBoxPropertyPriceTextStyle,
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String? imagePath;

  const ImageWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    bool _validURL = (imagePath != null && imagePath!.isNotEmpty) ? true : false;
    return SizedBox(
      height: 165,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: !_validURL ? ErrorWidget() : Image.file(
          File(imagePath!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FeaturesWidget extends StatelessWidget {
  final Article item;
  final EdgeInsetsGeometry? padding;

  const FeaturesWidget({
    super.key,
    required this.item,
    this.padding = const EdgeInsets.fromLTRB(5, 5, 5, 0),
  });

  @override
  Widget build(BuildContext context) {
    String? _area = item.features!.propertyArea;
    String _areaPostFix = item.features!.propertyAreaUnit!;
    String? _bedRooms = item.features!.bedrooms;
    String? _bathRooms = item.features!.bathrooms;

    return Container(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (_bedRooms == null || _bedRooms.isEmpty) ? Container() :  Row(
            children: <Widget>[
              AppThemePreferences().appTheme.articleBoxBedIcon!,
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: GenericTextWidget(
                  _bedRooms,
                  style: AppThemePreferences().appTheme.subBodyTextStyle,
                ),
              ),
            ],
          ),
          (_bathRooms == null || _bathRooms.isEmpty) ? Container() : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              children: <Widget>[
                AppThemePreferences().appTheme.articleBoxBathtubIcon!,
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: GenericTextWidget(
                    _bathRooms,
                    style: AppThemePreferences().appTheme.subBodyTextStyle,
                  ),
                ),
              ],
            ),
          ),
          (_area == null || _area.isEmpty) ? Container() : Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: AppThemePreferences().appTheme.articleBoxAreaSizeIcon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 5),
                child: GenericTextWidget(
                  "$_area $_areaPostFix",
                  style: AppThemePreferences().appTheme.subBodyTextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppThemePreferences().appTheme.shimmerEffectErrorWidgetBackgroundColor,
      child: Center(child: AppThemePreferences().appTheme.shimmerEffectImageErrorIcon),
    );
  }
}
