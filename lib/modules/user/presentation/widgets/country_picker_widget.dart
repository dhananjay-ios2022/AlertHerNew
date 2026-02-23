import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryPickerWidget extends StatelessWidget {
  final String initialCode;
  final ValueChanged<String> onCountrySelected;
  final bool isEnable;
  final Color bgColor;
  final double radius;

  const CountryPickerWidget({
    Key? key,
    required this.initialCode,
    required this.onCountrySelected,
    this.isEnable = true,
    this.bgColor = MyColors.primaryLight,
    this.radius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? () {
        showCountryPicker(
          context: context,
          countryListTheme: CountryListThemeData(
            inputDecoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate('searchForCountryNameOrDialCode'),
              hintText: AppLocalizations.of(context).translate('typeHere'),
              labelStyle: const TextStyle(
                fontSize: 17,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 1,
                ),
              ),
            ),
            bottomSheetHeight: MediaQuery.of(context).size.height / 2 - 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(0.0),
            ),
          ),
          useSafeArea: true,
          showPhoneCode: true,
          moveAlongWithKeyboard: true,
          onSelect: (Country country) {
            onCountrySelected(country.phoneCode);
          },
        );
      } : null,
      child: Container(
        width: 70,
        height: 50,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: bgColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              initialCode,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SvgPicture.asset(
              height: 24,
              width: 24,
              ConstImages.arrowDropDown,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
