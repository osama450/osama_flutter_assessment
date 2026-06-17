import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.paper,
    required this.card,
    required this.surfaceMute,
    required this.surfaceMute2,
    required this.chrome,
    required this.chromeStrong,
    required this.tabBg,
    required this.scrim,
    required this.ink,
    required this.subink,
    required this.mute,
    required this.onAccent,
    required this.onPrimary,
    required this.hair,
    required this.hair2,
    required this.green,
    required this.greenDeep,
    required this.greenSoft,
    required this.tint,
    required this.amber,
    required this.red,
    required this.primary,
    required this.isDark,
  });

  // Surfaces — every solid background reads from one of these
  final Color paper;
  final Color card;
  final Color surfaceMute;
  final Color surfaceMute2;
  final Color chrome;
  final Color chromeStrong;
  final Color tabBg;
  final Color scrim;

  // Text
  final Color ink;
  final Color subink;
  final Color mute;
  final Color onAccent;
  final Color onPrimary;

  // Lines
  final Color hair;
  final Color hair2;

  // Brand greens
  final Color green;
  final Color greenDeep;
  final Color greenSoft;
  final Color tint;

  // Status
  final Color amber;
  final Color red;

  // Primary action surface (FAB, sticky CTA)
  final Color primary;

  // Conditional helper for shadow recipes etc.
  final bool isDark;

  // ── Deprecated forwarders ──────────────────────────────────────────────────
  // Kept so widgets reading the old names still compile. Migrate to the new
  // tokens incrementally (see CLAUDE.md → Dark mode + theme tokens).
  @Deprecated('Use paper')
  Color get background => paper;
  @Deprecated('Use card')
  Color get surface => card;
  @Deprecated('Use surfaceMute')
  Color get surfaceVariant => surfaceMute;
  @Deprecated('Use hair')
  Color get border => hair;
  @Deprecated('Use ink')
  Color get textPrimary => ink;
  @Deprecated('Use subink')
  Color get textSecondary => subink;
  @Deprecated('Use ink')
  Color get iconPrimary => ink;

  // Mart Wallet palette — purple primary, cool slate neutrals.
  static const light = AppThemeExtension(
    paper: Color(0xFFF7F8FC), // slate-50 app bg
    card: Color(0xFFFFFFFF),
    surfaceMute: Color(0xFFEFF1F8), // slate-100
    surfaceMute2: Color(0xFFE3E6F0), // slate-200
    chrome: Color(0xF0FFFFFF),
    chromeStrong: Color(0xF5FFFFFF),
    tabBg: Color(0xEBFFFFFF),
    scrim: Color(0x59181B2B),
    ink: Color(0xFF181B2B), // slate-900
    subink: Color(0xFF6E748F), // slate-500
    mute: Color(0xFF9DA3BC), // slate-400
    onAccent: Color(0xFFFFFFFF),
    onPrimary: Color(0xFFFFFFFF),
    hair: Color(0xFFE3E6F0), // slate-200
    hair2: Color(0x14181B2B),
    green: Color(0xFF00B894), // success
    greenDeep: Color(0xFF019678),
    greenSoft: Color(0xFFE0FBF3),
    tint: Color(0xFFF1EFFE), // purple-50
    amber: Color(0xFFF5B544),
    red: Color(0xFFE74C3C),
    primary: Color(0xFF6C5CE7), // purple-500
    isDark: false,
  );

  static const dark = AppThemeExtension(
    paper: Color(0xFF0E1020), // slate-950
    card: Color(0xFF181B2B), // slate-900
    surfaceMute: Color(0xFF20243A),
    surfaceMute2: Color(0xFF262A3D), // slate-800
    chrome: Color(0xC7141826),
    chromeStrong: Color(0xE0101426),
    tabBg: Color(0xAA0A0E1C),
    scrim: Color(0x8C000000),
    ink: Color(0xFFEFF1F8),
    subink: Color(0xFF9DA3BC),
    mute: Color(0xFF6E748F),
    onAccent: Color(0xFFFFFFFF),
    onPrimary: Color(0xFFFFFFFF),
    hair: Color(0xFF2A2E45),
    hair2: Color(0x14EFF1F8),
    green: Color(0xFF2FE5B2),
    greenDeep: Color(0xFF00B894),
    greenSoft: Color(0xFF15324A),
    tint: Color(0xFF231E50), // purple-900
    amber: Color(0xFFFDCB6E),
    red: Color(0xFFFF6B5C),
    primary: Color(0xFF8C7BED), // purple-400
    isDark: true,
  );

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? paper,
    Color? card,
    Color? surfaceMute,
    Color? surfaceMute2,
    Color? chrome,
    Color? chromeStrong,
    Color? tabBg,
    Color? scrim,
    Color? ink,
    Color? subink,
    Color? mute,
    Color? onAccent,
    Color? onPrimary,
    Color? hair,
    Color? hair2,
    Color? green,
    Color? greenDeep,
    Color? greenSoft,
    Color? tint,
    Color? amber,
    Color? red,
    Color? primary,
    bool? isDark,
  }) {
    return AppThemeExtension(
      paper: paper ?? this.paper,
      card: card ?? this.card,
      surfaceMute: surfaceMute ?? this.surfaceMute,
      surfaceMute2: surfaceMute2 ?? this.surfaceMute2,
      chrome: chrome ?? this.chrome,
      chromeStrong: chromeStrong ?? this.chromeStrong,
      tabBg: tabBg ?? this.tabBg,
      scrim: scrim ?? this.scrim,
      ink: ink ?? this.ink,
      subink: subink ?? this.subink,
      mute: mute ?? this.mute,
      onAccent: onAccent ?? this.onAccent,
      onPrimary: onPrimary ?? this.onPrimary,
      hair: hair ?? this.hair,
      hair2: hair2 ?? this.hair2,
      green: green ?? this.green,
      greenDeep: greenDeep ?? this.greenDeep,
      greenSoft: greenSoft ?? this.greenSoft,
      tint: tint ?? this.tint,
      amber: amber ?? this.amber,
      red: red ?? this.red,
      primary: primary ?? this.primary,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      paper: Color.lerp(paper, other.paper, t) ?? paper,
      card: Color.lerp(card, other.card, t) ?? card,
      surfaceMute: Color.lerp(surfaceMute, other.surfaceMute, t) ?? surfaceMute,
      surfaceMute2:
          Color.lerp(surfaceMute2, other.surfaceMute2, t) ?? surfaceMute2,
      chrome: Color.lerp(chrome, other.chrome, t) ?? chrome,
      chromeStrong:
          Color.lerp(chromeStrong, other.chromeStrong, t) ?? chromeStrong,
      tabBg: Color.lerp(tabBg, other.tabBg, t) ?? tabBg,
      scrim: Color.lerp(scrim, other.scrim, t) ?? scrim,
      ink: Color.lerp(ink, other.ink, t) ?? ink,
      subink: Color.lerp(subink, other.subink, t) ?? subink,
      mute: Color.lerp(mute, other.mute, t) ?? mute,
      onAccent: Color.lerp(onAccent, other.onAccent, t) ?? onAccent,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      hair: Color.lerp(hair, other.hair, t) ?? hair,
      hair2: Color.lerp(hair2, other.hair2, t) ?? hair2,
      green: Color.lerp(green, other.green, t) ?? green,
      greenDeep: Color.lerp(greenDeep, other.greenDeep, t) ?? greenDeep,
      greenSoft: Color.lerp(greenSoft, other.greenSoft, t) ?? greenSoft,
      tint: Color.lerp(tint, other.tint, t) ?? tint,
      amber: Color.lerp(amber, other.amber, t) ?? amber,
      red: Color.lerp(red, other.red, t) ?? red,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      isDark: t < 0.5 ? isDark : other.isDark,
    );
  }
}
