// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(points) => "You only have ${points} pts available.";

  static String m1(points) => "New balance: ${points} pts";

  static String m2(amount) => "Transfer ${amount} pts";

  static String m3(amount, recipient) =>
      "You sent ${amount} pts to ${recipient}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "amountHelper": MessageLookupByLibrary.simpleMessage(
      "Minimum 100 · whole numbers only",
    ),
    "amountHint": MessageLookupByLibrary.simpleMessage("0"),
    "amountMax": m0,
    "amountMin": MessageLookupByLibrary.simpleMessage("Minimum is 100 points."),
    "amountRequired": MessageLookupByLibrary.simpleMessage("Enter an amount."),
    "amountWholeOnly": MessageLookupByLibrary.simpleMessage(
      "Whole numbers only.",
    ),
    "availableBalance": MessageLookupByLibrary.simpleMessage(
      "Available balance",
    ),
    "backToWallet": MessageLookupByLibrary.simpleMessage("Back to wallet"),
    "badCertificateWithApiServer": MessageLookupByLibrary.simpleMessage(
      "Bad certificate from the server",
    ),
    "changeLocalizationLanguage": MessageLookupByLibrary.simpleMessage("ع"),
    "connectionTimeoutWithApiServer": MessageLookupByLibrary.simpleMessage(
      "Connection timeout with the server",
    ),
    "expiresOn": MessageLookupByLibrary.simpleMessage("Expires on"),
    "expiringPoints": MessageLookupByLibrary.simpleMessage("Expiring"),
    "filterAll": MessageLookupByLibrary.simpleMessage("All"),
    "filterEarn": MessageLookupByLibrary.simpleMessage("Earn"),
    "filterPurchase": MessageLookupByLibrary.simpleMessage("Purchase"),
    "filterRedeem": MessageLookupByLibrary.simpleMessage("Redeem"),
    "filterTransfer": MessageLookupByLibrary.simpleMessage("Transfer"),
    "filterTransferIn": MessageLookupByLibrary.simpleMessage("Transfer In"),
    "filterTransferOut": MessageLookupByLibrary.simpleMessage("Transfer Out"),
    "insufficientBalance": MessageLookupByLibrary.simpleMessage(
      "You don\'t have enough points for this transfer.",
    ),
    "internalServerErrorPleaseTryLater": MessageLookupByLibrary.simpleMessage(
      "Internal server error. Please try again later",
    ),
    "locale": MessageLookupByLibrary.simpleMessage("en"),
    "max": MessageLookupByLibrary.simpleMessage("Max"),
    "newBalanceLabel": m1,
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noTransactions": MessageLookupByLibrary.simpleMessage("No transactions"),
    "noTransactionsBody": MessageLookupByLibrary.simpleMessage(
      "No transactions match this filter yet.",
    ),
    "noteHint": MessageLookupByLibrary.simpleMessage("Add a short message…"),
    "noteOptional": MessageLookupByLibrary.simpleMessage("Note (optional)"),
    "opsThereWasAnErrorPleaseLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Oops! There was an error. Please login again",
    ),
    "opsThereWasAnErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Oops! There was an error. Please try again",
    ),
    "pendingPoints": MessageLookupByLibrary.simpleMessage("Pending"),
    "pointsToTransfer": MessageLookupByLibrary.simpleMessage(
      "Points to transfer",
    ),
    "pointsUnit": MessageLookupByLibrary.simpleMessage("pts"),
    "receiveTimeoutWithApiServer": MessageLookupByLibrary.simpleMessage(
      "Receive timeout with the server",
    ),
    "recentActivity": MessageLookupByLibrary.simpleMessage("Recent Activity"),
    "recipient": MessageLookupByLibrary.simpleMessage("Recipient"),
    "recipientHelper": MessageLookupByLibrary.simpleMessage(
      "Egyptian phone number or email address",
    ),
    "recipientHint": MessageLookupByLibrary.simpleMessage(
      "+20XXXXXXXXXX  or  name@email.com",
    ),
    "recipientInvalid": MessageLookupByLibrary.simpleMessage(
      "Use an Egyptian number (+20XXXXXXXXXX) or an email.",
    ),
    "recipientInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email address.",
    ),
    "recipientNotFound": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t find that recipient.",
    ),
    "recipientRequired": MessageLookupByLibrary.simpleMessage(
      "Enter a recipient.",
    ),
    "requestToApiServerWasCanceled": MessageLookupByLibrary.simpleMessage(
      "Request to server was canceled",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "sendTimeoutWithApiServer": MessageLookupByLibrary.simpleMessage(
      "Send timeout with the server",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "statusCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "statusFailed": MessageLookupByLibrary.simpleMessage("Failed"),
    "statusPending": MessageLookupByLibrary.simpleMessage("Pending"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "totalPoints": MessageLookupByLibrary.simpleMessage("Total Points"),
    "transferCta": m2,
    "transferPoints": MessageLookupByLibrary.simpleMessage("Transfer points"),
    "transferSent": MessageLookupByLibrary.simpleMessage("Transfer sent"),
    "unexpectedErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Unexpected error. Please try again",
    ),
    "unknownErrorWithApiServer": MessageLookupByLibrary.simpleMessage(
      "Unknown error with the server",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("Wallet"),
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "youSentToRecipient": m3,
  };
}
