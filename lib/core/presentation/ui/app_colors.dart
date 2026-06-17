import 'package:flutter/material.dart';

class AppColors {
  /// primary
  static const MaterialColor primary = MaterialColor(
    0xFF6C5CE7, // 500
    {
      25: Color(0xFF6C5CE7),
      50: Color(0xFF6C5CE7),
      100: Color(0xFF6C5CE7),
      200: Color(0xFF6C5CE7),
      300: Color(0xFF6C5CE7),
      400: Color(0xFF6C5CE7),
      500: Color(0xFF6C5CE7),
      600: Color(0xFF6C5CE7),
      700: Color(0xFF6C5CE7),
      800: Color(0xFF6C5CE7),
      900: Color(0xFF6C5CE7),
      950: Color(0xFF6C5CE7),
    },
  );

  static const MaterialColor secondaryColor = MaterialColor(
    0xFF00D9A5, // 500
    {
      25: Color(0xFF00D9A5),
      50: Color(0xFF00D9A5),
      100: Color(0xFF00D9A5),
      200: Color(0xFF00D9A5),
      300: Color(0xFF00D9A5),
      400: Color(0xFF00D9A5),
      500: Color(0xFF00D9A5),
      600: Color(0xFF00D9A5),
      700: Color(0xFF00D9A5),
      800: Color(0xFF00D9A5),
      900: Color(0xFF00D9A5),
      950: Color(0xFF00D9A5),
    },
  );

  /// White (all weights same)
  static const MaterialColor white = MaterialColor(0xFFFFFFFF, {
    25: Color(0xFFFFFFFF),
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
    950: Color(0xFFFFFFFF),
  });

  /// Black (all weights same)
  static const MaterialColor black = MaterialColor(0xFF000000, {
    25: Color(0xFF000000),
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
    950: Color(0xFF000000),
  });

