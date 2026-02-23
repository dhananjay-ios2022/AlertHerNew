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

class ContactUsScreen extends StatefulWidget {

  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Consumer<HomeViewModel>(
            builder: (mContext, timelinesViewModel, child) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: MyColors.primaryLight,
                      padding:
                      const EdgeInsets.only(top: 25, left: 17, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: ()=> Navigator.of(context).pop(),
                            child: SvgPicture.asset(
                              ConstImages.backArrow,
                              height: 28,
                              width: 28,
                            ),
                          ),
                          SB.w(20),
                          TextHeading(
                            text: AppLocalizations.of(context).translate('contactUs'),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ConstImages.logo, height: 42, width: 190),
                          SB.h(15),
                          TextSubHeading(
                            text: AppLocalizations.of(context).translate('contactUsContent'),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: MyColors.blackLight,
                            textAlign: TextAlign.center,
                          ),
                          SB.h(30),
                          PrimaryButton(
                            buttonText: AppLocalizations.of(context).translate('contactNow'),
                            fontWeight: FontWeight.w700,
                            textSize: 16,
                            onPressed: () => AppUtils.openEmail(
                              context,
                              AppStrings.contactUsEmail,
                              AppStrings.contactUsSubject,
                              AppStrings.contactUsMsg,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              );
            }),
        bottomNavigationBar: const NetworkStatus(),
      ),
    );
  }


}
