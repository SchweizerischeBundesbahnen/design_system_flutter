import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Buttons',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 25, color: SBBColors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Ausprägungen',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 20, color: SBBColors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  '- Primary Button',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              SizedBox(
                  width: 200,
                  child: SBBPrimaryButton(label: 'Label', onPressed: () {})),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  '- Alternate Primary Button',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              SizedBox(
                  width: 200,
                  child: SBBPrimaryButtonNegative(
                      label: 'Label', onPressed: () {})),
            ],
          ),
        ),
      ),
    );
  }
}
