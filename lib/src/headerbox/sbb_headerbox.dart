import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

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
/// See [SBBSliverHeaderbox] for a headerbox that behaves as expected in scrollable content.
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
          child: _DefaultHeaderBoxContent(
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
          child: _LargeHeaderBoxContent(
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
  final Widget? flap;

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
    return Container(
      decoration: _flappedBackgroundDecoration(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: _headerBoxFlapTopMargin),
            child: _headerBox(context),
          ),
          flap!,
        ],
      ),
    );
  }

  Widget _headerBox(BuildContext context) {
    final SBBHeaderBoxStyle style = SBBHeaderBoxStyle.of(context);
    return Container(
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

class _DefaultHeaderBoxContent extends StatelessWidget {
  const _DefaultHeaderBoxContent({
    required this.title,
    this.leadingIcon,
    this.secondaryLabel,
    this.trailingWidget,
  });

  final String title;
  final IconData? leadingIcon;
  final String? secondaryLabel;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    final style = SBBHeaderBoxStyle.of(context);
    final secondaryTextStyle = SBBTextStyles.smallLight.copyWith(color: style.secondaryLabelColor);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (leadingIcon != null) ...[
                    Icon(leadingIcon, size: sbbIconSizeSmall),
                    SizedBox(width: sbbDefaultSpacing * .5),
                  ],
                  Expanded(child: Text(title, style: style.titleTextStyle)),
                ],
              ),
              if (secondaryLabel != null) Text(secondaryLabel!, style: secondaryTextStyle),
            ],
          ),
        ),
        SizedBox(width: sbbDefaultSpacing * .5),
        if (trailingWidget != null) trailingWidget!,
      ],
    );
  }
}

class _LargeHeaderBoxContent extends StatelessWidget {
  const _LargeHeaderBoxContent({
    required this.title,
    this.leadingIcon,
    this.secondaryLabel,
    this.trailingWidget,
  });

  final String title;
  final IconData? leadingIcon;
  final String? secondaryLabel;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    final style = SBBHeaderBoxStyle.of(context);
    final secondaryTextStyle = SBBTextStyles.mediumLight.copyWith(color: style.largeSecondaryLabelColor);

    return Row(
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: sbbIconSizeMedium),
          SizedBox(width: sbbDefaultSpacing * .5),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: style.titleTextStyle),
              SizedBox(height: sbbDefaultSpacing * .25),
              if (secondaryLabel != null) Text(secondaryLabel!, style: secondaryTextStyle),
            ],
          ),
        ),
        SizedBox(width: sbbDefaultSpacing * .5),
        if (trailingWidget != null) trailingWidget!,
      ],
    );
  }
}
