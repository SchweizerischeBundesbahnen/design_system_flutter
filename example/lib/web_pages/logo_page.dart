import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: SingleChildScrollView(
          primary: false,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBBWebText.headerOne('SBB  Logo', color: SBBColors.red),
                  SBBWebText.headerTwo('Ausprägungen'),
                  SBBWebText.headerThree('- Signet'),
                  SizedBox(width: 100, child: SBBWebLogo(width: 100)),
                  SBBWebText.headerThree('- With Text'),
                  Row(
                    children: [
                      SizedBox(
                          width: 100,
                          child: SBBWebLogo(
                            width: 100,
                          )),
                      SizedBox(width: sbbDefaultSpacing),
                      Text(
                        'SBB CFF FFS',
                        style: SBBWebTextStyles.headerTitle.copyWith(
                          fontSize: 32,
                          color: SBBColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SBBWebText.headerThree('- Black on White'),
                  SizedBox(
                    width: 100,
                    child: SBBWebLogo(
                        width: 100,
                        foregroundColor: SBBColors.white,
                        backgroundColor: SBBColors.black),
                  ),
                  SBBWebText.headerThree('- On Red'),
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: SBBColors.red),
                      child: SBBWebLogo(
                        width: 100,
                        borderColor: SBBColors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
