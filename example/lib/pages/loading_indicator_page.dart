import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class LoadingIndicatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(sbbDefaultSpacing),
            child: ThemeModeSegmentedButton(),
          ),
          SBBLoadingIndicator.tiny(),
          SBBLoadingIndicator.tinyCloud(),
          SBBLoadingIndicator.medium(),
        ],
      ),
    );
  }
}
