import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/app_strings.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/utils/app_utils.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Consumer<HomeViewModel>(
            builder: (mContext, timelinesViewModel, child) {
              List faqList = [
                {
                  "question": AppLocalizations.of(context).translate('Q1'),
                  "answer":
                  AppLocalizations.of(context).translate('A1'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q2'),
                  "answer":
                  AppLocalizations.of(context).translate('A2'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q3'),
                  "answer":
                  AppLocalizations.of(context).translate('A3'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q4'),
                  "answer":
                  AppLocalizations.of(context).translate('A4'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q5'),
                  "answer":
                  AppLocalizations.of(context).translate('A5'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q6'),
                  "answer":
                  AppLocalizations.of(context).translate('A6'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q7'),
                  "answer":
                  AppLocalizations.of(context).translate('A7'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q8'),
                  "answer":
                  AppLocalizations.of(context).translate('A8'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q9'),
                  "answer":
                  AppLocalizations.of(context).translate('A9'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q10'),
                  "answer":
                  AppLocalizations.of(context).translate('A10'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q11'),
                  "answer":
                  AppLocalizations.of(context).translate('A11'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q12'),
                  "answer":
                  AppLocalizations.of(context).translate('A12'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q13'),
                  "answer":
                  AppLocalizations.of(context).translate('A13'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q14'),
                  "answer":
                  AppLocalizations.of(context).translate('A14'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q15'),
                  "answer":
                  AppLocalizations.of(context).translate('A15'),
                },
                {
                  "question": AppLocalizations.of(context).translate('Q16'),
                  "answer":
                  AppLocalizations.of(context).translate('A16'),
                },
              ];
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: MyColors.primaryLight,
                  padding: const EdgeInsets.only(top: 25, left: 17, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(
                          ConstImages.backArrow,
                          height: 28,
                          width: 28,
                        ),
                      ),
                      SB.w(20),
                      TextHeading(
                        text: AppLocalizations.of(context).translate('faq'),
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: MyColors.black,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 70,
                left: 0,
                right: 0,
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ListView.builder(
                      itemCount: faqList.length,
                      itemBuilder: (context, index) {
                        var item = faqList[index];
                        return Column(
                          children: [
                            Theme(
                              data: ThemeData()
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                dense: true,
                                textColor: MyColors.black,
                                title: Text(item["question"],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'roboto')),
                                children: <Widget>[
                                  ListTile(
                                      title: Text(item["answer"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'roboto'))),
                                ],
                              ),
                            ),
                            Divider(
                              color: MyColors.grayDark,
                            )
                          ],
                        );
                      },
                    )),
              ),
            ],
          );
        }),
        bottomNavigationBar: const NetworkStatus(),
      ),
    );
  }
}
