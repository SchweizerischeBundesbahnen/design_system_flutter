import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'render_sliver_pin_header.dart';

/// The SBB Sliver Header-Box.
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/container/)
///
/// Allows using the SBB Header-Box in a scrollable content.
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
/// This will lead to the expected behavior of the SBB Header-Box.
///
/// See [SBBHeaderBox] for a headerbox that behaves as expected in non scrollable content.
class SBBSliverHeaderBox extends SingleChildRenderObjectWidget {
  /// The default [SBBSliverHeaderBox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBTertiaryButtonSmall] with a label and an icon.
  ///
  /// Use the [margin] to adjust space around the header box - the default is horizontal margin of 8px.
  ///
  /// For a complete customization of the header box, see the [SBBSliverHeaderBox.custom] constructor.
  SBBSliverHeaderBox({
    super.key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderBoxFlap? flap,
    EdgeInsets margin = const .symmetric(horizontal: SBBSpacing.xSmall),
    String? semanticsLabel,
  }) : super(
         child: SBBHeaderBox(
           title: title,
           leadingIcon: leadingIcon,
           secondaryLabel: secondaryLabel,
           trailingWidget: trailingWidget,
           margin: margin,
           flap: flap,
           semanticsLabel: semanticsLabel,
         ),
       );

  /// The large [SBBSliverHeaderBox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBIconButtonLarge].
  ///
  /// Use the [margin] to adjust space around the header box - the default is horizontal margin of 8px.
  ///
  /// For a complete customization of the header box, see the [SBBSliverHeaderBox.custom] constructor.
  SBBSliverHeaderBox.large({
    super.key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderBoxFlap? flap,
    EdgeInsets margin = const .symmetric(horizontal: SBBSpacing.xSmall),
    String? semanticsLabel,
  }) : super(
         child: SBBHeaderBox.large(
           title: title,
           leadingIcon: leadingIcon,
           secondaryLabel: secondaryLabel,
           trailingWidget: trailingWidget,
           margin: margin,
           flap: flap,
           semanticsLabel: semanticsLabel,
         ),
       );

  /// Allows complete customization of the [SBBSliverHeaderBox].
  SBBSliverHeaderBox.custom({
    super.key,
    required Widget child,
    EdgeInsets margin = const .symmetric(horizontal: SBBSpacing.xSmall),
    EdgeInsets padding = const .all(SBBSpacing.medium),
    SBBHeaderBoxFlap? flap,
    String? semanticsLabel,
  }) : super(
         child: SBBHeaderBox.custom(
           margin: margin,
           padding: padding,
           flap: flap,
           semanticsLabel: semanticsLabel,
           child: child,
         ),
       );

  @override
  RenderSliverPinHeader createRenderObject(BuildContext context) {
    return RenderSliverPinHeader();
  }
}
