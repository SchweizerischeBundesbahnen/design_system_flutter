import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoadingIndicatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: ThemeModeSegmentedButton(),
          ),
          const SBBLoadingIndicator.tiny(),
          const SBBLoadingIndicator.tinyCloud(),
          const SBBLoadingIndicator.medium(),
        ],
      ),
    );
  }
}
