# Shop Plus — Loyalty Points Wallet

A Flutter loyalty-points **wallet** app: view your points balance, browse and filter
your activity feed, and transfer points to other users. Built as an assessment with a
clean, testable architecture and a fully mocked data layer (no backend required to run).

> **Fully responsive** — a single codebase adapts to **mobile, tablet, and web**, in
> both **English (LTR)** and **Arabic (RTL)**, with **light and dark** themes.

---

## Screenshots

All captures live in [`docs/screenshots/`](docs/screenshots). The table references the
filenames below — drop your device captures in that folder using these names and they
render automatically.

|                       | Wallet                                                                  | Transfer points                                                               |
| --------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| **Phone — EN (LTR)**  | <img src="docs/screenshots/phone_wallet_en.png" width="220"/>           | <img src="docs/screenshots/phone_transfer_en.png" width="220"/>               |
| **Phone — AR (RTL)**  | <img src="docs/screenshots/phone_wallet_ar.png" width="220"/>           | <img src="docs/screenshots/phone_transfer_ar.png" width="220"/>               |
| **Tablet**            | <img src="docs/screenshots/tablet_wallet.png" width="320"/>             | <img src="docs/screenshots/tablet_transfer.png" width="320"/>                 |
| **Desktop / Web (dark)** | <img src="docs/screenshots/desktop_wallet_dark.png" width="420"/>    | <img src="docs/screenshots/desktop_transfer_dark.png" width="420"/>           |

> Same screen, same code — only the layout reflows: phone is single-column, tablet/desktop
> split into two columns. The all-device set above is the proof of the responsive design.

---

## Features

