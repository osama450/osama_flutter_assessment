import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_plus/config/routes/app_router.dart';
import 'package:shop_plus/config/themes/extensions/theme_extension_x.dart';
import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/features/shared/cubit/shared_cubit.dart';
import 'package:responsive_wrapper/responsive_wrapper.dart';
import 'package:shop_plus/core/presentation/widgets/empty_widget.dart';
import 'package:shop_plus/core/presentation/widgets/snackbars/show_snackbar.dart';
import 'package:shop_plus/features/wallet/bloc/wallet_bloc.dart';
import 'package:shop_plus/features/wallet/data/models/points_balance.dart';
import 'package:shop_plus/features/wallet/data/models/transaction_type.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/balance_card.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/transaction_filter_chips.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/transaction_list_item.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/wallet_error_view.dart';
import 'package:shop_plus/features/wallet/presentation/widgets/wallet_loading_shimmer.dart';
import 'package:shop_plus/generated/l10n.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final bloc = context.read<WalletBloc>();
    bloc.add(const LoadBalance());
    bloc.add(const LoadTransactions(TransactionFilter.all));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final state = context.read<WalletBloc>().state;
    if (state.hasReachedMax || state.status.isInProgress) return;
    if (_scrollController.position.extentAfter < 300) {
      context.read<WalletBloc>().add(const LoadMoreTransactions());
    }
  }

  void _maybeAutoLoad() {
    if (!mounted || !_scrollController.hasClients) return;
    final state = context.read<WalletBloc>().state;
    if (state.status.isInProgress ||
        state.hasReachedMax ||
        state.transactions.isEmpty) {
      return;
    }
    if (_scrollController.position.maxScrollExtent <= 0) {
      context.read<WalletBloc>().add(const LoadMoreTransactions());
    }
  }

  Future<void> _refresh() async {
    final bloc = context.read<WalletBloc>();
    bloc.add(const LoadBalance());
    bloc.add(LoadTransactions(bloc.state.filter));
    await bloc.stream.firstWhere((s) => !s.status.isInProgress);
  }

  void _onFilter(TransactionFilter filter) {
    context.read<WalletBloc>().add(LoadTransactions(filter));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Scaffold(
      backgroundColor: theme.paper,
      appBar: AppBar(
        backgroundColor: theme.paper,
        elevation: 0,
        title: Text(S.of(context).wallet),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: TextButton(
              onPressed: () => context.read<SharedCubit>().changeLang(),
              style: TextButton.styleFrom(
                foregroundColor: theme.primary,
                minimumSize: const Size(44, 44),
              ),
              child: Text(
                S.of(context).changeLocalizationLanguage,
                style: AppTypography.textMD(
                  weight: AppFontWeight.bold,
                  color: theme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRouter.transfer),
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
        icon: const Icon(Icons.send_rounded),
        label: Text(S.of(context).transferPoints),
      ),
      body: BlocListener<WalletBloc, WalletState>(
        listenWhen: (p, c) =>
            p.status != c.status ||
            p.transactions.length != c.transactions.length,
        listener: (context, state) {
          if (state.status.isFailed && state.transactions.isNotEmpty) {
            showAppSnackbar(
              context,
              title: S.of(context).somethingWentWrong,
              type: SnackbarType.error,
              description: state.errorMessage,
            );
          }
          if (state.status.isSuccess) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => _maybeAutoLoad(),
            );
          }
        },
        child: RefreshIndicator(
          onRefresh: _refresh,
          // A single CustomScrollView per layout keeps the whole screen
          // scrollable while the transaction list virtualizes through
          // SliverList.builder (only on-screen rows are built).
          child: BlocBuilder<WalletBloc, WalletState>(
            buildWhen: (p, c) =>
                p.transactions != c.transactions ||
                p.status != c.status ||
                p.hasReachedMax != c.hasReachedMax,
            builder: (context, state) => ResponsiveLayout(
              useShortestSide: false,
              phone: (c) => _mobile(c, state),
              tablet: (c) => _wide(c, state),
              desktop: (c) => _wide(c, state),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mobile(BuildContext context, WalletState state) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _balanceSection(),
                const SizedBox(height: 20),
                _activityHeader(context),
                const SizedBox(height: 10),
                _chips(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: _activitySliver(context, state),
        ),
      ],
    );
  }

  Widget _wide(BuildContext context, WalletState state) {
    final balanceWidth = context.isDesktop ? 400.0 : 300.0;
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: balanceWidth, child: _balanceSection()),
            const SizedBox(width: 24),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _activityHeader(context),
                        const SizedBox(height: 10),
                        _chips(),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  _activitySliver(context, state),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityHeader(BuildContext context) {
    final theme = context.appTheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            S.of(context).recentActivity,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: theme.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        IconButton(
          onPressed: _refresh,
          icon: Icon(Icons.refresh_rounded, color: theme.primary),
          tooltip: S.of(context).retry,
        ),
      ],
    );
  }

  Widget _balanceSection() {
    return BlocSelector<WalletBloc, WalletState, (PointsBalance?, bool)>(
      selector: (s) => (s.balance, s.status.isInProgress),
      builder: (context, vm) {
        if (vm.$1 != null) return BalanceCard(balance: vm.$1!);
        if (vm.$2) return const WalletBalanceShimmer();
        return const SizedBox.shrink();
      },
    );
  }

  Widget _chips() {
    return BlocBuilder<WalletBloc, WalletState>(
      buildWhen: (p, c) => p.filter != c.filter || p.counts != c.counts,
      builder: (context, state) => TransactionFilterChips(
        selected: state.filter,
        counts: state.counts,
        onSelected: _onFilter,
      ),
    );
  }

  Widget _activitySliver(BuildContext context, WalletState state) {
    final theme = context.appTheme;
    final txEmpty = state.transactions.isEmpty;

    final Widget inner;
    if (txEmpty && state.status.isInProgress) {
      inner = const SliverToBoxAdapter(child: WalletListShimmer());
    } else if (txEmpty && state.status.isFailed) {
      inner = SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: WalletErrorView(
            message: state.errorMessage,
            onRetry: _refresh,
          ),
        ),
      );
    } else if (txEmpty && state.status.isSuccess) {
      inner = SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36),
          child: EmptyWidget(
            title: S.of(context).noTransactions,
            body: S.of(context).noTransactionsBody,
          ),
        ),
      );
    } else {
      inner = SliverMainAxisGroup(
        slivers: [
          SliverList.builder(
            itemCount: state.transactions.length,
            itemBuilder: (context, i) {
              final item = TransactionListItem(
                transaction: state.transactions[i],
              );
              if (i == 0) return item;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(height: 1, color: theme.hair),
                  item,
                ],
              );
            },
          ),
          if (!state.hasReachedMax)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      );
    }

    return DecoratedSliver(
      decoration: BoxDecoration(
        color: theme.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.hair),
      ),
      sliver: SliverPadding(padding: const EdgeInsets.all(8), sliver: inner),
    );
  }
}
