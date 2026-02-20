import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class LoadingIndicatorPage extends StatelessWidget {
  const LoadingIndicatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(padding: .all(SBBSpacing.medium), child: ThemeModeSegmentedButton()),
          SBBLoadingIndicator.tiny(),
          SBBLoadingIndicator.tinyCloud(),
          SBBLoadingIndicator.medium(),
        ],
      ),
    );
  }
}
