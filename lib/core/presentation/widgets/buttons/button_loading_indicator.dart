part of './m_button.dart';

class _ButtonLoadingIndicator extends StatelessWidget {
  const _ButtonLoadingIndicator({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(color: color, strokeWidth: 2),
      ),
    );
  }
}
