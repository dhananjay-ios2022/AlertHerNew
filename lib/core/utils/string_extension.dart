String cleanName(String name) {
  return name.trim().replaceAll(RegExp(r'\s+'), ' ');
}

String capitalizeEachWord(String text) {
  return text
      .toLowerCase()
      .split(' ')
      .map((word) => word.isNotEmpty
      ? '${word[0].toUpperCase()}${word.substring(1)}'
      : '')
      .join(' ');
}

String maskMobile(String mobile) {
  if (mobile.length <= 3) {
    return '*' * mobile.length;
  } else {
    return mobile.substring(0, mobile.length - 3) + '***';
  }
}

String maskMobileFromEnd(String mobile) {
  if (mobile.length <= 4) {
    return '*' * mobile.length;
  } else {
    return '*' * (mobile.length - 4) + mobile.substring(mobile.length - 4);
  }
}

extension StringToBool on String {
  bool toBool() {
    final normalized = this.trim().toLowerCase();
    return ['true', 'yes', '1', 'on'].contains(normalized);
  }
}

extension StringToDouble on String {
  double toDouble({double defaultValue = 0.0}) {
    return double.tryParse(trim()) ?? defaultValue;
  }
}


extension StringToInt on String {
  int toInt({int defaultValue = 0}) {
    return int.tryParse(trim()) ?? defaultValue;
  }
}