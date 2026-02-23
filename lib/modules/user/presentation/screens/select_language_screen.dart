import 'package:alert_her/core/comman_widgets/network_status.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/comman_widgets/text_heading.dart';
import 'package:alert_her/core/constants/app_strings.dart';
import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/services/local_storage.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class SelectLanguageScreen extends StatefulWidget {
  final Function(Locale,String) onChangeLanguage;
  const SelectLanguageScreen({super.key, required this.onChangeLanguage});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SB.h(25),
              TextHeading(
                text: AppLocalizations.of(context).translate('chooseYourPreferredLanguage'),
                fontWeight: FontWeight.w800,
                fontSize: 26,
                color: MyColors.black,
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
              PrimaryButton(
                buttonText: AppLocalizations.of(context).translate('continue'),
                fontWeight: FontWeight.w600,
                isLoading: false,
                onPressed: () async {
                  if (_selectedLanguage != null) {
                    final selectedLang = _languages.firstWhere((element) => element['name'] == _selectedLanguage);
                    widget.onChangeLanguage(Locale(selectedLang['code']),"select");
                    await LocalStorage().saveLanguagePageShow("save");
                    // _saveSelectedLanguage(selectedLang['code']);

                  }

                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const NetworkStatus(),
      ),
    );
  }
}

