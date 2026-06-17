class Settings {
  final String aboutAr;
  final String aboutEn;
  final String androidUrl;
  final String androidVersion;
  final String iosUrl;
  final String iosVersion;
  final bool maintenanceMode;
  final String termsAndConditionsAr;
  final String termsAndConditionsEn;
  final String privacyPolicyAr;
  final String privacyPolicyEn;
  final String contactEmail;
  final String contactPhone;

  /// Base URL for shareable session deep links, e.g. `https://app.rafeeqteam.com`.
  /// Links are built as `<shareBaseUrl>/sessions/<id>`. Remote-config so the host
  /// can change without an app release. Mirror of `app_settings.share_base_url`.
  final String shareBaseUrl;

  /// Number of minutes before `sessions.start_at` after which a session can
  /// no longer be edited. Mirror of `app_settings.edit_lock_minutes_before_start`.
  /// Client uses this to disable edit form fields with a tooltip; the server
  /// also enforces it via the `sessions_before_update_edit_lock` trigger.
  final int editLockMinutesBeforeStart;

  Settings({
    required this.aboutAr,
    required this.aboutEn,
    required this.androidUrl,
    required this.androidVersion,
    required this.iosUrl,
    required this.iosVersion,
    required this.maintenanceMode,
    required this.termsAndConditionsAr,
    required this.termsAndConditionsEn,
    required this.privacyPolicyAr,
    required this.privacyPolicyEn,
    required this.contactEmail,
    required this.contactPhone,
    this.shareBaseUrl = 'https://app.rafeeqteam.com',
    this.editLockMinutesBeforeStart = 60,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    aboutAr: (json['about_ar'] as String?) ?? '',
    aboutEn: (json['about_en'] as String?) ?? '',
    androidUrl: (json['android_url'] as String?) ?? '',
    androidVersion: (json['android_version'] as String?) ?? '',
    iosUrl: (json['ios_url'] as String?) ?? '',
    iosVersion: (json['ios_version'] as String?) ?? '',
    maintenanceMode: (json['maintenance_mode'] as bool?) ?? false,
    termsAndConditionsAr: (json['terms_ar'] as String?) ?? '',
    termsAndConditionsEn: (json['terms_en'] as String?) ?? '',
    privacyPolicyAr: (json['privacy_ar'] as String?) ?? '',
    privacyPolicyEn: (json['privacy_en'] as String?) ?? '',
    contactEmail: (json['contact_email'] as String?) ?? '',
    contactPhone: (json['contact_phone'] as String?) ?? '',
    shareBaseUrl: (json['share_base_url'] as String?)?.isNotEmpty == true
        ? (json['share_base_url'] as String)
        : 'https://app.rafeeqteam.com',
    editLockMinutesBeforeStart:
        (json['edit_lock_minutes_before_start'] as int?) ?? 60,
  );
}
