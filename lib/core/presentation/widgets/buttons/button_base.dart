part of './m_button.dart';

class _ButtonBase extends StatelessWidget {
  final bool isBlocked;
  final Widget Function(BuildContext) builder;

  const _ButtonBase({this.isBlocked = false, required this.builder});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isBlocked,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        layoutBuilder: (currentChild, previousChildren) => Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: <Widget>[...previousChildren, ?currentChild],
        ),
        child: Builder(key: ValueKey(isBlocked), builder: builder),
      ),
    );
  }
}
