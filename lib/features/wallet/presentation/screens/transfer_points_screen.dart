import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:shop_plus/config/themes/extensions/theme_extension_x.dart';
import 'package:shop_plus/core/presentation/widgets/buttons/m_button.dart';
import 'package:shop_plus/core/presentation/widgets/input_fields/text_input.dart';
import 'package:shop_plus/core/presentation/widgets/snackbars/show_snackbar.dart';
import 'package:shop_plus/core/typography.dart';
import 'package:shop_plus/core/utils/secure_screen_mixin.dart';
import 'package:shop_plus/core/utils/transfer_validators.dart';
import 'package:shop_plus/features/wallet/bloc/transfer_cubit.dart';
import 'package:shop_plus/features/wallet/bloc/wallet_bloc.dart';
import 'package:shop_plus/generated/l10n.dart';

class TransferPointsScreen extends StatefulWidget {
  const TransferPointsScreen({super.key});

  @override
  State<TransferPointsScreen> createState() => _TransferPointsScreenState();
}

class _TransferPointsScreenState extends State<TransferPointsScreen>
    with SecureScreenMixin {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _showSuccessDialog(
    BuildContext context,
    TransferState state,
  ) async {
    context.read<WalletBloc>().add(const LoadBalance());
    await showAdaptiveDialog<void>(
      context: context,
      builder: (_) => _TransferSuccessDialog(
        amount: state.amountValue,
        recipient: state.recipient.trim(),
        newBalance: state.newBalance?.totalPoints ?? 0,
      ),
    );
    if (context.mounted) Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final l = S.of(context);

    return BlocConsumer<TransferCubit, TransferState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          _showSuccessDialog(context, state);
        } else if (state.status.isFailed) {
          showAppSnackbar(
            context,
            title: switch (state.errorType) {
              'INSUFFICIENT_BALANCE' => l.insufficientBalance,
              'RECIPIENT_NOT_FOUND' => l.recipientNotFound,
              _ => l.somethingWentWrong,
            },
            type: SnackbarType.error,
          );
        }
      },
      builder: (context, state) {
        final isSuccess = state.status.isSuccess;
        return Scaffold(
          backgroundColor: theme.paper,
          appBar: AppBar(
            backgroundColor: theme.paper,
            elevation: 0,
            automaticallyImplyLeading: !isSuccess,
            title: Text(l.transferPoints),
          ),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: _TransferForm(formKey: _formKey, state: state),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TransferForm extends StatelessWidget {
  const _TransferForm({required this.formKey, required this.state});

  final GlobalKey<FormBuilderState> formKey;
  final TransferState state;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final balance =
        context.read<WalletBloc>().state.balance?.totalPoints ?? 0;
    final rErr = TransferValidators.recipient(state.recipient);
    final aErr = TransferValidators.amount(state.amount, balance);
    final valid =
        rErr == null &&
        aErr == null &&
        state.note.length <= TransferValidators.noteMaxLength;

    final hasAmount = state.amount.isNotEmpty && aErr == null;
    final ctaText = hasAmount
        ? l.transferCta(_fmt(state.amountValue))
        : l.transferPoints;

    final cubit = context.read<TransferCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _BalanceReminder(balance: balance),
                  const SizedBox(height: 20),
                  TextInput(
                    name: 'recipient',
                    label: l.recipient,
                    innerHint: l.recipientHint,
                    bottomHint: l.recipientHelper,
                    inputType: TextInputType.emailAddress,
                    onChanged: (v) => cubit.recipientChanged(v ?? ''),
                    validator: (v) =>
                        _recipientMsg(l, TransferValidators.recipient(v ?? '')),
                  ),
                  const SizedBox(height: 16),
                  TextInput(
                    name: 'amount',
                    label: l.pointsToTransfer,
                    innerHint: l.amountHint,
                    bottomHint: l.amountHelper,
                    inputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (v) => cubit.amountChanged(v ?? ''),
                    validator: (v) => _amountMsg(
                      l,
                      TransferValidators.amount(v ?? '', balance),
                      balance,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _QuickChips(balance: balance, state: state),
                  const SizedBox(height: 16),
                  TextInput(
                    name: 'note',
                    label: l.noteOptional,
                    innerHint: l.noteHint,
                    maxLines: 3,
                    maxLength: TransferValidators.noteMaxLength,
                    onChanged: (v) => cubit.noteChanged(v ?? ''),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: MButton.primary(
            text: ctaText,
            icon: Icons.send_rounded,
            isBlocked: !valid,
            isLoading: state.status.isInProgress,
            onPressed: cubit.submit,
          ),
        ),
      ],
    );
  }
}

class _BalanceReminder extends StatelessWidget {
  const _BalanceReminder({required this.balance});

  final int balance;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final l = S.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.hair),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: theme.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: theme.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.availableBalance.toUpperCase(),
                style: AppTypography.textXS(
                  weight: AppFontWeight.semibold,
                  color: theme.mute,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                '${_fmt(balance)} ${l.pointsUnit}',
                style: AppTypography.textLG(
                  weight: AppFontWeight.bold,
                  color: theme.ink,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickChips extends StatelessWidget {
  const _QuickChips({required this.balance, required this.state});

  final int balance;
  final TransferState state;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final entries = <(String, int)>[
      (_fmt(100), 100),
      (_fmt(500), 500),
      (_fmt(1000), 1000),
      (l.max, balance),
    ];
    return Row(
      children: [
        for (var i = 0; i < entries.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _AmountChip(
              label: entries[i].$1,
              active: state.amount == entries[i].$2.toString(),
              onTap: () {
                context.read<TransferCubit>().amountChanged(
                  entries[i].$2.toString(),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _AmountChip extends StatelessWidget {
  const _AmountChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? theme.primary : theme.tint,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: AppTypography.textSM(
            weight: AppFontWeight.bold,
            color: active ? theme.onPrimary : theme.primary,
          ),
        ),
      ),
    );
  }
}

String _fmt(int n) => NumberFormat.decimalPattern().format(n);

String? _recipientMsg(S l, RecipientError? e) => switch (e) {
  RecipientError.required => l.recipientRequired,
  RecipientError.invalid => l.recipientInvalid,
  RecipientError.invalidEmail => l.recipientInvalidEmail,
  null => null,
};

String? _amountMsg(S l, AmountError? e, int balance) => switch (e) {
  AmountError.required => l.amountRequired,
  AmountError.wholeOnly => l.amountWholeOnly,
  AmountError.min => l.amountMin,
  AmountError.max => l.amountMax(_fmt(balance)),
  null => null,
};

class _TransferSuccessDialog extends StatelessWidget {
  const _TransferSuccessDialog({
    required this.amount,
    required this.recipient,
    required this.newBalance,
  });

  final int amount;
  final String recipient;
  final int newBalance;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final l = S.of(context);
    return AlertDialog.adaptive(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: theme.greenSoft,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_rounded, color: theme.green, size: 34),
          ),
          const SizedBox(height: 12),
          Text(
            l.transferSent,
            textAlign: TextAlign.center,
            style: AppTypography.textLG(
              weight: AppFontWeight.bold,
              color: theme.ink,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l.youSentToRecipient(_fmt(amount), recipient),
            textAlign: TextAlign.center,
            style: AppTypography.textSM(color: theme.subink),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: theme.surfaceMute,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              l.newBalanceLabel(_fmt(newBalance)),
              textAlign: TextAlign.center,
              style: AppTypography.textSM(
                weight: AppFontWeight.semibold,
                color: theme.ink,
              ),
            ),
          ),
        ],
      ),
      actions: [
        _AdaptiveAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l.backToWallet),
        ),
      ],
    );
  }
}

class _AdaptiveAction extends StatelessWidget {
  const _AdaptiveAction({required this.onPressed, required this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
      default:
        return TextButton(onPressed: onPressed, child: child);
    }
  }
}