  /// Gray Light Mode
  static const MaterialColor grayLight = MaterialColor(
    0xFF717680, // 500
    {
      25: Color(0xFFFDFDFD),
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F5),
      200: Color(0xFFE9EAEB),
      300: Color(0xFFD5D7DA),
      400: Color(0xFFA4A7AE),
      500: Color(0xFF717680),
      600: Color(0xFF535862),
      700: Color(0xFF414651),
      800: Color(0xFF252B37),
      900: Color(0xFF181927),
      950: Color(0xFF0A0D12),
    },
  );

  /// Gray Dark Mode
  static const MaterialColor grayDark = MaterialColor(
    0xFF85888E, // 500
    {
      25: Color(0xFFFAFAFA),
      50: Color(0xFFF7F7F7),
      100: Color(0xFFF0F0F1),
      200: Color(0xFFECECED),
      300: Color(0xFFCECFD2),
      400: Color(0xFF94979C),
      500: Color(0xFF85888E),
      600: Color(0xFF61656C),
      700: Color(0xFF373A41),
      800: Color(0xFF22262F),
      900: Color(0xFF13161B),
      950: Color(0xFF0C0E12),
    },
  );

  static const Color background = Color(0xFFF1F7F6);

  /// Error
  static const MaterialColor error = MaterialColor(
    0xFFE74C3C, // 500
    {
      25: Color(0xFFFFFBFA),
      50: Color(0xFFFEF3F2),
      100: Color(0xFFFEE4E2),
      200: Color(0xFFFECDCA),
      300: Color(0xFFFDA29B),
      400: Color(0xFFF97066),
      500: Color(0xFFF04438),
      600: Color(0xFFD92D20),
      700: Color(0xFFB42318),
      800: Color(0xFF912018),
      900: Color(0xFF7A271A),
      950: Color(0xFF55160C),
    },
  );

  /// Warning
  static const MaterialColor warning = MaterialColor(
    0xFFF79009, // 500
    {
      25: Color(0xFFFFFCF5),
      50: Color(0xFFFFFAEB),
      100: Color(0xFFFEF0C7),
      200: Color(0xFFFEDF89),
      300: Color(0xFFFEC84B),
      400: Color(0xFFFDB022),
      500: Color(0xFFF79009),
      600: Color(0xFFDC6803),
      700: Color(0xFFB54708),
      800: Color(0xFF93370D),
      900: Color(0xFF7A2E0E),
      950: Color(0xFF4E1D09),
    },
  );

  /// Success
  static const MaterialColor success = MaterialColor(
    0xFF00B894, // 500
    {
      25: Color(0xFFF6FEF9),
      50: Color(0xFFECFDF3),
      100: Color(0xFFDCFAE6),
      200: Color(0xFFABFEC6),
      300: Color(0xFF75E0A7),
      400: Color(0xFF47CD89),
      500: Color(0xFF17B26A),
      600: Color(0xFF079455),
      700: Color(0xFF067647),
      800: Color(0xFF085D3A),
      900: Color(0xFF074D31),
      950: Color(0xFF053321),
    },
  );

  /// Gray Blue
  static const MaterialColor grayBlue = MaterialColor(
    0xFF4E5BA6, // 500
    {
      25: Color(0xFFFCFCFD),
      50: Color(0xFFF8F9FC),
      100: Color(0xFFEAECF5),
      200: Color(0xFFD5D9EB),
      300: Color(0xFFB3B8DB),
      400: Color(0xFF717BBC),
      500: Color(0xFF4E5BA6),
      600: Color(0xFF3E4784),
      700: Color(0xFF363F72),
      800: Color(0xFF293056),
      900: Color(0xFF101323),
      950: Color(0xFF0D0F1C),
    },
  );

  /// Gray Cool
  static const MaterialColor grayCool = MaterialColor(
    0xFF5D6B98, // 500
    {
      25: Color(0xFFFCFCFD),
      50: Color(0xFFF9F9FB),
      100: Color(0xFFEFF1F5),
      200: Color(0xFFDCDDEA),
      300: Color(0xFFB9C0D4),
      400: Color(0xFF7D89B0),
      500: Color(0xFF5D6B98),
      600: Color(0xFF4A5578),
      700: Color(0xFF404968),
      800: Color(0xFF30374F),
      900: Color(0xFF111322),
      950: Color(0xFF0E101B),
    },
  );

  /// Gray Modern
  static const MaterialColor grayModern = MaterialColor(
    0xFF697586, // 500
    {
      25: Color(0xFFFCFCFD),
      50: Color(0xFFF8FAFC),
      100: Color(0xFFEEF2F6),
      200: Color(0xFFE3E8EF),
      300: Color(0xFFCDD5DF),
      400: Color(0xFF9AA4B2),
      500: Color(0xFF697586),
      600: Color(0xFF4B5565),
      700: Color(0xFF364152),
      800: Color(0xFF202939),
      900: Color(0xFF121926),
      950: Color(0xFF0D121C),
    },
  );

  /// Gray Neutral
  static const MaterialColor appGray = MaterialColor(
    0xFF6C737F, // 500
    {
      25: Color(0xFFFCFCFD),
      50: Color(0xFFF9FAFB),
      100: Color(0xFFF3F4F6),
      200: Color(0xFFE5E7EB),
      300: Color(0xFFD2D6DB),
      400: Color(0xFF9DA4AE),
      500: Color(0xFF6C737F),
      600: Color(0xFF4D5761),
      700: Color(0xFF384250),
      800: Color(0xFF1F2A37),
      900: Color(0xFF111927),
      950: Color(0xFF0D121C),
    },
  );

  /// Gray Iron
  static const MaterialColor grayIron = MaterialColor(
    0xFF70707B, // 500
    {
      25: Color(0xFFFCFCFC),
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF4F4F5),
      200: Color(0xFFE4E4E7),
      300: Color(0xFFD1D1D6),
      400: Color(0xFFA0A0AB),
      500: Color(0xFF70707B),
      600: Color(0xFF51525C),
      700: Color(0xFF3F3F46),
      800: Color(0xFF26272B),
      900: Color(0xFF1A1A1E),
      950: Color(0xFF131316),
    },
  );

  /// Gray True
  static const MaterialColor grayTrue = MaterialColor(
    0xFF737373, // 500
    {
      25: Color(0xFFFCFCFC),
      50: Color(0xFFF7F7F7),
      100: Color(0xFFF5F5F5),
      200: Color(0xFFE5E5E5),
      300: Color(0xFFD6D6D6),
      400: Color(0xFFA3A3A3),
      500: Color(0xFF737373),
      600: Color(0xFF525252),
      700: Color(0xFF424242),
      800: Color(0xFF292929),
      900: Color(0xFF141414),
      950: Color(0xFF0F0F0F),
    },
  );

  /// Gray Warm
  static const MaterialColor grayWarm = MaterialColor(
    0xFF79716B, // 500
    {
      25: Color(0xFFFDFDFC),
      50: Color(0xFFFAFAF9),
      100: Color(0xFFF5F5F4),
      200: Color(0xFFE7E5E4),
      300: Color(0xFFD7D3D0),
      400: Color(0xFFA9A29D),
      500: Color(0xFF79716B),
      600: Color(0xFF57534E),
      700: Color(0xFF44403C),
      800: Color(0xFF292524),
      900: Color(0xFF1C1917),
      950: Color(0xFF171412),
    },
  );

  /// Moss
  static const MaterialColor moss = MaterialColor(
    0xFF669F2A, // 500
    {
      25: Color(0xFFFAFDF7),
      50: Color(0xFFF5FBEE),
      100: Color(0xFFE6F4D7),
      200: Color(0xFFCEEAB0),
      300: Color(0xFFACDC79),
      400: Color(0xFF86CB3C),
      500: Color(0xFF669F2A),
      600: Color(0xFF4F7A21),
      700: Color(0xFF3F621A),
      800: Color(0xFF335015),
      900: Color(0xFF2B4212),
      950: Color(0xFF1A280B),
    },
  );

  /// Green Light
  static const MaterialColor greenLight = MaterialColor(
    0xFF66C61C, // 500
    {
      25: Color(0xFFFAFEF5),
      50: Color(0xFFF3FEE7),
      100: Color(0xFFE3FBCC),
      200: Color(0xFFD0F8AB),
      300: Color(0xFFA6EF67),
      400: Color(0xFF85E13A),
      500: Color(0xFF66C61C),
      600: Color(0xFF4CA30D),
      700: Color(0xFF3B7C0F),
      800: Color(0xFF326212),
      900: Color(0xFF2B5314),
      950: Color(0xFF15290A),
    },
  );

  /// Green
  static const MaterialColor green = MaterialColor(
    0xFF28A488, // 500
    {
      25: Color(0xFFF6FEF9),
      50: Color(0xFFF2FBF8),
      100: Color(0xFFD2F5EA),
      200: Color(0xFFA4EBD5),
      300: Color(0xFF6FD9BC),
      400: Color(0xFF42BFA2),
      500: Color(0xFF28A488),
      600: Color(0xFF1C7C69),
      700: Color(0xFF1C695B),
      800: Color(0xFF1B544B),
      900: Color(0xFF1A473F),
      950: Color(0xFF092A25),
    },
  );

  /// Teal
  static const MaterialColor teal = MaterialColor(
    0xFF15B79E, // 500
    {
      25: Color(0xFFF6FEFC),
      50: Color(0xFFF0FDF9),
      100: Color(0xFFCCFBEF),
      200: Color(0xFF99F6E0),
      300: Color(0xFF5FE9D0),
      400: Color(0xFF2ED3B7),
      500: Color(0xFF15B79E),
      600: Color(0xFF0E9384),
      700: Color(0xFF107569),
      800: Color(0xFF125D56),
      900: Color(0xFF134E48),
      950: Color(0xFF0A2926),
    },
  );

  /// Cyan
  static const MaterialColor cyan = MaterialColor(
    0xFF06AED4, // 500
    {
      25: Color(0xFFF5FEFF),
      50: Color(0xFFECFDFF),
      100: Color(0xFFCFF9FE),
      200: Color(0xFFA5F0FC),
      300: Color(0xFF67E3F9),
      400: Color(0xFF22CCEE),
      500: Color(0xFF06AED4),
      600: Color(0xFF088AB2),
      700: Color(0xFF0E7090),
      800: Color(0xFF155B75),
      900: Color(0xFF164C63),
      950: Color(0xFF0D2D3A),
    },
  );

  /// Blue
  static const MaterialColor blue = MaterialColor(
    0xFF3485C3, // 500
    {
      25: Color(0xFFF5FAFF),
      50: Color(0xFFF3F7FC),
      100: Color(0xFFE5EEF9),
      200: Color(0xFFC6DDF1),
      300: Color(0xFF93C0E6),
      400: Color(0xFF59A0D7),
      500: Color(0xFF3485C3),
      600: Color(0xFF2469A5),
      700: Color(0xFF1E5486),
      800: Color(0xFF1E4B74),
      900: Color(0xFF1D3E5D),
      950: Color(0xFF13283E),
    },
  );

  /// Blue Light
  static const MaterialColor blueLight = MaterialColor(
    0xFF0BA5EC, // 500
    {
      25: Color(0xFFF5FBFF),
      50: Color(0xFFF0F9FF),
      100: Color(0xFFE0F2FE),
      200: Color(0xFFB9E6FE),
      300: Color(0xFF7CD4FD),
      400: Color(0xFF36BFFA),
      500: Color(0xFF0BA5EC),
      600: Color(0xFF0086C9),
      700: Color(0xFF026AA2),
      800: Color(0xFF065986),
      900: Color(0xFF0B4A6F),
      950: Color(0xFF062C41),
    },
  );

  /// Blue Dark
  static const MaterialColor blueDark = MaterialColor(
    0xFF2970FF, // 500
    {
      25: Color(0xFFF5F8FF),
      50: Color(0xFFEFF4FF),
      100: Color(0xFFD1E0FF),
      200: Color(0xFFB2CCFF),
      300: Color(0xFF84ADFF),
      400: Color(0xFF528BFF),
      500: Color(0xFF2970FF),
      600: Color(0xFF155EEF),
      700: Color(0xFF004EEB),
      800: Color(0xFF0040C1),
      900: Color(0xFF00359E),
      950: Color(0xFF002266),
    },
  );

  /// Indigo
  static const MaterialColor indigo = MaterialColor(
    0xFF6172F3, // 500
    {
      25: Color(0xFFF5F8FF),
      50: Color(0xFFEEF4FF),
      100: Color(0xFFE0EAFF),
      200: Color(0xFFC7D7FE),
      300: Color(0xFFA4BCFD),
      400: Color(0xFF8098F9),
      500: Color(0xFF6172F3),
      600: Color(0xFF444CE7),
      700: Color(0xFF3538CD),
      800: Color(0xFF2D31A6),
      900: Color(0xFF2D3282),
      950: Color(0xFF1F235B),
    },
  );

  /// Violet
  static const MaterialColor violet = MaterialColor(
    0xFF875BF7, // 500
    {
      25: Color(0xFFFBFAFF),
      50: Color(0xFFF5F3FF),
      100: Color(0xFFECE9FE),
      200: Color(0xFFDDD6FE),
      300: Color(0xFFC3B5FD),
      400: Color(0xFFA48AFB),
      500: Color(0xFF875BF7),
      600: Color(0xFF7839EE),
      700: Color(0xFF6927DA),
      800: Color(0xFF5720B7),
      900: Color(0xFF491C96),
      950: Color(0xFF2E125E),
    },
  );

  /// Purple
  static const MaterialColor purple = MaterialColor(
    0xFF7A5AF8, // 500
    {
      25: Color(0xFFFAFAFF),
      50: Color(0xFFF4F3FF),
      100: Color(0xFFEBE9FE),
      200: Color(0xFFD9D6FE),
      300: Color(0xFFBDB4FE),
      400: Color(0xFF9B8AFB),
      500: Color(0xFF7A5AF8),
      600: Color(0xFF6938EF),
      700: Color(0xFF5925DC),
      800: Color(0xFF4A1FB8),
      900: Color(0xFF3E1C96),
      950: Color(0xFF27115F),
    },
  );

  /// Fuchsia
  static const MaterialColor fuchsia = MaterialColor(
    0xFFD444F1, // 500
    {
      25: Color(0xFFFEFAFF),
      50: Color(0xFFFDF4FF),
      100: Color(0xFFFBE8FF),
      200: Color(0xFFF6D0FE),
      300: Color(0xFFEEAAFD),
      400: Color(0xFFE478FA),
      500: Color(0xFFD444F1),
      600: Color(0xFFBA24D5),
      700: Color(0xFF9F1AB1),
      800: Color(0xFF821890),
      900: Color(0xFF6F1877),
      950: Color(0xFF47104C),
    },
  );

  /// Pink
  static const MaterialColor pink = MaterialColor(
    0xFFEE46BC, // 500
    {
      25: Color(0xFFFEF6FB),
      50: Color(0xFFFDF2FA),
      100: Color(0xFFFCE7F6),
      200: Color(0xFFFCCEEE),
      300: Color(0xFFFAA7E0),
      400: Color(0xFFF670C7),
      500: Color(0xFFEE46BC),
      600: Color(0xFFDD2590),
      700: Color(0xFFC11574),
      800: Color(0xFF9E165F),
      900: Color(0xFF851651),
      950: Color(0xFF4E0D30),
    },
  );

  /// Rose
  static const MaterialColor rose = MaterialColor(
    0xFFF63D68, // 500
    {
      25: Color(0xFFFFF5F6),
      50: Color(0xFFFFF1F3),
      100: Color(0xFFFFE4E8),
      200: Color(0xFFFECDD6),
      300: Color(0xFFFEA3B4),
      400: Color(0xFFFD6F8E),
      500: Color(0xFFF63D68),
      600: Color(0xFFE31B54),
      700: Color(0xFFC01048),
      800: Color(0xFFA11043),
      900: Color(0xFF89123E),
      950: Color(0xFF510B24),
    },
  );

  /// Brown
  static const MaterialColor brown = MaterialColor(
    0xFFA27640, // 500
    {
      25: Color(0xFFFFFFF8),
      50: Color(0xFFF8F5EE),
      100: Color(0xFFEEE6D3),
      200: Color(0xFFDFCDA9),
      300: Color(0xFFCCAE78),
      400: Color(0xFFBD9152),
      500: Color(0xFFA27640),
      600: Color(0xFF956439),
      700: Color(0xFF784C30),
      800: Color(0xFF65402E),
      900: Color(0xFF58372B),
      950: Color(0xFF321C16),
    },
  );

  /// Orange
  static const MaterialColor orange = MaterialColor(
    0xFFEF6820, // 500
    {
      25: Color(0xFFFEFAF5),
      50: Color(0xFFFEF6EE),
      100: Color(0xFFFDEAD7),
      200: Color(0xFFF9DBAF),
      300: Color(0xFFF7B27A),
      400: Color(0xFFF38744),
      500: Color(0xFFEF6820),
      600: Color(0xFFE04F16),
      700: Color(0xFFB93815),
      800: Color(0xFF932F19),
      900: Color(0xFF772917),
      950: Color(0xFF511C10),
    },
  );

  /// Yellow
  static const MaterialColor yellow = MaterialColor(
    0xFFEEB004, // 500
    {
      25: Color(0xFFFEFDF0),
      50: Color(0xFFFEFCE8),
      100: Color(0xFFFFF9C2),
      200: Color(0xFFFFEF88),
      300: Color(0xFFFFDE44),
      400: Color(0xFFFEC80B),
      500: Color(0xFFEEB004),
      600: Color(0xFFCD8701),
      700: Color(0xFFA45F04),
      800: Color(0xFF874A0C),
      900: Color(0xFF733D10),
      950: Color(0xFF431F05),
    },
  );

  // --- Rafeeq Brand Design Tokens (2026 guideline) ---
  static const Color ink = Color(0xFF0D1F18);
  static const Color subink = Color(0xFF3D4F47);
  static const Color mute = Color(0xFF6B7A73);
  static const Color hair = Color(0xFFE3ECE8);
  static const Color paper = Color(0xFFF1F7F6);
  static const Color tint = Color(0xFFE6F1ED);
  static const Color brandGreen = Color(0xFF17876D);
  static const Color brandGreenDeep = Color(0xFF03624C);
  static const Color greenSoft = Color(0xFFD8EDE5);
  static const Color amber = Color(0xFFF59E0B);
  static const Color card = Color(0xFFFFFFFF);

  /// Brand balance-card gradient (purple → deep purple).
  static const List<Color> balanceGradient = [
    Color(0xFF7B6BF0),
    Color(0xFF6C5CE7),
    Color(0xFF5A49D6),
  ];
}
