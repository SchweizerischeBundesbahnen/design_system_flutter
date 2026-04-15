import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/theme_sliver_header_box.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DemoPageScaffold extends StatelessWidget {
  const DemoPageScaffold({
    super.key,
    required this.body,
    this.componentConfig,
  });

  /// Widget used as body in demo page. Scaffold is already scrollable.
  final Widget body;

  /// Custom config used for demo of component
  final Widget? componentConfig;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ThemeSliverHeaderbox(),
        SliverPadding(
          padding: EdgeInsets.all(SBBSpacing.xSmall).copyWith(bottom: SBBSpacing.xLarge),
          sliver: SliverList.list(
            children: [
              if (componentConfig != null) ...[
                SBBListHeader('Component config & actions'),
                SBBContentBox(child: componentConfig!),
                const SizedBox(height: SBBSpacing.xSmall),
              ],
              body,
            ],
          ),
        ),
      ],
    );
  }
}
