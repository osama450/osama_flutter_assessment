// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `en`
  String get locale {
    return Intl.message('en', name: 'locale', desc: '', args: []);
  }

  /// `ع`
  String get changeLocalizationLanguage {
    return Intl.message(
      'ع',
      name: 'changeLocalizationLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout with the server`
  String get connectionTimeoutWithApiServer {
    return Intl.message(
      'Connection timeout with the server',
      name: 'connectionTimeoutWithApiServer',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout with the server`
  String get sendTimeoutWithApiServer {
    return Intl.message(
      'Send timeout with the server',
      name: 'sendTimeoutWithApiServer',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout with the server`
  String get receiveTimeoutWithApiServer {
    return Intl.message(
      'Receive timeout with the server',
      name: 'receiveTimeoutWithApiServer',
      desc: '',
      args: [],
    );
  }

  /// `Bad certificate from the server`
  String get badCertificateWithApiServer {
    return Intl.message(
      'Bad certificate from the server',
      name: 'badCertificateWithApiServer',
      desc: '',
      args: [],
    );
  }

  /// `Request to server was canceled`
  String get requestToApiServerWasCanceled {
    return Intl.message(
      'Request to server was canceled',
      name: 'requestToApiServerWasCanceled',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error. Please try again`
  String get unexpectedErrorPleaseTryAgain {
    return Intl.message(
      'Unexpected error. Please try again',
      name: 'unexpectedErrorPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error with the server`
  String get unknownErrorWithApiServer {
    return Intl.message(
      'Unknown error with the server',
      name: 'unknownErrorWithApiServer',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There was an error. Please login again`
  String get opsThereWasAnErrorPleaseLoginAgain {
    return Intl.message(
      'Oops! There was an error. Please login again',
      name: 'opsThereWasAnErrorPleaseLoginAgain',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error. Please try again later`
  String get internalServerErrorPleaseTryLater {
    return Intl.message(
      'Internal server error. Please try again later',
      name: 'internalServerErrorPleaseTryLater',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There was an error. Please try again`
  String get opsThereWasAnErrorPleaseTryAgain {
    return Intl.message(
      'Oops! There was an error. Please try again',
      name: 'opsThereWasAnErrorPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message('Wallet', name: 'wallet', desc: '', args: []);
  }

  /// `Total Points`
  String get totalPoints {
    return Intl.message(
      'Total Points',
      name: 'totalPoints',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pendingPoints {
    return Intl.message('Pending', name: 'pendingPoints', desc: '', args: []);
  }

  /// `Expiring`
  String get expiringPoints {
    return Intl.message('Expiring', name: 'expiringPoints', desc: '', args: []);
  }

  /// `Expires on`
  String get expiresOn {
    return Intl.message('Expires on', name: 'expiresOn', desc: '', args: []);
  }

  /// `pts`
  String get pointsUnit {
    return Intl.message('pts', name: 'pointsUnit', desc: '', args: []);
  }

  /// `All`
  String get filterAll {
    return Intl.message('All', name: 'filterAll', desc: '', args: []);
  }

  /// `Earn`
  String get filterEarn {
    return Intl.message('Earn', name: 'filterEarn', desc: '', args: []);
  }

  /// `Redeem`
  String get filterRedeem {
    return Intl.message('Redeem', name: 'filterRedeem', desc: '', args: []);
  }

  /// `Transfer`
  String get filterTransfer {
    return Intl.message('Transfer', name: 'filterTransfer', desc: '', args: []);
  }

  /// `Transfer In`
  String get filterTransferIn {
    return Intl.message(
      'Transfer In',
      name: 'filterTransferIn',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Out`
  String get filterTransferOut {
    return Intl.message(
      'Transfer Out',
      name: 'filterTransferOut',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get filterPurchase {
    return Intl.message('Purchase', name: 'filterPurchase', desc: '', args: []);
  }

  /// `Completed`
  String get statusCompleted {
    return Intl.message(
      'Completed',
      name: 'statusCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get statusPending {
    return Intl.message('Pending', name: 'statusPending', desc: '', args: []);
  }

  /// `Failed`
  String get statusFailed {
    return Intl.message('Failed', name: 'statusFailed', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `Recent Activity`
  String get recentActivity {
    return Intl.message(
      'Recent Activity',
      name: 'recentActivity',
      desc: '',
      args: [],
    );
  }

  /// `No transactions`
  String get noTransactions {
    return Intl.message(
      'No transactions',
      name: 'noTransactions',
      desc: '',
      args: [],
    );
  }

  /// `No transactions match this filter yet.`
  String get noTransactionsBody {
    return Intl.message(
      'No transactions match this filter yet.',
      name: 'noTransactionsBody',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Transfer points`
  String get transferPoints {
    return Intl.message(
      'Transfer points',
      name: 'transferPoints',
      desc: '',
      args: [],
    );
  }

  /// `Recipient`
  String get recipient {
    return Intl.message('Recipient', name: 'recipient', desc: '', args: []);
  }

  /// `+201XXXXXXXXX  or  name@email.com`
  String get recipientHint {
    return Intl.message(
      '+201XXXXXXXXX  or  name@email.com',
      name: 'recipientHint',
      desc: '',
      args: [],
    );
  }

  /// `Egyptian phone number or email address`
  String get recipientHelper {
    return Intl.message(
      'Egyptian phone number or email address',
      name: 'recipientHelper',
      desc: '',
      args: [],
    );
  }

  /// `Enter a recipient.`
  String get recipientRequired {
    return Intl.message(
      'Enter a recipient.',
      name: 'recipientRequired',
      desc: '',
      args: [],
    );
  }

  /// `Use an Egyptian number (+201XXXXXXXXX) or an email.`
  String get recipientInvalid {
    return Intl.message(
      'Use an Egyptian number (+201XXXXXXXXX) or an email.',
      name: 'recipientInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address.`
  String get recipientInvalidEmail {
    return Intl.message(
      'Enter a valid email address.',
      name: 'recipientInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Points to transfer`
  String get pointsToTransfer {
    return Intl.message(
      'Points to transfer',
      name: 'pointsToTransfer',
      desc: '',
      args: [],
    );
  }

  /// `0`
  String get amountHint {
    return Intl.message('0', name: 'amountHint', desc: '', args: []);
  }

  /// `Minimum 100 · whole numbers only`
  String get amountHelper {
    return Intl.message(
      'Minimum 100 · whole numbers only',
      name: 'amountHelper',
      desc: '',
      args: [],
    );
  }

  /// `Enter an amount.`
  String get amountRequired {
    return Intl.message(
      'Enter an amount.',
      name: 'amountRequired',
      desc: '',
      args: [],
    );
  }

  /// `Whole numbers only.`
  String get amountWholeOnly {
    return Intl.message(
      'Whole numbers only.',
      name: 'amountWholeOnly',
      desc: '',
      args: [],
    );
  }

  /// `Minimum is 100 points.`
  String get amountMin {
    return Intl.message(
      'Minimum is 100 points.',
      name: 'amountMin',
      desc: '',
      args: [],
    );
  }

  /// `You only have {points} pts available.`
  String amountMax(Object points) {
    return Intl.message(
      'You only have $points pts available.',
      name: 'amountMax',
      desc: '',
      args: [points],
    );
  }

  /// `Max`
  String get max {
    return Intl.message('Max', name: 'max', desc: '', args: []);
  }

  /// `Note (optional)`
  String get noteOptional {
    return Intl.message(
      'Note (optional)',
      name: 'noteOptional',
      desc: '',
      args: [],
    );
  }

  /// `Add a short message…`
  String get noteHint {
    return Intl.message(
      'Add a short message…',
      name: 'noteHint',
      desc: '',
      args: [],
    );
  }

  /// `Available balance`
  String get availableBalance {
    return Intl.message(
      'Available balance',
      name: 'availableBalance',
      desc: '',
      args: [],
    );
  }

  /// `Transfer sent`
  String get transferSent {
    return Intl.message(
      'Transfer sent',
      name: 'transferSent',
      desc: '',
      args: [],
    );
  }

  /// `You sent {amount} pts to {recipient}.`
  String youSentToRecipient(Object amount, Object recipient) {
    return Intl.message(
      'You sent $amount pts to $recipient.',
      name: 'youSentToRecipient',
      desc: '',
      args: [amount, recipient],
    );
  }

  /// `New balance: {points} pts`
  String newBalanceLabel(Object points) {
    return Intl.message(
      'New balance: $points pts',
      name: 'newBalanceLabel',
      desc: '',
      args: [points],
    );
  }

  /// `Back to wallet`
  String get backToWallet {
    return Intl.message(
      'Back to wallet',
      name: 'backToWallet',
      desc: '',
      args: [],
    );
  }

  /// `Transfer {amount} pts`
  String transferCta(Object amount) {
    return Intl.message(
      'Transfer $amount pts',
      name: 'transferCta',
      desc: '',
      args: [amount],
    );
  }

  /// `You don't have enough points for this transfer.`
  String get insufficientBalance {
    return Intl.message(
      'You don\'t have enough points for this transfer.',
      name: 'insufficientBalance',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find that recipient.`
  String get recipientNotFound {
    return Intl.message(
      'We couldn\'t find that recipient.',
      name: 'recipientNotFound',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
