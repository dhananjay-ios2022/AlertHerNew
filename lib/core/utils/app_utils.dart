import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      print('Could not launch $launchUri: $e');
    }
  }

  static Future<void> openWhatsAppChat(BuildContext context, String phoneNumber) async {
    try {
      final Uri whatsappURL = Uri.parse('https://wa.me/$phoneNumber');
      if (!await launchUrl(whatsappURL)) {
        throw Exception('Could not launch $whatsappURL');
      }
    } catch (e) {
      String errorMessage;
      if (e is PlatformException &&
          e.code == 'ACTIVITY_NOT_FOUND') {
        errorMessage = 'WhatsApp is not installed on your device.';
      } else {
        errorMessage = 'An unexpected error occurred while trying to launch WhatsApp.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  static Future<void> launchThisURL(BuildContext context, String url) async {
    try {
      final Uri viewProposalURL = Uri.parse(url);
      if (!await launchUrl(viewProposalURL)) {
        throw Exception('Could not launch $viewProposalURL');
      }
    } catch (e) {
      SnackbarManager().showTopSnack(context, "Unable to launch this url");
    }
  }

  static Future<void> openEmail(BuildContext context, String email, String subject, String body) async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
      );

      if (!await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $emailLaunchUri');
      }
    } catch (e) {
      SnackbarManager().showTopSnack(context, "Unable to launch this mail app");
    }
  }

  static String? detectAndCleanCountryCode({
    required String text,
    required List<String> validCountryCodes,
    required void Function(String countryCode) onCountryCodeDetected,
  }) {
    text = text.trim();
    final countryCodePattern = RegExp(r'^\+(\d{1,3})');
    final match = countryCodePattern.firstMatch(text);

    if (match != null) {
      final code = "+${match.group(1)}";
      if (validCountryCodes.contains(code)) {
        onCountryCodeDetected(code);
        return text
            .replaceFirst(code, '')
            .replaceAll('-', '')
            .replaceAll('_', '')
            .trim();
      }
    }
    return null;
  }

  static const validCountryCodes = [
    '+1', // United States, Canada
    '+91', // India
    '+44', // United Kingdom
    '+61', // Australia
    '+49', // Germany
    '+33', // France
    '+86', // China
    '+81', // Japan
    '+82', // South Korea
    '+39', // Italy
    '+7', // Russia
    '+34', // Spain
    '+55', // Brazil
    '+27', // South Africa
    '+63', // Philippines
    '+62', // Indonesia
    '+92', // Pakistan
    '+66', // Thailand
    '+20', // Egypt
    '+98', // Iran
    '+31', // Netherlands
    '+45', // Denmark
    '+46', // Sweden
    '+47', // Norway
    '+48', // Poland
    '+32', // Belgium
    '+52', // Mexico
    '+64', // New Zealand
    '+60', // Malaysia
    '+65', // Singapore
    '+93', // Afghanistan
    '+355', // Albania
    '+213', // Algeria
    '+376', // Andorra
    '+244', // Angola
    '+672', // Antarctica
    '+54', // Argentina
    '+374', // Armenia
    '+994', // Azerbaijan
    '+973', // Bahrain
    '+880', // Bangladesh
    '+375', // Belarus
    '+501', // Belize
    '+229', // Benin
    '+975', // Bhutan
    '+591', // Bolivia
    '+387', // Bosnia and Herzegovina
    '+267', // Botswana
    '+673', // Brunei
    '+359', // Bulgaria
    '+226', // Burkina Faso
    '+257', // Burundi
    '+855', // Cambodia
    '+237', // Cameroon
    '+238', // Cape Verde
    '+236', // Central African Republic
    '+235', // Chad
    '+56', // Chile
    '+57', // Colombia
    '+242', // Congo
    '+243', // Congo, Democratic Republic of the
    '+506', // Costa Rica
    '+385', // Croatia
    '+53', // Cuba
    '+357', // Cyprus
    '+420', // Czech Republic
    '+253', // Djibouti
    '+593', // Ecuador
    '+503', // El Salvador
    '+240', // Equatorial Guinea
    '+291', // Eritrea
    '+372', // Estonia
    '+251', // Ethiopia
    '+679', // Fiji
    '+358', // Finland
    '+679', // Fiji
    '+995', // Georgia
    '+233', // Ghana
    '+350', // Gibraltar
    '+30', // Greece
    '+299', // Greenland
    '+502', // Guatemala
    '+224', // Guinea
    '+245', // Guinea-Bissau
    '+592', // Guyana
    '+509', // Haiti
    '+504', // Honduras
    '+36', // Hungary
    '+354', // Iceland
    '+62', // Indonesia
    '+964', // Iraq
    '+353', // Ireland
    '+972', // Israel
    '+39', // Italy
    '+1876', // Jamaica
    '+81', // Japan
    '+962', // Jordan
    '+254', // Kenya
    '+686', // Kiribati
    '+383', // Kosovo
    '+965', // Kuwait
    '+996', // Kyrgyzstan
    '+856', // Laos
    '+371', // Latvia
    '+961', // Lebanon
    '+266', // Lesotho
    '+218', // Libya
    '+423', // Liechtenstein
    '+370', // Lithuania
    '+352', // Luxembourg
    '+389', // Macedonia
    '+261', // Madagascar
    '+265', // Malawi
    '+60', // Malaysia
    '+960', // Maldives
    '+223', // Mali
    '+356', // Malta
    '+692', // Marshall Islands
    '+222', // Mauritania
    '+230', // Mauritius
    '+52', // Mexico
    '+691', // Micronesia
    '+373', // Moldova
    '+377', // Monaco
    '+976', // Mongolia
    '+382', // Montenegro
    '+212', // Morocco
    '+258', // Mozambique
    '+264', // Namibia
    '+977', // Nepal
    '+31', // Netherlands
    '+64', // New Zealand
    '+505', // Nicaragua
    '+227', // Niger
    '+234', // Nigeria
    '+47', // Norway
    '+968', // Oman
    '+92', // Pakistan
    '+507', // Panama
    '+595', // Paraguay
    '+51', // Peru
    '+63', // Philippines
    '+48', // Poland
    '+351', // Portugal
    '+974', // Qatar
    '+40', // Romania
    '+7', // Russia
    '+250', // Rwanda
    '+685', // Samoa
    '+966', // Saudi Arabia
    '+221', // Senegal
    '+381', // Serbia
    '+248', // Seychelles
    '+232', // Sierra Leone
    '+65', // Singapore
    '+421', // Slovakia
    '+386', // Slovenia
    '+27', // South Africa
    '+34', // Spain
    '+94', // Sri Lanka
    '+249', // Sudan
    '+597', // Suriname
    '+46', // Sweden
    '+41', // Switzerland
    '+963', // Syria
    '+886', // Taiwan
    '+255', // Tanzania
    '+66', // Thailand
    '+228', // Togo
    '+216', // Tunisia
    '+90', // Turkey
    '+256', // Uganda
    '+44', // United Kingdom
    '+1', // United States
    '+598', // Uruguay
    '+998', // Uzbekistan
    '+678', // Vanuatu
    '+58', // Venezuela
    '+84', // Vietnam
    '+260', // Zambia
    '+263', // Zimbabwe
  ];

}