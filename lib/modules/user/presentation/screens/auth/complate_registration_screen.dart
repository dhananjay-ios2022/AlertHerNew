import 'dart:async';

import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/routes/routes.dart';
import 'package:alert_her/core/services/local_storage.dart';
import 'package:alert_her/core/utils/app_extension.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ComplateRegistrationScreen extends StatefulWidget {
  const ComplateRegistrationScreen({super.key});

  @override
  State<ComplateRegistrationScreen> createState() =>
      _ComplateRegistrationScreenState();
}

class _ComplateRegistrationScreenState
    extends State<ComplateRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryLight,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: MyColors.lightPink,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Lottie.asset(ConstImages.successAnim,
                          fit: BoxFit.fill, repeat: false),
                  ),
                  SB.h(40),
                  TextHeading(
                    text: AppLocalizations.of(context)
                        .translate('registrationComplete'),
                    fontWeight: FontWeight.w700,
                    fontSize: 27,
                    color: MyColors.primary,
                    fontFamily: 'meno_banner',
                  ),
                  SB.h(15),
                  TextSubHeading(
                    text: AppLocalizations.of(context)
                        .translate('yourAccountHasBeenSuccessfullyCreated'),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: MyColors.blackLight,
                    textAlign: TextAlign.center,
                  ),
                  SB.h(20),
                  TextSubHeading(
                    text: AppLocalizations.of(context)
                        .translate('thankYouForJoiningUs'),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: MyColors.orange,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 50),
              child: PrimaryButton(
                buttonText: AppLocalizations.of(context).translate('letStart'),
                isLoading: false,
                onPressed: () => context.pushReplacement(Routes.home, extra: {
                  'callFrom': "letStart",
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
