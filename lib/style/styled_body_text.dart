import 'package:flutter/cupertino.dart';

class StyledBodyText extends StatelessWidget {
  const StyledBodyText(this.text, this.isBold, this.size,{super.key});

  final String text;
  final bool isBold;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
      fontSize: size,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    ));
  }
}
