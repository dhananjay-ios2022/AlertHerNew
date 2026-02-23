import 'dart:ui' as ui;
import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/app_strings.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/services/local_storage.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UpdateLanguageScreen extends StatefulWidget {
  final Function(Locale,String) onChangeLanguage;
  const UpdateLanguageScreen({super.key, required this.onChangeLanguage});

  @override
  State<UpdateLanguageScreen> createState() => _UpdateLanguageScreenState();
}

class _UpdateLanguageScreenState extends State<UpdateLanguageScreen> {
  final List<Map<String, dynamic>> _languages = [
    {'name': AppStrings.english, 'code': 'en', 'icon': ConstImages.en},
    {'name': AppStrings.thai, 'code': 'th', 'icon': ConstImages.th},
    {'name': AppStrings.chinese, 'code': 'zh', 'icon': ConstImages.zh},
    {'name': AppStrings.vietnamese, 'code': 'vi', 'icon': ConstImages.vi},
    {'name': AppStrings.german, 'code': 'de', 'icon': ConstImages.de},
    {'name': AppStrings.spanish, 'code': 'es', 'icon': ConstImages.es},
    {'name': AppStrings.romanian, 'code': 'ro', 'icon': ConstImages.ro},
  ];

  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    String? savedLanguage = await LocalStorage().getSelectedLanguage();
    if (savedLanguage != null) {
      setState(() {
        _selectedLanguage = _languages.firstWhere((element) => element['code'] == savedLanguage)['name'];
      });
    } else {
      final ui.Locale systemLocale = ui.window.locale;
      setState(() {
        _selectedLanguage = _languages.firstWhere((element) => element['code'] == systemLocale.languageCode)['name'];
      });
    }
  }

  Future<void> _saveSelectedLanguage(String languageCode) async {
    await LocalStorage().saveLanguage(languageCode);
  }

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
                            text: AppLocalizations.of(context).translate('updatePreferredLanguage'),
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
                      padding:
                      const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHeading(
                            text: AppLocalizations.of(context).translate('changeYourLanguage'),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: MyColors.blackLight,
                          ),
                          SB.h(20),
                          Expanded(
                            child: GridView.builder(
                              itemCount: _languages.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.4,
                              ),
                              itemBuilder: (context, index) {
                                final language = _languages[index];
                                final isSelected = _selectedLanguage == language['name'];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedLanguage = language['name'];
                                    });
                                  },
                                  child: Card(
                                    color: isSelected ? MyColors.primaryLight : MyColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                        color: isSelected ? MyColors.primaryDark : MyColors.gray,
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: isSelected ? MyColors.white : MyColors.gray,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              language['icon'],
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                        SB.h(10),
                                        Text(
                                          language['name'],
                                          style: const TextStyle(
                                            color: MyColors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
              child: PrimaryButton(
                bgColor: MyColors.orange,
                buttonText: AppLocalizations.of(context).translate('changeLanguage'),
                fontWeight: FontWeight.w700,
                textSize: 16,
                isLoading: false,
                onPressed: () {
                  if (_selectedLanguage != null) {
                    final selectedLang = _languages.firstWhere((element) => element['name'] == _selectedLanguage);
                    widget.onChangeLanguage(Locale(selectedLang['code']),"update");
                    // _saveSelectedLanguage(selectedLang['code']);
                  }
                },
              ),
            ),
            const NetworkStatus(),
          ],
        ),
      ),
    );
  }
}


Widget optionRow(
    BuildContext context, {
      required String icon,
      required String text,
      bool isDevider = true,
      required VoidCallback onTap,
    }) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(icon,
                    height: 35,
                    width: 35,),
                  SB.w(10),
                  TextSubHeading(
                    text: text,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: MyColors.black,
                  ),

                ],
              ),
              SB.w(15), // Spacing
              SvgPicture.asset(ConstImages.rightArrow,
                height: 24,
                width: 24,),
            ],
          ),
        ),
      ),
      SB.h(10),
      if(isDevider)
      const Divider(
        color: MyColors.gray,
      ),
    ],
  );
}