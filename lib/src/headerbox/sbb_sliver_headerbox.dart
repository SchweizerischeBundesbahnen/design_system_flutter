import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/headerbox/sbb_sliver_floating_headerbox.dart';
import 'package:sbb_design_system_mobile/src/headerbox/sbb_sliver_static_headerbox.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Sliver Headerbox.
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/container/)
///
/// Allows using the SBB Headerbox in a scrollable content.
/// Place this Widget in a [CustomScrollView].
///
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return CustomScrollView(
///     slivers: [
///       SBBSliverHeaderbox(title: 'My awesome Headerbox'),
///       SliverList.builder(
///         itemCount: 60,
///         itemBuilder: (context, index) => SBBListItem(
///           title: 'Item $index',
///           onPressed: () {},
///         ),
///       ),
///     ],
///   );
/// }
/// ```
///
/// This will lead to the expected behavior of the SBB Headerbox.
///
/// See [SBBHeaderbox] for a headerbox that behaves as expected in non scrollable content.
class SBBSliverHeaderbox extends StatelessWidget {
  /// The default [SBBSliverHeaderbox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBTertiaryButtonSmall] with a label and an icon.
  ///
  /// Use the [margin] to adjust space around the Headerbox - the default is horizontal margin of 8px.
  ///
  /// For a complete customization of the Headerbox, see the [SBBSliverHeaderbox.custom] constructor.
  SBBSliverHeaderbox({
    super.key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin =
        const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
    bool floating = false,
  }) : child = floating
            ? SBBSliverFloatingHeaderbox(
                title: title,
                leadingIcon: leadingIcon,
                secondaryLabel: secondaryLabel,
                trailingWidget: trailingWidget,
                margin: margin,
                flap: flap,
                semanticsLabel: semanticsLabel,
              )
            : SBBSliverStaticHeaderbox(
                title: title,
                leadingIcon: leadingIcon,
                secondaryLabel: secondaryLabel,
                trailingWidget: trailingWidget,
                margin: margin,
                flap: flap,
                semanticsLabel: semanticsLabel,
              );

  /// The large [SBBSliverHeaderbox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBIconButtonLarge].
  ///
  /// Use the [margin] to adjust space around the Headerbox - the default is horizontal margin of 8px.
  ///
  /// For a complete customization of the Headerbox, see the [SBBSliverHeaderbox.custom] constructor.
  SBBSliverHeaderbox.large({
    super.key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin =
        const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
    bool floating = false,
  }) : child = floating
            ? SBBSliverFloatingHeaderbox.large(
                title: title,
                leadingIcon: leadingIcon,
                secondaryLabel: secondaryLabel,
                trailingWidget: trailingWidget,
                margin: margin,
                flap: flap,
                semanticsLabel: semanticsLabel,
              )
            : SBBSliverStaticHeaderbox.large(
                title: title,
                leadingIcon: leadingIcon,
                secondaryLabel: secondaryLabel,
                trailingWidget: trailingWidget,
                margin: margin,
                flap: flap,
                semanticsLabel: semanticsLabel,
              );

  /// Allows complete customization of the [SBBSliverHeaderbox].
  SBBSliverHeaderbox.custom({
    super.key,
    required Widget child,
    EdgeInsets margin =
        const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    EdgeInsets padding = const EdgeInsets.all(sbbDefaultSpacing),
    SBBHeaderboxFlap? flap,
    String? semanticsLabel,
    bool floating = false,
  }) : child = floating
            ? SBBSliverFloatingHeaderbox.custom(
                margin: margin,
                padding: padding,
                flap: flap,
                semanticsLabel: semanticsLabel,
                child: child,
              )
            : SBBSliverStaticHeaderbox.custom(
                margin: margin,
                padding: padding,
                flap: flap,
                semanticsLabel: semanticsLabel,
                child: child,
              );

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
