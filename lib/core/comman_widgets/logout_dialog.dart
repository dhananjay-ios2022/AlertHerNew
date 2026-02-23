import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'text_sub_heading.dart';
import '../utils/sb.dart';

class LogoutAndDeleteAccountDialog extends StatelessWidget {
  final String heading;
  final String subHeading;
  final VoidCallback onButtonPressed;

  const LogoutAndDeleteAccountDialog({
    Key? key,
    required this.heading,
    required this.subHeading,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Consumer<AuthViewModel>(
        builder: (mContext, authVM, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 210,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextSubHeading(text: heading,fontSize: 18,fontWeight: FontWeight.w500,color: MyColors.black,),
                SB.h(20),
                TextSubHeading(text: subHeading,fontSize: 13,fontWeight: FontWeight.w400,color: MyColors.black,textAlign: TextAlign.center,),
                SB.h(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        bgColor: MyColors.gray,
                        buttonText: AppLocalizations.of(context).translate('No'),
                        fontWeight: FontWeight.w700,
                        textColor: MyColors.black,
                        textSize: 16,
                        isLoading: false,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    SB.w(10),
                    Expanded(
                      child: PrimaryButton(
                        buttonText: AppLocalizations.of(context).translate('Yes'),
                        fontWeight: FontWeight.w700,
                        textSize: 16,
                        isLoading: authVM.isLoading,
                        onPressed: onButtonPressed,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
    );
  }
}
