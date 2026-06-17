import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_plus/generated/l10n.dart';

extension DateTimeExtension on DateTime {
  DateTime get lastDayOfTheMonth {
    return DateTime(year, month + 1, 0);
  }

  DateTime get dateOnly {
    return DateTime(year, month, day);
  }

  TimeOfDay get timeOnly {
    return TimeOfDay(hour: hour, minute: minute);
  }

  bool isBetween(DateTime start, DateTime end) {
    return isAfter(start) && isBefore(end);
  }

  String formatMMYYYY([BuildContext? context]) {
    return DateFormat('MM/yyyy', Intl.getCurrentLocale()).format(this);
  }

  String formatDateMMMDYYYY([BuildContext? context]) {
    return DateFormat.yMMMd(Intl.getCurrentLocale()).format(this);
  }

  String formatDateDMMMYYYY([BuildContext? context]) {
    return DateFormat('d MMM, y', Intl.getCurrentLocale()).format(this);
  }

  String formatDateDDMMMM([BuildContext? context]) {
    return DateFormat('MMMM dd, y', Intl.getCurrentLocale()).format(this);
  }

  String formatDDMMM([BuildContext? context]) {
    return DateFormat('dd MMM', Intl.getCurrentLocale()).format(this);
  }

  String formatddMMMMyyyy([BuildContext? context]) {
    return DateFormat('dd MMMM, yyyy', Intl.getCurrentLocale()).format(this);
  }

  String formatddMMMMyyyyHHmm([BuildContext? context]) {
    return DateFormat(
      'd MMM yyyy, HH:mm a',
      Intl.getCurrentLocale(),
    ).format(this);
  }

  String formatdMMMYYYY([BuildContext? context]) {
    return DateFormat('d MMM yyyy', Intl.getCurrentLocale()).format(this);
  }

  String formatddMMMMddYYYY() {
    return DateFormat('MMMM dd, yyyy', Intl.getCurrentLocale()).format(this);
  }

  /// "Today, 2:30 PM" / "Yesterday, 2:30 PM" / "5 Jun 2026, 2:30 PM".
  String formatRelativeDayTime() {
    final today = DateTime.now().dateOnly;
    final that = dateOnly;
    final time = DateFormat('h:mm a', Intl.getCurrentLocale()).format(this);
    if (that == today) return '${S.current.today}, $time';
    if (that == today.subtract(const Duration(days: 1))) {
      return '${S.current.yesterday}, $time';
    }
    return DateFormat(
      'd MMM yyyy, h:mm a',
      Intl.getCurrentLocale(),
    ).format(this);
  }

  DateTime get nextWeekDay {
    final currentDate = DateTime.now();
    final daysUntilNext = (weekday - currentDate.weekday).abs();
    DateTime nextWeekDayDate = currentDate.add(Duration(days: daysUntilNext));

    while (nextWeekDayDate.isBefore(this)) {
      nextWeekDayDate = nextWeekDayDate.add(const Duration(days: 7));
    }

    return nextWeekDayDate;
  }
}
