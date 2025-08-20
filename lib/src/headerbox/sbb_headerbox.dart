import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';
import 'sbb_headerbox_content.dart';

const _headerBoxMinHeight = 56.0;
const _headerBoxNavBarExtensionHeight = 24.0;
const _headerBoxRadius = Radius.circular(sbbDefaultSpacing);
const _headerBoxFlapTopMargin = 8.0;

/// The SBB Headerbox.
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/container/)
///
/// To place over non scrollable screen content, place this Widget in a [Stack] with the content underneath.
///
/// ```dart
/// @override
/// Widget build(BuildContext context) {
///   return Stack(
///     children: [
///       _PageContentWidget(),
///       SBBHeaderbox(
///         title: 'Awesome Headerbox'
///       ),
///     ],
///   );
/// }
/// ```
///
/// This will lead to the expected behavior of the Headerbox.
///
/// See [SBBSliverHeaderbox] for a headerbox that behaves as expected in scrollable content,
/// or [SBBSliverFloatingHeaderbox] for a fully dynamic version in scrolling contexts.
class SBBHeaderbox extends StatelessWidget {
  /// The default [SBBHeaderbox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBTertiaryButtonSmall] with a label and an icon.
  ///
  /// Use the [margin] to adjust space around the Headerbox - the default is horizontal margin of 8px.
  ///
  /// For a complete customization of the Headerbox, see the [SBBHeaderbox.custom] constructor.
  SBBHeaderbox({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
  }) : this.custom(
          key: key,
          child: DefaultHeaderBoxContent(
            title: title,
            leadingIcon: leadingIcon,
            secondaryLabel: secondaryLabel,
            trailingWidget: trailingWidget,
          ),
          margin: margin,
          flap: flap,
          semanticsLabel: semanticsLabel,
        );

  /// The large [SBBHeaderbox].
  ///
  /// The required argument [title] will be ellipsed if too long. The [secondaryLabel] is the subtext
  /// displayed below and will wrap to multiple lines.
  ///
  /// The design guidelines specify an action button for the [trailingWidget],
  /// i.e. a [SBBIconButtonLarge].
  ///
  /// Use the [margin] to adjust space around the Headerbox - the default is horizontal margin of 8px.
  ///
  /// For a complete customization of the Headerbox, see the [SBBHeaderbox.custom] constructor.
  SBBHeaderbox.large({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    String? semanticsLabel,
  }) : this.custom(
          key: key,
          flap: flap,
          margin: margin,
          child: LargeHeaderBoxContent(
            title: title,
            leadingIcon: leadingIcon,
            secondaryLabel: secondaryLabel,
            trailingWidget: trailingWidget,
          ),
          semanticsLabel: semanticsLabel,
        );

  /// Allows complete customization of the [SBBHeaderbox].
  const SBBHeaderbox.custom({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    this.padding = const EdgeInsets.all(sbbDefaultSpacing),
    this.flap,
    this.semanticsLabel,
  });

  /// The margin around the [SBBHeaderbox].
  ///
  /// Defaults to EdgeInsets.symmetric(horizonal: 8.0).
  final EdgeInsets margin;

  final Widget child;

  /// The space around [child].
  final EdgeInsets padding;

  /// The flap to display below the [SBBHeaderbox].
  final SBBHeaderboxFlap? flap;

  /// The semantic label for the Headerbox that will be announced by screen readers.
  ///
  /// This is announced by assistive technologies (e.g TalkBack/VoiceOver).
  ///
  /// This label does not show in the UI.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _HeaderBoxBackgroundBar(),
        Padding(
          padding: margin,
          child: _HeaderBoxForeground(
            padding: padding,
            flap: flap,
            semanticsLabel: semanticsLabel,
            child: child,
          ),
        ),
      ],
    );
  }
}

class _HeaderBoxForeground extends StatelessWidget {
  const _HeaderBoxForeground({
    required this.child,
    required this.padding,
    this.semanticsLabel,
    this.flap,
  });

  final EdgeInsets padding;
  final Widget child;
  final String? semanticsLabel;
  final SBBHeaderboxFlap? flap;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        header: true,
        label: semanticsLabel,
        child: flap != null ? _flappedHeaderBox(context) : _headerBox(context),
      ),
    );
  }

  Widget _flappedHeaderBox(BuildContext context) {
    final flap = this.flap!;

    if (flap.allowFloating) {
      return Container(
        decoration: _flappedBackgroundDecoration(context),
        child: SBBStackedColumn(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: _headerBoxFlapTopMargin),
              child: _headerBox(context),
            ),
            SBBStackedItem.aligned(
              alignment: Alignment.bottomLeft,
              child: flap,
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: _flappedBackgroundDecoration(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(bottom: _headerBoxFlapTopMargin),
                child: _headerBox(context),
              ),
            ),
            flap,
          ],
        ),
      );
    }
  }

  Widget _headerBox(BuildContext context) {
    final SBBHeaderBoxStyle style = SBBHeaderBoxStyle.of(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.all(_headerBoxRadius),
        boxShadow: _headerBoxShadow,
      ),
      constraints: BoxConstraints(minHeight: _headerBoxMinHeight, minWidth: double.infinity),
      padding: padding,
      child: child,
    );
  }

  BoxDecoration _flappedBackgroundDecoration(BuildContext context) {
    final Color flapBackgroundColor = SBBHeaderBoxStyle.of(context).flapBackgroundColor!;
    return BoxDecoration(
      boxShadow: SBBInternal.defaultBoxShadow,
      borderRadius: BorderRadius.only(bottomLeft: _headerBoxRadius, bottomRight: _headerBoxRadius),
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [flapBackgroundColor, flapBackgroundColor, SBBColors.white.withAlpha(0)],
        stops: [0.0, 0.5, 1.0],
      ),
    );
  }

  List<BoxShadow> get _headerBoxShadow => [
    BoxShadow(color: SBBColors.black.withAlpha(32), blurRadius: 4.0, offset: Offset(0, 2.0)),
  ];
}

class _HeaderBoxBackgroundBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // take AppBar background color to align with e.g. SBBHeader
    final Color? headerColorPrimary = Theme.of(context).appBarTheme.backgroundColor;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: headerColorPrimary,
        height: _headerBoxNavBarExtensionHeight,
      ),
    );
  }
}
