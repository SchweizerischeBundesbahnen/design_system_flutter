import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: SingleChildScrollView(
          primary: false,
          child: DecoratedBox(
            decoration: BoxDecoration(color: SBBColors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SBBWebText.headerOne('Buttons', color: SBBColors.red),
                    SBBWebText.headerTwo('Ausprägungen'),
                    ButtonExpression(
                      label: '- Primary Button',
                      buttonBuilder: (label, onPressed) =>
                          SBBPrimaryButton(label: label, onPressed: onPressed),
                    ),
                    ButtonExpression(
                      label: '- Alternate Button',
                      buttonBuilder: (label, onPressed) =>
                          SBBPrimaryButtonNegative(
                              label: label, onPressed: onPressed),
                    ),
                    ButtonExpression(
                      label: '- Secondary Button',
                      buttonBuilder: (label, onPressed) => SBBSecondaryButton(
                          label: label, onPressed: onPressed),
                    ),
                    ButtonExpression(
                      label: '- Ghost Button',
                      buttonBuilder: (label, onPressed) =>
                          SBBGhostButton(label: label, onPressed: onPressed),
                    ),
                    ButtonExpression(
                      label: '- Icon Button Primary',
                      buttonBuilder: (label, onPressed) => SBBIconButtonLarge(
                          buttonStyle: SBBButtonStyles.of(context).primaryWebLean,
                          icon: SBBIcons.pen_small, onPressed: onPressed),
                    ),
                    ButtonExpression(
                      label: '- Icon Button Alternate',
                      buttonBuilder: (label, onPressed) => SBBIconButtonLarge(
                        icon: SBBIcons.pen_small,
                        onPressed: onPressed,
                        buttonStyle: SBBButtonStyles.of(context).primaryWebNegative,
                      ),
                    ),
                    ButtonExpression(
                      label: '- Icon Button Secondary',
                      buttonBuilder: (label, onPressed) => SBBIconButtonLarge(
                        icon: SBBIcons.pen_small,
                        onPressed: onPressed,
                        buttonStyle: SBBButtonStyles.of(context).secondaryWebLean,
                      ),
                    ),
                    ButtonExpression(
                      label: '- Icon Button Ghost',
                      buttonBuilder: (label, onPressed) => SBBIconButtonLarge(
                        icon: SBBIcons.pen_small,
                        onPressed: onPressed,
                        buttonStyle: SBBButtonStyles.of(context).ghostWebLean,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonExpression extends StatelessWidget {
  const ButtonExpression(
      {Key? key, required this.label, required this.buttonBuilder})
      : super(key: key);
  final String label;
  final Widget Function(String label, VoidCallback? onPressed) buttonBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SBBWebText.headerThree(label),
        Row(children: [
          Flexible(child: buttonBuilder('Label', () {})),
          SizedBox(width: sbbDefaultSpacing),
          Flexible(child: buttonBuilder('Label', null)),
        ]),
      ],
    );
  }
}
