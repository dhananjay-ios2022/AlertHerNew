import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/api_const.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/utils/app_utils.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final bool isSelectedCheckBox1;
  final void Function(bool?) onChangedCheckBox1;
  final bool isSelectedCheckBox2;
  final void Function(bool?) onChangedCheckBox2;
  const AuthFooter({super.key,
    required this.isSelectedCheckBox1,
    required this.onChangedCheckBox1,
    required this.isSelectedCheckBox2,
    required this.onChangedCheckBox2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: MyColors.primary,
              value: isSelectedCheckBox1,
              onChanged: onChangedCheckBox1
            ),
            Expanded(
              child: Wrap(
                alignment : WrapAlignment.start,
                children: [
                  TextSubHeading(
                    text: AppLocalizations.of(context).translate('ByProceedingYouAgreeToAlertHerApp'),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: MyColors.blackLight,
                  ),
                  SB.w(5),
                  TextSubHeading(
                    text: AppLocalizations.of(context).translate('privacyPolicy'),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: MyColors.primaryDark,
                    onTap: () => AppUtils.launchThisURL(context, ApiConst.privacyPolicy),
                  ),
                  TextSubHeading(
                    text: AppLocalizations.of(context).translate(' and'),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: MyColors.blackLight,
                  ),
                  SB.w(5),
                  TextSubHeading(
                    text: AppLocalizations.of(context).translate('tAndC'),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: MyColors.primaryDark,
                    onTap: () => AppUtils.launchThisURL(context, ApiConst.tAndC),
                  ),
                ],
              ),
            ),
          ],
        ),
       // SizedBox(height: 10,),
        Row(
          children: [
            Checkbox(
                activeColor: MyColors.primary,
                value: isSelectedCheckBox2,
                onChanged: onChangedCheckBox2
            ),
            Expanded(
              child: Wrap(
                alignment : WrapAlignment.start,
                children: [
                  TextSubHeading(
                    text: AppLocalizations.of(context).translate('consentText'),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: MyColors.blackLight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
