import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'text_sub_heading.dart';
import '../utils/sb.dart';

class FreeTrialDialog extends StatelessWidget {
  final String heading;
  final String subHeading;

  const FreeTrialDialog({
    Key? key,
    required this.heading,
    required this.subHeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Consumer<AuthViewModel>(builder: (mContext, authVM, child) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Center(
                          child: TextSubHeading(
                    text: heading,
                    fontSize: 18,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    color: MyColors.black,
                  ))),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.clear,
                        size: 25,
                        weight: 2,
                      ))
                ],
              ),
              SB.h(20),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8),
                child: TextSubHeading(
                  text: subHeading,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: MyColors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              SB.h(10),
            ],
          ),
        );
      }),
    );
  }
}
