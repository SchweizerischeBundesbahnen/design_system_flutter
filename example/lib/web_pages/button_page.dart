import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: DecoratedBox(
          decoration: BoxDecoration(color: SBBColors.white),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SBBWebText.headerOne('Buttons', color: SBBColors.red),
              SBBWebText.headerTwo('Ausprägungen'),
              ButtonExpression(
                label: '- Primary Button',
                button: SBBPrimaryButton(label: 'Label', onPressed: () {}),
                buttonDisabled:
                    SBBPrimaryButton(label: 'Label', onPressed: null),
              ),
              ButtonExpression(
                label: '- Alternate Button',
                button:
                    SBBPrimaryButtonNegative(label: 'Label', onPressed: () {}),
                buttonDisabled:
                    SBBPrimaryButtonNegative(label: 'Label', onPressed: null),
              ),
              ButtonExpression(
                label: '- Secondary Button',
                button: SBBSecondaryButton(label: 'Label', onPressed: () {}),
                buttonDisabled:
                    SBBSecondaryButton(label: 'Label', onPressed: null),
              ),
              ButtonExpression(
                label: '- Ghost Button',
                button: SBBGhostButton(label: 'Label', onPressed: () {}),
                buttonDisabled: SBBGhostButton(label: 'Label', onPressed: null),
              ),
              ButtonExpression(
                label: '- Icon Button Primary',
                button: SBBIconButton.large(
                    icon: SBBIcons.pen_small, onPressed: () {}),
                buttonDisabled: SBBIconButton.large(
                    icon: SBBIcons.pen_small, onPressed: null),
              ),
              ButtonExpression(
                label: '- Icon Button Alternate',
                button: SBBIconButton.large(
                  icon: SBBIcons.pen_small,
                  onPressed: () {},
                  buttonStyle: SBBButtonStyles.iconAlternateWeb,
                ),
                buttonDisabled: SBBIconButton.large(
                  icon: SBBIcons.pen_small,
                  onPressed: null,
                  buttonStyle: SBBButtonStyles.iconAlternateWeb,
                ),
              ),
              ButtonExpression(
                label: '- Icon Button Secondary',
                button: SBBIconButton.large(
                  icon: SBBIcons.pen_small,
                  onPressed: () {},
                  buttonStyle: SBBButtonStyles.iconSecondaryWeb,
                ),
                buttonDisabled: SBBIconButton.large(
                  icon: SBBIcons.pen_small,
                  onPressed: null,
                  buttonStyle: SBBButtonStyles.iconSecondaryWeb,
                ),
              ),
              ButtonExpression(
                label: '- Icon Button Ghost',
                button: SBBIconButton.large(
                  icon: SBBIcons.pen_small,
                  onPressed: () {},
                  buttonStyle: SBBButtonStyles.iconGhostWeb,
                ),
                buttonDisabled: SBBIconButton.large(
                  icon: SBBIcons.pen_small,
                  onPressed: null,
                  buttonStyle: SBBButtonStyles.iconGhostWeb,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class ButtonExpression extends StatelessWidget {
  const ButtonExpression(
      {Key? key,
      required this.label,
      required this.button,
      required this.buttonDisabled})
      : super(key: key);
  final String label;
  final Widget button;
  final Widget buttonDisabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SBBWebText.headerThree(label),
        ),
        Row(children: [
          Flexible(child: button),
          SizedBox(width: sbbDefaultSpacing),
          Flexible(child: buttonDisabled),
        ]),
      ],
    );
  }
}
