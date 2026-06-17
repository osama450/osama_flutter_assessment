// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(points) => "لديك ${points} نقطة فقط متاحة.";

  static String m1(points) => "الرصيد الجديد: ${points} نقطة";

  static String m2(amount) => "تحويل ${amount} نقطة";

  static String m3(amount, recipient) =>
      "أرسلت ${amount} نقطة إلى ${recipient}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "amountHelper": MessageLookupByLibrary.simpleMessage(
      "الحد الأدنى 100 · أرقام صحيحة فقط",
    ),
    "amountHint": MessageLookupByLibrary.simpleMessage("0"),
    "amountMax": m0,
    "amountMin": MessageLookupByLibrary.simpleMessage(
      "الحد الأدنى هو 100 نقطة.",
    ),
    "amountRequired": MessageLookupByLibrary.simpleMessage("أدخل المبلغ."),
    "amountWholeOnly": MessageLookupByLibrary.simpleMessage("أرقام صحيحة فقط."),
    "availableBalance": MessageLookupByLibrary.simpleMessage("الرصيد المتاح"),
    "backToWallet": MessageLookupByLibrary.simpleMessage("العودة إلى المحفظة"),
    "badCertificateWithApiServer": MessageLookupByLibrary.simpleMessage(
      "شهادة غير صالحة من الخادم",
    ),
    "changeLocalizationLanguage": MessageLookupByLibrary.simpleMessage("EN"),
    "connectionTimeoutWithApiServer": MessageLookupByLibrary.simpleMessage(
      "انتهت مهلة الاتصال بالخادم",
    ),
    "expiresOn": MessageLookupByLibrary.simpleMessage("تنتهي في"),
    "expiringPoints": MessageLookupByLibrary.simpleMessage("تنتهي قريبًا"),
    "filterAll": MessageLookupByLibrary.simpleMessage("الكل"),
    "filterEarn": MessageLookupByLibrary.simpleMessage("ربح"),
    "filterPurchase": MessageLookupByLibrary.simpleMessage("شراء"),
    "filterRedeem": MessageLookupByLibrary.simpleMessage("استبدال"),
    "filterTransfer": MessageLookupByLibrary.simpleMessage("تحويل"),
    "filterTransferIn": MessageLookupByLibrary.simpleMessage("تحويل وارد"),
    "filterTransferOut": MessageLookupByLibrary.simpleMessage("تحويل صادر"),
    "insufficientBalance": MessageLookupByLibrary.simpleMessage(
      "ليس لديك نقاط كافية لهذا التحويل.",
    ),
    "internalServerErrorPleaseTryLater": MessageLookupByLibrary.simpleMessage(
      "خطأ في الخادم الداخلي. الرجاء المحاولة لاحقًا",
    ),
    "locale": MessageLookupByLibrary.simpleMessage("ar"),
    "max": MessageLookupByLibrary.simpleMessage("الحد الأقصى"),
    "newBalanceLabel": m1,
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "لا يوجد اتصال بالإنترنت",
    ),
    "noTransactions": MessageLookupByLibrary.simpleMessage("لا توجد معاملات"),
    "noTransactionsBody": MessageLookupByLibrary.simpleMessage(
      "لا توجد معاملات مطابقة لهذه التصفية بعد.",
    ),
    "noteHint": MessageLookupByLibrary.simpleMessage("أضف رسالة قصيرة…"),
    "noteOptional": MessageLookupByLibrary.simpleMessage("ملاحظة (اختياري)"),
    "opsThereWasAnErrorPleaseLoginAgain": MessageLookupByLibrary.simpleMessage(
      "عذرًا! حدث خطأ. الرجاء تسجيل الدخول مرة أخرى",
    ),
    "opsThereWasAnErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "عذرًا! حدث خطأ. الرجاء المحاولة مرة أخرى",
    ),
    "pendingPoints": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "pointsToTransfer": MessageLookupByLibrary.simpleMessage(
      "النقاط المراد تحويلها",
    ),
    "pointsUnit": MessageLookupByLibrary.simpleMessage("نقطة"),
    "receiveTimeoutWithApiServer": MessageLookupByLibrary.simpleMessage(
      "انتهت مهلة الاستلام من الخادم",
    ),
    "recentActivity": MessageLookupByLibrary.simpleMessage("النشاط الأخير"),
    "recipient": MessageLookupByLibrary.simpleMessage("المستلم"),
    "recipientHelper": MessageLookupByLibrary.simpleMessage(
      "رقم هاتف مصري أو بريد إلكتروني",
    ),
    "recipientHint": MessageLookupByLibrary.simpleMessage(
      "+20XXXXXXXXXX  أو  name@email.com",
    ),
    "recipientInvalid": MessageLookupByLibrary.simpleMessage(
      "استخدم رقمًا مصريًا (+20XXXXXXXXXX) أو بريدًا إلكترونيًا.",
    ),
    "recipientInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدًا إلكترونيًا صالحًا.",
    ),
    "recipientNotFound": MessageLookupByLibrary.simpleMessage(
      "تعذر العثور على هذا المستلم.",
    ),
    "recipientRequired": MessageLookupByLibrary.simpleMessage("أدخل المستلم."),
    "requestToApiServerWasCanceled": MessageLookupByLibrary.simpleMessage(
      "تم إلغاء الطلب إلى الخادم",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "sendTimeoutWithApiServer": MessageLookupByLibrary.simpleMessage(
      "انتهت مهلة الإرسال إلى الخادم",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage("حدث خطأ ما"),
    "statusCompleted": MessageLookupByLibrary.simpleMessage("مكتملة"),
    "statusFailed": MessageLookupByLibrary.simpleMessage("فشلت"),
    "statusPending": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "today": MessageLookupByLibrary.simpleMessage("اليوم"),
    "totalPoints": MessageLookupByLibrary.simpleMessage("إجمالي النقاط"),
    "transferCta": m2,
    "transferPoints": MessageLookupByLibrary.simpleMessage("تحويل النقاط"),
    "transferSent": MessageLookupByLibrary.simpleMessage("تم إرسال التحويل"),
    "unexpectedErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى",
    ),
    "unknownErrorWithApiServer": MessageLookupByLibrary.simpleMessage(
      "خطأ غير معروف من الخادم",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("المحفظة"),
    "yesterday": MessageLookupByLibrary.simpleMessage("أمس"),
    "youSentToRecipient": m3,
  };
}
