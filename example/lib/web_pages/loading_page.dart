import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

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
                  SBBWebText.headerOne('Loading Indicator', color: SBBColors.red),
                  SBBWebText.headerTwo('Ausprägungen'),
                  SBBWebText.headerThree('- Medium'),
                  const SBBLoadingIndicator.medium(),
                  SBBWebText.headerThree('- Tiny'),
                  const SBBLoadingIndicator.tiny()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
