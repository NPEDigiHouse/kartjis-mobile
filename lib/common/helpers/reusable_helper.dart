import 'dart:math';

class ReusableHelper {
  /// Generate a random text.
  static String generateRandomText({
    int maxLength = 8,
    bool isLetter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }) {
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    const special = '@#%^*>\$@?/[]=+';

    var chars = "";

    if (isLetter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += number;
    if (isSpecial) chars += special;

    return List.generate(maxLength, (_) {
      final indexRandom = Random.secure().nextInt(chars.length);

      return chars[indexRandom];
    }).join('');
  }
}
