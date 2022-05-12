import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SBBInternal {
  SBBInternal._();

  static const defaultButtonHeight = 44.0;
  static const defaultButtonHeightSmall = 32.0;
  static const webMinButtonWidth = 60.0;
  static const webMaxButtonWidth = 300.0;

  static const barrierColor = Color(0x80000000);

  static const defaultBoxShadow = <BoxShadow>[
    BoxShadow(
      color: Color(0x18000000),
      blurRadius: 15,
    )
  ];
}

class SBBButtonContent extends StatelessWidget {
  const SBBButtonContent({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
