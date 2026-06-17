# Code Review — Shop Plus Wallet

This document reviews the **Shop Plus** loyalty-points wallet codebase. It is organised in three parts:

1. **[Part 1 — Architecture review](#part-1--architecture-review)** — a section-by-section walkthrough (routing, state management, networking, errors, models, repositories, DI, UI, localization), with the rationale behind each choice.
2. **[Part 2 — Snippet reviews](#part-2--snippet-reviews)** — five assessment snippets, each with the problem, the reasoning, and the corrected approach as it exists in this repo.
3. **[Part 3 — Performance evaluation](#part-3--performance-evaluation)** — the codebase scored against a performance checklist.

Companion reading: [README.md](../README.md) (feature overview) and [docs/ARCHITECTURE.md](ARCHITECTURE.md) (folder strategy).

---

## Part 1 — Architecture review

### 1. Project structure & layering

The project is **feature-first with clean-architecture layers inside each feature**. Cross-cutting concerns live under [`lib/core`](../lib/core), configuration under [`lib/config`](../lib/config), and each vertical slice under [`lib/features/<feature>`](../lib/features).

```
lib/
├── config/          # routing + theming
├── core/            # network, errors, di, models, utils, presentation
├── features/
│   ├── shared/      # app-level (locale) cubit + data
│   └── wallet/      # bloc / data (models, repos, datasources) / presentation
└── generated/ + l10n/
```

**Why this is good:** a new engineer can open `features/wallet` and find everything for that feature (state, data, UI) in one place; `core` stays free of feature logic, so the shared layer never depends "upward". This keeps modules independently testable and makes the wallet slice portable.

### 2. Routing & navigation

Routing uses **`go_router`**, centralised in [`AppRouter`](../lib/config/routes/app_router.dart):

- A single `GoRouter` with a global `navigatorKey` and an `AppRouterObserver` (`app_router.dart:20-39`).
- Route **paths are constants** (`AppRouter.wallet`, `AppRouter.transfer` — `app_router.dart:17-18`), so navigation calls such as `context.push(AppRouter.transfer)` are typo-proof.
- Per-route **dependency injection**: the `/transfer` route wraps its screen in a `BlocProvider` that pulls `TransferCubit` from `getIt` (`app_router.dart:33-36`), so the cubit's lifecycle is scoped to the route.

**Why this is good:** declarative routes, compile-time-safe path constants, and route-scoped DI (the transfer cubit is created on entry and disposed on exit rather than living forever).

### 3. State management

State management is **BLoC / Cubit** (`flutter_bloc`) with `bloc_concurrency` for event ordering.

[`WalletBloc`](../lib/features/wallet/bloc/wallet_bloc.dart) splits concerns into three events ([`wallet_event.dart`](../lib/features/wallet/bloc/wallet_event.dart)):

| Event | Handler | Concurrency transformer | Purpose |
|-------|---------|--------------------------|---------|
| `LoadBalance` | `_onLoadBalance` | default | balance + per-filter counts |
| `LoadTransactions` | `_onLoadTransactions` | `restartable()` (`wallet_bloc.dart:19`) | first page / filter change |
| `LoadMoreTransactions` | `_onLoadMoreTransactions` | `droppable()` (`wallet_bloc.dart:20`) | next page (infinite scroll) |

- **State is immutable** (`WalletState extends Equatable`, `copyWith` — [`wallet_state.dart`](../lib/features/wallet/bloc/wallet_state.dart)), with a typed `LoadingStatus` instead of loose booleans.
- **Transfer** is a focused `Cubit` ([`transfer_cubit.dart`](../lib/features/wallet/bloc/transfer_cubit.dart)) holding form field state, kept separate from the wallet read model.

**Why this is good:** `restartable()` cancels an in-flight filter load when the user taps another chip (no stale results win); `droppable()` ignores duplicate "load more" events fired by rapid scrolling (no double-fetch). Both are correctness *and* performance wins, declared in one line each.

### 4. Networking & API layer

The HTTP layer is built on **Dio**, wrapped by [`DioHelper`](../lib/core/network/dio_helper.dart) (a `@lazySingleton`):

- **Base URL comes from the environment**, never hardcoded: `baseUrl: EnvironmentVariables.baseUrl` (`dio_helper.dart:21`) where `EnvironmentVariables.baseUrl = String.fromEnvironment('BASE_URL')` ([`variables.dart:2`](../lib/core/environment/variables.dart)).
- **Endpoints are path constants**, not literals scattered across services ([`endpoints.dart:6-9`](../lib/core/network/endpoints.dart)).
- **Sane timeouts** — 15 s connect / receive / send (`dio_helper.dart:22-24`).
- **Auth is centralised in an interceptor** ([`AuthInterceptor`](../lib/core/network/auth_interceptor.dart)):
  - Injects `Authorization: Bearer <token>` and a `lang` header on every request (`auth_interceptor.dart:33-37`).
  - On `401`, performs a **single-flight token refresh** (concurrent 401s share one `Completer`, `auth_interceptor.dart:69-82`) and transparently retries the original request once (`auth_interceptor.dart:59-66`).
  - On refresh failure it clears the session (`auth_interceptor.dart:107-110`).
- Tokens are persisted via `flutter_secure_storage` (`SecureTokenStorage`), not `SharedPreferences`.
- Verbose request/response logging is added **only in debug** (`kDebugMode` guard, `dio_helper.dart:44-52`).

**Why this is good (security + maintainability):** no environment URL or secret is compiled into source; switching staging/prod is a `--dart-define`. Auth, refresh, and localisation headers are applied in exactly one place, so no individual call site can forget them. Tokens live in the OS keystore/keychain.

### 5. Error handling

Errors are modelled as a **`Failure` hierarchy** ([`failures.dart`](../lib/core/errors/failures.dart)) and surfaced through `Either<Failure, T>` (`dartz`):

- `Failure` base + `DioFailure` + `RegularFailure` (`failures.dart:7,42,98`).
- `DioFailure.fromDioError` maps every `DioExceptionType` to a **localised** message via `S.current.*` (`failures.dart:47-73`), and `fromResponse` maps status codes `400/401/403/404/422 → server message`, `500 → server error`, else generic (`failures.dart:76-89`).

**Why this is good:** the UI never sees a raw exception or a stack trace — it receives a typed `Failure` with a user-ready, translated message. Callers must handle the `Left` branch (the compiler enforces it), so error paths can't be silently dropped.

### 6. Data models

Models are **typed, immutable, and serialisable** ([`lib/features/wallet/data/models`](../lib/features/wallet/data/models)):

- `@JsonSerializable(fieldRename: FieldRename.snake)` bridges API `snake_case` ↔ Dart `camelCase` automatically ([`transaction.dart:48`](../lib/features/wallet/data/models/transaction.dart)).
- `extends Equatable` for value equality (`transaction.dart:49,98-107`) and `copyWith` for immutable updates (`transaction.dart:77`).
- **Enums are resilient**: `@JsonKey(unknownEnumValue: …)` falls back instead of throwing on an unknown server value (`transaction.dart:62,69`).
- `TransactionsPage` carries pagination metadata (`items`, `page`, `pageSize`, `totalCount`, `hasMore`).

**Why this is good:** no `Map<String, dynamic>` leaks past the data layer, so the rest of the app gets autocomplete, null-safety, and compile-time field checks. `unknownEnumValue` means a new backend enum value won't crash an older client.

### 7. Repository layer

Data access sits behind an **abstract interface** ([`WalletRepository`](../lib/features/wallet/data/repositories/wallet_repository.dart)):

- The interface declares typed, paginated, `Either`-returning methods (`wallet_repository.dart:13-29`).
- `MockWalletRepository` implements it and is bound via `@LazySingleton(as: WalletRepository)` (`wallet_repository.dart:31`), so swapping in a real remote implementation is a one-line DI change — no bloc edits.
- `getTransactions({filter, page, pageSize})` is **pagination-ready at the contract level** (`wallet_repository.dart:16-20`).

**Why this is good:** the bloc depends on the *interface*, not Dio. Tests inject a fake; production injects the real client; neither touches the bloc. The `Either` return type is part of the contract, so error handling is consistent across every implementation.

### 8. Dependency injection

DI uses **`get_it` + `injectable`** with generated wiring. Singletons are `@lazySingleton` (`WalletBloc`, `DioHelper`, `MockWalletRepository`), per-use objects are `@injectable` (`TransferCubit`). Providers are composed once in [`multi_bloc_manager.dart`](../lib/core/utils/multi_bloc_manager.dart) and mounted at the app root.

**Why this is good:** no manual constructor wiring, no service-locator calls sprinkled through widgets, and lifetimes are explicit and intentional (read model is a lazy singleton; the transfer form is recreated per route).

### 9. UI & widgets

The presentation layer favours **small, `const`, single-purpose widgets** and selective rebuilds:

- Rows are a dedicated `const`-constructable widget ([`TransactionListItem`](../lib/features/wallet/presentation/widgets/transaction_list_item.dart), `transaction_list_item.dart:13-16`) full of `const` children.
- Remote images go through [`CustomCachedImage`](../lib/core/presentation/widgets/custom_cached_image.dart) (`cached_network_image`) with a placeholder, an error widget, fixed dimensions, and `FilterQuality.high` (`custom_cached_image.dart:30-42`).
- [`WalletScreen`](../lib/features/wallet/presentation/screens/wallet_screen.dart) is responsive (phone single-column, tablet/desktop two-column), supports pull-to-refresh and infinite scroll, and renders the transaction list through a **virtualized `SliverList.builder`** inside a `CustomScrollView` (see [Snippet 3](#snippet-3--transactionlist-uses-listview)).
- Rebuilds are scoped with `BlocSelector` and `buildWhen` (`wallet_screen.dart` `_balanceSection`, `_chips`, and the list `BlocBuilder`).

**Why this is good:** `const` subtrees are skipped during rebuilds; cached images avoid re-downloading/re-decoding on scroll; selective builders mean a balance update doesn't rebuild the list and vice-versa.

### 10. Localization

The app is fully internationalised with `intl` / `flutter_intl` (generated `S` class), supports **English + Arabic with RTL**, and the active locale is managed by `SharedCubit` and forwarded to the API as a `lang` header (`auth_interceptor.dart:33`). User-facing failure messages are localised at the source (`failures.dart`).

**Why this is good:** no hardcoded user strings; switching language updates both the UI and the server's response language through one shared source of truth.

---

## Part 2 — Snippet reviews

Each snippet below is the assessment's "before" code. The corrected approach is the pattern already established in this repository.

### Snippet 1 — `WalletService`

```dart
class WalletService {
  final http.Client client;
  WalletService(this.client);

  Future<Map<String, dynamic>> getBalance() async {
    final response = await client.get(
      Uri.parse('https://api.shopplus.com/wallet/balance'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<void> transferPoints(String recipientId, int points) async {
    await client.post(
      Uri.parse('https://api.shopplus.com/wallet/transfer'),
      body: json.encode({'recipientId': recipientId, 'points': points}),
    );
  }
}
```

**Problems**

1. **Error handling is too weak.** `getBalance` throws a generic `Exception('Failed to load')` with no status code, no server message, and no typed category; the UI cannot tell "no internet" from "session expired" from "server down". `transferPoints` is worse — it never checks `statusCode` at all, so a `400`/`409` (e.g. insufficient balance) is silently treated as success.
2. **It returns `dynamic` (`Map<String, dynamic>`).** Callers index string keys by hand (`body['total_points']`), with no null-safety, no autocomplete, and runtime `TypeError`s when a field is missing or renamed.
3. **The full URL is hardcoded in the service — a security and maintainability problem.** The base host is compiled into source, so you cannot point the app at staging vs production without a code change and rebuild, the value leaks into version control, and every method repeats the host. Secrets/hosts belong in environment configuration, not literals.

**The fix (as implemented in this repo)**

- **Centralised client + environment base URL + endpoint constants.** Base URL comes from `String.fromEnvironment('BASE_URL')` ([`variables.dart:2`](../lib/core/environment/variables.dart)), and paths are constants in [`EndPoints`](../lib/core/network/endpoints.dart) used through [`DioHelper`](../lib/core/network/dio_helper.dart). No host is ever written in a service.
- **Return typed models, not `dynamic`.** Parse into `PointsBalance` / `TransactionsPage` (`@JsonSerializable`).
- **Return `Either<Failure, T>`** so errors are typed and localised ([`failures.dart`](../lib/core/errors/failures.dart)) instead of a bare `throw`.

A production `WalletRepository` implementation following the repo's conventions looks like this — note it implements the **same interface and `Either` contract** the existing [`MockWalletRepository`](../lib/features/wallet/data/repositories/wallet_repository.dart) already satisfies:

```dart
@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  WalletRepositoryImpl(this._dio);
  final DioHelper _dio;

  @override
  Future<Either<Failure, PointsBalance>> getBalance() async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(EndPoints.balance);
      return Right(PointsBalance.fromJson(res.data!));
    } on Exception catch (e) {
      return Left(Failure.fromException(e)); // typed + localised
    }
  }

  @override
  Future<Either<Failure, PointsBalance>> transferPoints({
    required String recipient,
    required int amount,
    String? note,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        EndPoints.transferPoints,
        data: {'recipient': recipient, 'amount': amount, 'note': note},
      );
      return Right(PointsBalance.fromJson(res.data!)); // status checked by Dio
    } on Exception catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
```

Auth headers, the `Bearer` token, the `401` refresh-and-retry, and timeouts are all handled by `AuthInterceptor`/`DioHelper`, so this method stays focused on its one job.

### Snippet 2 — network call made in the UI

> A `GET` request is performed directly in a widget.

**Problems**

- **No separation of concerns.** Networking inside `build`/`initState` couples the widget to Dio, so the screen can't be unit-tested without real HTTP, and the same call can't be reused elsewhere.
- **Performance / rebuild hazards.** A request kicked off in `build` re-fires on every rebuild; results held in local `setState` rebuild the **entire** widget subtree and are lost on navigation. There's no cancellation, no de-duplication, and no shared cache.

**The fix (as implemented in this repo)**

The UI only **dispatches events** and **renders state**; the call lives in the bloc → repository. From [`WalletScreen`](../lib/features/wallet/presentation/screens/wallet_screen.dart):

```dart
// initState: ask for data — don't fetch it here
final bloc = context.read<WalletBloc>();
bloc.add(const LoadBalance());
bloc.add(const LoadTransactions(TransactionFilter.all));
```

```dart
// WalletBloc delegates to the repository (the abstraction), not Dio
final result = await _repository.getTransactions(filter: event.filter, page: 1);
result.fold(
  (failure) => emit(state.copyWith(status: FailedStatus(error: failure.errMessage))),
  (pageData) => emit(state.copyWith(status: const SuccessStatus(), ...)),
);
```

`getTransactions` is the model to follow: the widget never imports Dio, the request is testable in isolation (inject a fake `WalletRepository`), and only the `BlocBuilder`/`BlocSelector` that depends on the changed slice rebuilds — not the whole screen.

### Snippet 3 — `TransactionList` uses `ListView`

```dart
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: transactions.map((t) {
        return Card(
          child: ListTile(
            leading: Image.network(t.merchantLogo, width: 40, height: 40),
            title: Text(t.description),
            subtitle: Text(DateFormat('MMM dd, yyyy').format(t.createdAt)),
          ),
        );
      }).toList(),
    );
  }
}
```

**Problem (performance)**

`ListView(children: …)` with `.map().toList()` **eagerly builds a widget for every transaction up front**, even the hundreds that are off-screen, and `Image.network` re-downloads/re-decodes images as you scroll. For a long activity feed this wastes memory and CPU and causes jank.

**The fix — `ListView.builder` / `SliverList.builder` (build only visible rows)**

A `*.builder` list is **lazy**: it calls `itemBuilder` only for the rows in (and near) the viewport and recycles them as you scroll, so cost is bounded by what's visible, not by list length. Pair it with a cached, sized image.

The minimal corrected widget:

```dart
class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transactions});
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, i) => TransactionListItem(transaction: transactions[i]),
    );
  }
}
```

This repo applies exactly that principle. The transaction feed in [`WalletScreen`](../lib/features/wallet/presentation/screens/wallet_screen.dart) renders through a **virtualized `SliverList.builder`** inside a `CustomScrollView` (the sliver form so the balance card, filter chips, and list share one scroll view while the list still virtualizes):

```dart
SliverList.builder(
  itemCount: state.transactions.length,
  itemBuilder: (context, i) {
    final item = TransactionListItem(transaction: state.transactions[i]);
    return i == 0
        ? item
        : Column(mainAxisSize: MainAxisSize.min,
            children: [Divider(height: 1, color: theme.hair), item]);
  },
)
```

Rows are a `const`-constructable `TransactionListItem`, and the merchant logo uses `CustomCachedImage` (`cached_network_image`) rather than `Image.network`, so images are cached and decoded once. `DecoratedSliver` + `SliverMainAxisGroup` keep the rounded "card" look and the trailing load-more spinner around the virtualized list.

### Snippet 4 — `WalletBloc`

```dart
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository repository;
  WalletBloc(this.repository) : super(WalletInitial()) {
    on<LoadWallet>((event, emit) async {
      emit(WalletLoading());
      final balance = await repository.getBalance();
      final transactions = await repository.getTransactions();
      emit(WalletLoaded(balance, transactions));
    });
    on<FilterTransactions>((event, emit) {
      if (state is WalletLoaded) {
        final currentState = state as WalletLoaded;
        final filtered = currentState.transactions
            .where((t) => t.type == event.type)
            .toList();
        emit(WalletLoaded(currentState.balance, filtered));
      }
    });
  }
}
```

**Problems**

1. **Two GETs in one handler, run sequentially.** `getTransactions()` is `await`-ed *after* `getBalance()`, so transactions can't even start until the balance round-trip finishes — the two independent calls are needlessly serialised, doubling time-to-content. They also share one loading/error state, so if balance fails the user sees no transactions either.
2. **No pagination.** `getTransactions()` fetches everything at once; there is no `page` / `hasReachedMax` / "load more", so a large history is one giant request held entirely in memory.
3. **Filtering throws away data.** `FilterTransactions` overwrites `transactions` with the filtered subset, so switching back to "all" can't recover the hidden items without a refetch, and counts drift.

**The fix (as implemented in this repo)**

[`WalletBloc`](../lib/features/wallet/bloc/wallet_bloc.dart) splits the work into independent, paginated events with concurrency transformers (`wallet_bloc.dart:18-20`):

```dart
on<LoadBalance>(_onLoadBalance);
on<LoadTransactions>(_onLoadTransactions, transformer: restartable());
on<LoadMoreTransactions>(_onLoadMoreTransactions, transformer: droppable());
```

- **Balance and transactions are separate events** with their own lifecycles, so balance loading never blocks the feed; the screen fires both in `initState` and each renders as it arrives.
- **Pagination is first-class.** `LoadTransactions` resets to page 1; `LoadMoreTransactions` appends the next page and respects `hasReachedMax` (`wallet_bloc.dart:86-112`), and the state carries `page` / `hasReachedMax` ([`wallet_state.dart:19-20`](../lib/features/wallet/bloc/wallet_state.dart)).
- **Filtering refetches page 1 for the chosen filter** (server-side filter via the repository) instead of mutating the in-memory list, and `restartable()` cancels a superseded filter load.

> Note: counts for the filter chips are loaded alongside the balance in `_onLoadBalance` so the chip badges stay accurate regardless of the active filter.

### Snippet 5 — performance question

> **List 5 performance optimization techniques for a Flutter app that displays a large list of transactions with images. Explain when and why each is beneficial.**

**1. Lazy, virtualized lists (`ListView.builder` / `SliverList.builder`).**
*When:* any list whose length is large or unbounded.
*Why:* builds and retains only the rows in/near the viewport and recycles them while scrolling, so memory and build cost scale with what's visible, not with total item count. Used here via `SliverList.builder` in [`WalletScreen`](../lib/features/wallet/presentation/screens/wallet_screen.dart).

**2. Cached, downscaled network images.**
*When:* image-heavy rows (merchant logos, avatars).
*Why:* a disk/memory cache (`cached_network_image`) avoids re-downloading and re-decoding the same image on every scroll pass, and decoding to the *display* size (fixed `width`/`height`, `cacheWidth`/`memCacheWidth`) keeps full-resolution bitmaps out of memory. See [`CustomCachedImage`](../lib/core/presentation/widgets/custom_cached_image.dart).

**3. `const` constructors + scoped rebuilds.**
*When:* widgets that don't depend on changing state, and screens with frequent state updates.
*Why:* `const` subtrees are canonicalised and skipped during rebuilds; `BlocSelector` / `buildWhen` / `Equatable` confine a rebuild to the slice that actually changed instead of the whole tree. See `TransactionListItem` and the scoped builders in `WalletScreen`.

**4. Pagination / lazy loading.**
*When:* datasets too large to fetch or hold at once.
*Why:* fetching a page at a time (with infinite scroll) bounds network payload and memory and gets first content on screen sooner. Implemented via `LoadMoreTransactions` + `page`/`hasReachedMax` and a `ScrollController` threshold.

**5. Memory management.**
*When:* long-lived list screens and in-flight async work.
*Why:* dispose controllers (the `ScrollController` is removed and disposed in `dispose()`), cancel superseded/in-flight requests (`bloc_concurrency`'s `restartable`/`droppable`; Dio `CancelToken` is available through `DioHelper`), and rely on the image cache's eviction so bitmap memory stays bounded. Wrapping expensive, independently-animating rows in a `RepaintBoundary` further isolates repaints.

---

## Part 3 — Performance evaluation

| # | Criterion | Status | Where |
|---|-----------|--------|-------|
| 1 | Proper use of `const` constructors | ✅ | `TransactionListItem`, `WalletScreen` subtrees |
| 2 | Efficient widget rebuilds (avoid unnecessary rebuilds) | ✅ | `BlocSelector`, `buildWhen`, `Equatable` states |
| 3 | Image caching & optimization | ✅ | `CustomCachedImage` (`cached_network_image`) |
| 4 | Lazy loading & pagination | ✅ | `LoadMoreTransactions`, `page`/`hasReachedMax`, infinite scroll |
| 5 | `ListView.builder` vs `ListView` | ✅ | `SliverList.builder` in `WalletScreen` |
| 6 | State-management efficiency (no whole-tree rebuilds) | ✅ | scoped builders + `restartable`/`droppable` |
| 7 | Memory management | ✅ | controller `dispose`, request cancellation, image-cache eviction |

**1. `const` constructors.** Row widgets and their children are `const` ([`transaction_list_item.dart:13-16`](../lib/features/wallet/presentation/widgets/transaction_list_item.dart) and its `const SizedBox`/`Padding` children), and `WalletScreen` uses `const` throughout its static subtrees. Const widgets are reused rather than rebuilt, reducing element churn during scroll and state changes.

**2. Efficient widget rebuilds.** Rebuilds are deliberately narrow: `_balanceSection` uses a `BlocSelector` over `(balance, isInProgress)`; `_chips` uses `buildWhen: filter || counts`; the list `BlocBuilder` uses `buildWhen: transactions || status || hasReachedMax` (all in [`wallet_screen.dart`](../lib/features/wallet/presentation/screens/wallet_screen.dart)). Because every `WalletState` is an `Equatable` value, identical states short-circuit and don't rebuild at all. A balance refresh therefore doesn't rebuild the list, and vice-versa.

**3. Image caching & optimization.** Merchant logos render through [`CustomCachedImage`](../lib/core/presentation/widgets/custom_cached_image.dart): `cached_network_image` provides disk + memory caching, with a placeholder, an error fallback, fixed `width`/`height`, and `FilterQuality.high` (`custom_cached_image.dart:30-42`). Images are fetched and decoded once and reused across rebuilds and scroll.

**4. Lazy loading & pagination.** The repository contract is paginated (`getTransactions({filter, page, pageSize})`, [`wallet_repository.dart:16-20`](../lib/features/wallet/data/repositories/wallet_repository.dart)); `WalletBloc` appends pages via `LoadMoreTransactions` and stops at `hasReachedMax` (`wallet_bloc.dart:86-112`); `WalletScreen` triggers the next page when `extentAfter < 300` and auto-loads when the first page underfills the viewport (`_onScroll` / `_maybeAutoLoad`). Memory and payload stay bounded regardless of total history size.

**5. `ListView.builder` vs `ListView`.** The feed uses a virtualized `SliverList.builder` inside a `CustomScrollView` (`wallet_screen.dart`, `_activitySliver`) rather than an eager `ListView(children: …)`. Only on-screen rows are built and recycled; `DecoratedSliver` + `SliverMainAxisGroup` preserve the card styling and the trailing load-more spinner without breaking virtualization, and the whole screen (balance + chips + list) still shares a single scroll view.

**6. State-management efficiency.** Beyond scoped builders, `bloc_concurrency` keeps work minimal: `restartable()` cancels a superseded filter load and `droppable()` discards redundant "load more" events (`wallet_bloc.dart:19-20`), so the bloc never processes stale or duplicate fetches that would emit throw-away states.

**7. Memory management.** The `ScrollController` listener is removed and the controller disposed in `dispose()` (`wallet_screen.dart`, `dispose`), preventing leaks. In-flight/superseded requests are cancelled by the concurrency transformers, and Dio `CancelToken` support is available through [`DioHelper`](../lib/core/network/dio_helper.dart) for finer-grained cancellation. The `cached_network_image` cache evicts under memory pressure, keeping bitmap memory bounded on long sessions.

**Overall:** the wallet feature applies the standard Flutter performance toolkit end-to-end — `const` subtrees, narrowly-scoped rebuilds, cached/sized images, a virtualized builder list, first-class pagination, and disciplined disposal/cancellation.
