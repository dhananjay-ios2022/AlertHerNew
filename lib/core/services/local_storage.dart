import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LocalStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _selectedLanguage = 'language_abbr';
  static const String _token = 'auth_token';
  static const String _name = 'name';
  static const String _email = 'email';
  static const String _phoneNoCountry = 'phone_no_country_code';
  static const String _phoneNo = 'phone_no';
  static const String _gender = 'gender';
  static const String _nationality = 'nationality';
  static const String _loginBy = 'login_by';
  // Remember data
  static const String _emailRemember = 'email_remember';
  static const String _passwordRemember = 'password_remember';
  // Is Default Language Selected

  static const String isLanguageSelectShow = 'language_default';

  //Subscription data
  static const String _id = 'id';
  static const String _title = 'title';
  static const String _des = 'des';
  static const String _currencyCode = 'currencyCode';
  static const String _currencySymbol = 'currencySymbol';
  static const String _duration = "0";
  static const String _price = "0";
  static const String _rawPrice = "0";
  static const String _durationType = 'durationType';
  static const String _subStart = '_subStart';
  static const String _subEnd = '_subEnd';
  static const String _subStatus = "false";




  Future<void> saveAuth(String token) async {
    await _storage.write(key: _token, value: token);
  }

  Future<void> saveLanguage(String language) async {
    await _storage.write(key: _selectedLanguage, value: language);
  }

  // Future<void> subscribeStatus(String subscribeStatus) async {
  //   await _storage.write(key: _subscribeStatus, value: subscribeStatus);
  // }
  //
  // Future<String?> getSubscribeStatus() async {
  //   return await _storage.read(key: _subscribeStatus);
  // }

  Future<void> logout() async {
    await _storage.delete(key: _token);
    await _storage.delete(key: _name);
    await _storage.delete(key: _email);
    await _storage.delete(key: _phoneNoCountry);
    await _storage.delete(key: _phoneNo);
    await _storage.delete(key: _gender);
    await _storage.delete(key: _nationality);
    await _storage.delete(key: _loginBy);
    await _storage.delete(key: _subEnd);
    await _storage.delete(key: _subStart);
    await _storage.delete(key: _subStatus);
    await _storage.delete(key: _id);
    await _storage.delete(key: _title);
    await _storage.delete(key: _des);
    await _storage.delete(key: _currencyCode);
    await _storage.delete(key: _currencySymbol);
    await _storage.delete(key: _duration);
    await _storage.delete(key: _price);
    await _storage.delete(key: _rawPrice);


  }

  Future<bool> isDefaultLanguageSelected() async {
    final language = await _storage.read(key: isLanguageSelectShow);
    return language != null;
  }

  Future<void> saveLanguagePageShow(String language) async {
    await _storage.write(key: isLanguageSelectShow, value: language);
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: _token);
    return token != null;
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _token);
  }

  Future<String?> getSelectedLanguage() async {
    return await _storage.read(key: _selectedLanguage);
  }

  Future<void> saveUserInfo({
    String? token,
    String? name,
    String? email,
    String? countryCode,
    String? phoneNo,
    String? gender,
    String? nationality,
    String? loginBy,

  }) async {
    if (token != null) {
      await _storage.write(key: _token, value: token);
    }

    if (name != null) {
      await _storage.write(key: _name, value: name);
    }
    if (email != null) {
      await _storage.write(key: _email, value: email);
    }
    if (countryCode != null) {
      await _storage.write(key: _phoneNoCountry, value: countryCode);
    }
    if (phoneNo != null) {
      await _storage.write(key: _phoneNo, value: phoneNo);
    }
    if (gender != null) {
      await _storage.write(key: _gender, value: gender);
    }
    if (nationality != null) {
      await _storage.write(key: _nationality, value: nationality);
    }
    if (loginBy != null) {
      await _storage.write(key: _loginBy, value: loginBy);
    }
  }

  Future<Map<String, String?>> getAdditionalUserInfo() async {
    final name = await _storage.read(key: _name);
    final email = await _storage.read(key: _email);
    final countryCode = await _storage.read(key: _phoneNoCountry);
    final phoneNo = await _storage.read(key: _phoneNo);
    final gender = await _storage.read(key: _gender);
    final nationality = await _storage.read(key: _nationality);
    final loginBy = await _storage.read(key: _loginBy);

    return {
      "name": name,
      "email": email,
      "countryCode": countryCode,
      "phoneNo": phoneNo,
      "gender": gender,
      "nationality": nationality,
      "login_by": loginBy,
    };
  }

  Future<void> saveUserRemember({
    String? email,
    String? password,
  }) async {
    if (email != null) {
      await _storage.write(key: _emailRemember, value: email);
    }
    if (password != null) {
      await _storage.write(key: _passwordRemember, value: password);
    }

  }


  Future<Map<String, String?>> getUserRemember() async {
    final email = await _storage.read(key: _emailRemember);
    final password = await _storage.read(key: _passwordRemember);

    return {
      "email_remember": email,
      "password_remember": password,
    };
  }

  Future<void> removeRemember() async {
    await _storage.delete(key: _emailRemember);
    await _storage.delete(key: _passwordRemember);
  }

  Future<void> clearKey(String key) async {
    await _storage.delete(key: key);
  }


  // Future<void> saveSubscribeInfo({
  //   String? id,
  //   String? title,
  //   String? des,
  //   String? currencyCode,
  //   String? currencySymbol,
  //   String? duration,
  //   String? price,
  //   String? rawPrice,
  //   String? durationType,
  //   String? subStart,
  //   String? subEnd,
  //   String? subStatus,
  //
  // }) async {
  //   if (id != null) {
  //     await _storage.write(key: _id, value: id);
  //   }
  //
  //   if (title != null) {
  //     await _storage.write(key: _title, value: title);
  //   }
  //   if (des != null) {
  //     await _storage.write(key: _des, value: des);
  //   }
  //   if (currencyCode != null) {
  //     await _storage.write(key: _currencyCode, value: currencyCode);
  //   }
  //   if (currencySymbol != null) {
  //     await _storage.write(key: _currencySymbol, value: currencySymbol);
  //   }
  //   if (duration != null) {
  //     await _storage.write(key: _duration, value: duration);
  //   }
  //   if (price != null) {
  //     await _storage.write(key: _price, value: price);
  //   }
  //   if (rawPrice != null) {
  //     await _storage.write(key: _rawPrice, value: rawPrice);
  //   }
  //   if (durationType != null) {
  //     await _storage.write(key: _durationType, value: durationType);
  //   }
  //   if (subStart != null) {
  //     await _storage.write(key: _subStart, value: subStart);
  //   }
  //   if (subEnd != null) {
  //     await _storage.write(key: _subEnd, value: subEnd);
  //   }
  //   if (subStatus != null) {
  //     await _storage.write(key: _subStatus, value: subStatus);
  //   }
  //
  // }
  //
  // Future<Map<String, String?>> getSubscribeInfo() async {
  //   final id = await _storage.read(key: _id);
  //   final title = await _storage.read(key: _title);
  //   final des = await _storage.read(key: _des);
  //   final currencyCode = await _storage.read(key: _currencyCode);
  //   final currencySymbol = await _storage.read(key: _currencySymbol);
  //   final duration = await _storage.read(key: _duration);
  //   final price = await _storage.read(key: _price);
  //   final rawPrice = await _storage.read(key: _rawPrice);
  //   final durationType = await _storage.read(key: _durationType);
  //   final subStart = await _storage.read(key: _subStart);
  //   final subEnd = await _storage.read(key: _subEnd);
  //   final subStatus = await _storage.read(key: _subStatus);
  //
  //
  //   return {
  //     "id": id,
  //     "title": title,
  //     "des": des,
  //     "currencyCode": currencyCode,
  //     "currencySymbol": currencySymbol,
  //     "duration": duration,
  //     "price": price,
  //     "rawPrice": rawPrice,
  //     "durationType": durationType,
  //     "subStart": subStart,
  //     "subEnd": subEnd,
  //     "subStatus": subStatus
  //
  //
  //   };
  // }



}

