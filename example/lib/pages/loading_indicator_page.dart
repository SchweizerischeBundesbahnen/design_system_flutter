import 'package:design_system_flutter/design_system_flutter.dart';
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