- **Fully responsive** — one codebase for **mobile, tablet, and web** (see [Responsive design](#responsive-design)).
- **Balance card** — total, pending, and expiring points at a glance.
- **Activity feed** — earn / redeem / transfer-in / transfer-out / purchase, with
  **filter chips + live counts**.
- **Pagination** — infinite scroll plus **pull-to-refresh**.
- **Transfer flow** — recipient (Egyptian phone or email) + amount + optional note,
  with **live validation** and success / error states.
- **Screen-capture protection** — the Transfer screen blocks screenshots and screen
  recording (Android `FLAG_SECURE`; iOS secure-layer blanking + app-switcher blur).
  See [Security](#security).
- **Bilingual** — English and **Arabic with full RTL** support.
- **Theming** — light and dark, Material 3, locale-aware fonts (Rubik / Zain).
- **Loading & error UX** — skeleton shimmer while loading, retriable error view.
- **Typed error handling** — `Either<Failure, T>` end-to-end, no thrown exceptions in the UI.

---

## Tech stack

| Concern            | Package                              |
| ------------------ | ------------------------------------ |
| State management   | `flutter_bloc` (Bloc + Cubit), `bloc_concurrency` |
| Navigation         | `go_router`                          |
| Dependency injection | `get_it` + `injectable`            |
| Functional results | `dartz` (`Either<Failure, T>`)       |
| Networking (ready) | `dio` (wired via `BASE_URL`, unused by the mock) |
| Localization       | `intl` + `flutter_intl` (ARB files)  |
| Responsiveness     | `responsive_wrapper`                 |
| Local persistence  | `hive_ce` (saved language)           |
| Security & privacy | `screen_protector` (capture blocking), `flutter_secure_storage` (Keychain/Keystore tokens) |
| Forms              | `flutter_form_builder`               |
| Serialization      | `json_serializable` + `build_runner` |
| Loading UI         | `skeletonizer`, `cached_network_image` |
| Testing            | `flutter_test`, `bloc_test`, `mocktail` |

---

## Architecture

> **Folder structure & feature-based vs layer-based rationale:**
> [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) · [visual board (Miro)](https://miro.com/app/board/uXjVHFcyqb4=/)

Feature-first **clean architecture**. Each feature splits into `data → repository → bloc →
presentation`. Dependencies are registered with `injectable`/`get_it` and resolved at
startup; every repository call returns `Either<Failure, T>`, so success and failure are
handled explicitly with no surprise exceptions in widgets.

```
lib/
├── main.dart                      # Entry: DI + Hive init, BlocObserver, runApp
├── app.dart                       # MaterialApp.router, theme + locale wiring
├── config/
│   ├── routes/                    # go_router (AppRouter) + route observer
│   └── themes/                    # light/dark themes + ThemeExtension tokens
├── core/
│   ├── di/                        # injectable container
│   ├── environment/               # EnvironmentVariables (BASE_URL)
│   ├── errors/                    # Failure types
│   ├── models/                    # LoadingStatus, shared models
│   ├── network/                   # Dio setup + interceptors
│   ├── utils/                     # validators, helpers, BlocObserver
│   └── presentation/              # shared widgets + colors
├── features/
│   ├── wallet/
│   │   ├── data/                  # datasources (mock), models, repositories
│   │   ├── bloc/                  # WalletBloc, TransferCubit
│   │   └── presentation/          # screens + widgets
│   └── shared/                    # SharedCubit (locale/theme) + storage
├── l10n/                          # intl_en.arb, intl_ar.arb
└── generated/                     # l10n + DI + *.g.dart (generated)
```

**Screens & routes**

| Screen          | Route        | File                                                                            |
| --------------- | ------------ | ------------------------------------------------------------------------------- |
| Wallet (home)   | `/wallet`    | `lib/features/wallet/presentation/screens/wallet_screen.dart`                   |
| Transfer points | `/transfer`  | `lib/features/wallet/presentation/screens/transfer_points_screen.dart`          |

**State management**

- `WalletBloc` — loads balance + paginated/filtered transactions. Uses
  `bloc_concurrency` (`restartable` for new filters, `droppable` for "load more").
- `TransferCubit` — drives the transfer form (recipient / amount / note / submit).
- `SharedCubit` — app-wide locale + theme, persisted via Hive.

### Responsive design

One screen, three layouts — driven by `responsive_wrapper`'s `ResponsiveLayout` in
[`wallet_screen.dart`](lib/features/wallet/presentation/screens/wallet_screen.dart):

```dart
ResponsiveLayout(
  phone:   (c) => _mobile(c), // single column: balance card on top, activity below
  tablet:  (c) => _wide(c),   // two columns: balance | activity, side by side
  desktop: (c) => _wide(c),
)

// column width adapts to the breakpoint
final balanceWidth = context.isDesktop ? 400.0 : 300.0;
```

The transfer screen stays comfortable on large screens by centering its form inside a
`ConstrainedBox(maxWidth: 480)`. RTL and responsiveness are both verified by the device
screenshots above.

---

## Security

The Transfer screen renders sensitive financial data — balances, amounts, and
recipients — so it blocks screen capture while mounted. Protection is applied
**per sensitive screen** via a reusable mixin,
[`SecureScreenMixin`](lib/core/utils/secure_screen_mixin.dart) — not app-wide, so
ordinary screens stay screenshot-friendly:

```dart
class _TransferPointsScreenState extends State<TransferPointsScreen>
    with SecureScreenMixin { … }
```

Backed by `screen_protector`: `preventScreenshotOn()` in `initState`, reverted in
`dispose`, plus an iOS app-switcher blur.

| Platform                   | Screenshot              | Screen record / share | App switcher |
| -------------------------- | ----------------------- | --------------------- | ------------ |
| **Android** (all versions) | blocked (`FLAG_SECURE`) | blocked               | hidden       |
| **iOS 12+**                | image **blanked**       | blanked               | blurred      |

> **iOS limit:** Apple exposes no API to *prevent* a manual screenshot. The captured
> image is blanked instead (secure-layer trick), so the pixels never leave the device —
> the strongest protection iOS allows. **Verify on a physical device**; the Simulator
> does not honor the secure layer.

**Other hardening already in place**

- **Tokens in `flutter_secure_storage`** (Keychain / Keystore), never plain prefs.
- **Server-authoritative** balance and recipient checks — client `TransferValidators`
  is UX only; the repository is the source of truth.
- **Typed errors** (`Either<Failure, T>`) — raw server messages never surface in the UI.
- **Debug-only network logging** (`LogInterceptor` gated by `kDebugMode`).

> **Next:** idempotency key on transfer (no double-charge on retry), a confirm step
> before money moves, TLS pinning, and a session-expiry → re-login redirect. See
> [Possible improvements](#possible-improvements--next-steps).

---

## Mock approach & assumptions

The app ships with **no backend**. Thanks to the repository pattern, the entire UI and
all BLoCs run against an in-memory fake — and switching to a real API later touches **one
class**, not the UI.

### How the mock works

- **Interface + implementation** —
  [`wallet_repository.dart`](lib/features/wallet/data/repositories/wallet_repository.dart)
  defines `abstract interface class WalletRepository`, and `MockWalletRepository`
  implements it, bound with `@LazySingleton(as: WalletRepository)`. BLoCs depend on the
  interface, never the mock.
- **Static fixtures** —
  [`wallet_fake_data.dart`](lib/features/wallet/data/datasources/wallet_fake_data.dart)
  holds the seed data:
  - Balance: **15,750** total · **500** pending · **1,200** expiring.
  - **30 transactions** generated from 5 templates (earn `+500`, redeem `−1,000`,
    transfer-out `−250`, purchase `+750`, transfer-in `+300` *pending*), dated
    descending from 15 Feb 2024. Merchant logos come from `picsum.photos` (needs network).
- **Simulated latency** — every call waits, so loading/shimmer states are visible:

  | Call               | Delay              |
  | ------------------ | ------------------ |
  | `getBalance`       | 800 ms             |
  | `getTransactions`  | 600–1200 ms (random) |
  | `transferPoints`   | 900 ms             |

- **Simulated errors** — `transferPoints` returns a typed `Failure` for:

  | Trigger                                          | `errType`               |
  | ------------------------------------------------ | ----------------------- |
  | recipient `+20000000000` or containing `notfound` | `RECIPIENT_NOT_FOUND`   |
  | amount greater than the available balance         | `INSUFFICIENT_BALANCE`  |

- A successful transfer **mutates the in-memory balance** (so the next read reflects it).

### Swapping in a real API

Networking is already wired: `dio` is configured and `BASE_URL` is injected via
`--dart-define-from-file=env.json` → `EnvironmentVariables.baseUrl`. To go live:

```dart
@LazySingleton(as: WalletRepository)
class RemoteWalletRepository implements WalletRepository {
  RemoteWalletRepository(this._dio); // baseUrl = EnvironmentVariables.baseUrl
  final Dio _dio;
  // implement getBalance / getTransactions / getTransactionCounts / transferPoints
}
```

Replace the `@LazySingleton(as:)` binding on the mock, re-run code generation, and
**no UI or BLoC code changes**.

### Assumptions

- Recipient is an **Egyptian phone** (`+20` + 10 digits) **or** a valid email.
- Points are **whole numbers**; **minimum transfer is 100**; note ≤ 150 chars.
- The balance lives **in memory** — transfers **reset on app restart**.
- Dates/timezone come from the fixtures (data is dated Feb 2024).
- Merchant images load from `picsum.photos`, so the demo needs a network connection.
- Selected **language is persisted** (Hive); mobile is **portrait-locked**.

---

## Getting started

### Prerequisites

- Flutter SDK (stable), Dart `^3.11.5`.
- A device/emulator, or Chrome for web.

### Install

```bash
flutter pub get
```

### Generate code

This project uses `injectable`, `json_serializable`, and `hive_ce` generators:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Run

The app reads `BASE_URL` from `env.json` via a Dart define, so you **must** pass the file
(omitting it leaves `BASE_URL` empty):

```bash
flutter run --dart-define-from-file=env.json
```

`env.json` (at the repo root):

```json
{ "BASE_URL": "https://api.shopplus.com" }
```

> In VS Code / Android Studio, add `--dart-define-from-file=env.json` to your run/launch
> configuration so you can launch from the IDE.

---

## Usage example

**Call the repository** (returns `Either<Failure, T>` — fold both sides):

```dart
final result = await walletRepository.transferPoints(
  recipient: '+201234567890',
  amount: 500,
  note: 'Thanks!',
);

result.fold(
  (failure) => debugPrint('Failed: ${failure.errMessage} (${failure.errType})'),
  (balance) => debugPrint('New balance: ${balance.totalPoints}'),
);
```

**Validate the transfer form** (`lib/core/utils/transfer_validators.dart`):

```dart
final recipientError = TransferValidators.recipient(input);     // RecipientError?
final amountError    = TransferValidators.amount(value, balance); // AmountError?

final isValid = recipientError == null && amountError == null;
```

**Try the mocked errors** on the Transfer screen:

- Recipient `+20000000000` → *recipient not found*.
- Amount greater than your balance (> 15,750) → *insufficient balance*.

---

## Testing

```bash
flutter test                 # run all tests
flutter test --coverage      # with coverage (coverage/lcov.info)
flutter analyze              # static analysis (flutter_lints)
```

Tests use `bloc_test` and `mocktail`; shared mocks and widget-wrapping helpers live in
`test/helpers/wallet_test_helpers.dart`.

| Test file                                                | Covers                                                             |
| -------------------------------------------------------- | ----------------------------------------------------------------- |
| `test/features/wallet/data/wallet_repository_test.dart`  | Repository: balance, paginated/filtered transactions, transfer success + failures |
| `test/features/wallet/bloc/wallet_bloc_test.dart`        | `WalletBloc`: load balance, filter, pagination, refresh           |
| `test/features/wallet/bloc/transfer_cubit_test.dart`     | `TransferCubit`: field changes, submit success + failure paths     |
| `test/features/wallet/presentation/wallet_screen_test.dart` | Widget: rendering, filters, shimmer, transfer form validation + dialog |

---

## Possible improvements / next steps

- **Wire a real API** via `RemoteWalletRepository` (the swap point already exists).
- **Harden the transfer** — idempotency key (no double-charge on retry), a confirm
  step before money moves, TLS/certificate pinning, and session-expiry → re-login.
- **Persist balance & transactions** (Hive) so transfers survive app restarts.
- **Environment flavors** (dev / staging / prod) + a guard for a missing `BASE_URL`.
- **Golden tests** for light/dark and LTR/RTL; broaden widget coverage + add CI
  (`flutter analyze` + `flutter test`) via GitHub Actions.
- **Polish empty/error states** and add **accessibility** (semantics, large-text).
- **Deep links** straight into the transfer flow.
- Extract the theme tokens + shared widgets into a reusable **design-system** package.
