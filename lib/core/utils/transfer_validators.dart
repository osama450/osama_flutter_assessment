enum RecipientError { required, invalid, invalidEmail }

enum AmountError { required, wholeOnly, min, max }

abstract class TransferValidators {
  static const int minAmount = 100;
  static const int noteMaxLength = 150;

  static final RegExp _phone = RegExp(r'^\+20\d{10}$');
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
