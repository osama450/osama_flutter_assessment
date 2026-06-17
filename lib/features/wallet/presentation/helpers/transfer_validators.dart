enum RecipientError { required, invalid, invalidEmail }

enum AmountError { required, wholeOnly, min, max }

abstract class TransferValidators {
  static const int minAmount = 100;
  static const int noteMaxLength = 150;

  // Egyptian mobile: +20 country code, then a mobile number starting with 1
  // (010/011/012/015 → 1 + 9 digits). Rejects e.g. +200000000000.
  static final RegExp _phone = RegExp(r'^\+201\d{9}$');
  static final RegExp _email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  static final RegExp _digits = RegExp(r'^\d+$');

  static RecipientError? recipient(String value) {
    final t = value.trim();
    if (t.isEmpty) return RecipientError.required;
    if (_phone.hasMatch(t) || _email.hasMatch(t)) return null;
    if (t.contains('@')) return RecipientError.invalidEmail;
    return RecipientError.invalid;
  }

  static AmountError? amount(String value, int balance) {
    if (value.isEmpty) return AmountError.required;
    if (!_digits.hasMatch(value)) return AmountError.wholeOnly;
    final n = int.parse(value);
    if (n < minAmount) return AmountError.min;
    if (n > balance) return AmountError.max;
    return null;
  }
}
