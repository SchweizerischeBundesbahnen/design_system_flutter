import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({Key? key}) : super(key: key);

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
                  'SBB Lean Logo',
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
                  '- Signet',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              SizedBox(
                  width: 100,
                  child: SBBLeanLogo(
                    width: 100,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  '- With text',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                      width: 100,
                      child: SBBLeanLogo(
                        width: 100,
                      )),
                  SizedBox(width: sbbDefaultSpacing),
                  Text(
                    'SBB CFF FFS',
                    style: SBBLeanTextStyles.headerTitle.copyWith(
                      fontSize: 32,
                      color: SBBColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  '- Black on White',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              SizedBox(
                width: 100,
                child: SBBLeanLogo(
                  width: 100,
                  foregroundColor: SBBColors.white,
                  backgroundColor: SBBColors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  '- On Red',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              SizedBox(
                height: 100,
                width: 300,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: SBBColors.red),
                  child: SBBLeanLogo(
                    width: 100,
                    borderColor: SBBColors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
