import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/app_config.dart';
import '../constants/my_colors.dart';
import 'text_sub_heading.dart';
import '../constants/app_strings.dart';
import '../constants/const_images.dart';
import '../utils/sb.dart';

class BackConfirmationDialog extends StatelessWidget {

  const BackConfirmationDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppDimensions.fixedScreenWidth),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8.0,bottom: 8),
                      child: SvgPicture.asset(
                        ConstImages.close,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(ConstImages.exit, height: 40.0, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(MyColors.primary, BlendMode.srcIn)),
              SB.h(15),
              const Text(
                AppStrings.exitConfirmation,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              SB.h(10),
              const TextSubHeading(
                text: AppStrings.areYouSureYouWantToExit,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: MyColors.blackLight,
                textAlign: TextAlign.center,
              ),
              SB.h(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text(AppStrings.no),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop(true);
                    },
                    child: const Text(AppStrings.yes),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
