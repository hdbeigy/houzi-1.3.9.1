import 'package:flutter/material.dart';
import 'package:jakojast/files/generic_methods/utility_methods.dart';
import 'package:jakojast/widgets/button_widget.dart';
import 'package:jakojast/widgets/custom_widgets/text_button_widget.dart';
import 'package:jakojast/widgets/dialog_box_widget.dart';
import 'package:jakojast/widgets/generic_text_widget.dart';

class DeleteAccountButtonWidget extends StatelessWidget {
  final void Function()? onPressed;

  const DeleteAccountButtonWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      buttonStyle:
      ElevatedButton.styleFrom(
        elevation: 0.0, backgroundColor: const Color(0xFFFF0000),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      // ElevatedButton.styleFrom(elevation: 0.0, primary: AppThemePreferences.errorColor),
      text: UtilityMethods.getLocalizedString("delete_my_account"),
      onPressed: () async {
        ShowDialogBoxWidget(
          context,
          title: UtilityMethods.getLocalizedString("delete_account"),
          content: GenericTextWidget(UtilityMethods.getLocalizedString("delete_account_confirmation")),
          actions: <Widget>[
            TextButtonWidget(
              onPressed: () => Navigator.pop(context),
              child: GenericTextWidget(UtilityMethods.getLocalizedString("cancel")),
            ),
            TextButtonWidget(
              onPressed: onPressed,
              child: GenericTextWidget(UtilityMethods.getLocalizedString("yes")),
            ),
          ],
        );
      },
    );
  }
}