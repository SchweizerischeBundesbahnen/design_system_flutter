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
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Buttons',
                  style: SBBWebTextStyles.headerTitle
                      .copyWith(fontSize: 25, color: SBBColors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Ausprägungen',
                  style: SBBWebTextStyles.headerTitle
                      .copyWith(fontSize: 20, color: SBBColors.black),
                ),
              ),
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
                button: SBBIconButtonWeb.primary(
                    icon: SBBIcons.pen_small, onPressed: () {}),
                buttonDisabled: SBBIconButtonWeb.primary(
                    icon: SBBIcons.pen_small, onPressed: null),
              ),
              ButtonExpression(
                label: '- Icon Button Alternate',
                button: SBBIconButtonWeb.alternate(
                    icon: SBBIcons.pen_small, onPressed: () {}),
                buttonDisabled: SBBIconButtonWeb.alternate(
                    icon: SBBIcons.pen_small, onPressed: null),
              ),
              ButtonExpression(
                label: '- Icon Button Secondary',
                button: SBBIconButtonWeb.secondary(
                    icon: SBBIcons.pen_small, onPressed: () {}),
                buttonDisabled: SBBIconButtonWeb.secondary(
                    icon: SBBIcons.pen_small, onPressed: null),
              ),
              ButtonExpression(
                label: '- Icon Button Ghost',
                button: SBBIconButtonWeb.ghost(
                    icon: SBBIcons.pen_small, onPressed: () {}),
                buttonDisabled: SBBIconButtonWeb.ghost(
                    icon: SBBIcons.pen_small, onPressed: null),
              )
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
          child: Text(
            label,
            style: SBBWebTextStyles.headerTitle
                .copyWith(fontSize: 18, color: SBBColors.black),
          ),
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
