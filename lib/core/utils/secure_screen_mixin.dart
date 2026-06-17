import 'package:flutter/widgets.dart';
import 'package:screen_protector/screen_protector.dart';

/// Mix into the [State] of any screen that renders sensitive financial data
/// (balances, transfer amounts, recipients).
///
/// Blocks screen capture while the screen is mounted and reverts on dispose:
///
/// - **Android** (`preventScreenshotOn`): sets `FLAG_SECURE` on the window for
///   all OS versions — blocks screenshots, screen recording, and the
///   app-switcher thumbnail.
/// - **iOS** (`preventScreenshotOn` + `protectDataLeakageWithBlur`): iOS exposes
///   no API to *prevent* a manual screenshot, so the captured image is blanked
///   instead (secure-layer trick) for both screenshots and screen recording,
///   and the app-switcher snapshot is blurred when the app backgrounds. The
///   user can still interact; the pixels just never leave the device.
///
/// Page-scoped on purpose: enabled per sensitive screen rather than app-wide so
/// non-sensitive screens stay screenshot-friendly.
mixin SecureScreenMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    _enableProtection();
  }

  @override
  void dispose() {
    // Fire-and-forget: the widget is going away, nothing to await.
    ScreenProtector.preventScreenshotOff();
    ScreenProtector.protectDataLeakageWithBlurOff();
    super.dispose();
  }

  Future<void> _enableProtection() async {
    await ScreenProtector.preventScreenshotOn();
    // iOS-only app-switcher blur; a no-op on Android (FLAG_SECURE already hides
    // the thumbnail there).
    await ScreenProtector.protectDataLeakageWithBlur();
  }
}
