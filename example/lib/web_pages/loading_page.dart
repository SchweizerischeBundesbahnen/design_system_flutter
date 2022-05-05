import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

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
                  'Loading Indicator',
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
                  '- Medium',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              const SBBLoadingIndicator.medium(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  '- Tiny',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              const SBBLoadingIndicator.tiny()
            ],
          ),
        ),
      ),
    );
  }
}
