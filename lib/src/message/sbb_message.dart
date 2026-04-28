import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The SBB Message widget displays messages to the user, typically for errors, loading states, or informational content.
///
/// This widget combines visual elements (illustration, title, subtitle, error text) with optional actions
/// to create a complete message experience. It supports both static and custom content through either
/// text strings or widgets.
///
/// Provide either [titleText] for simple text or [title] for custom content. These parameters are mutually exclusive.
/// Similarly, [subtitleText] and [subtitle], as well as [errorText] and [error], are mutually exclusive.
///
/// For the [illustration] field, typically use a [SBBIllustration] factory constructor to display
/// a predefined illustration. For example:
/// ```dart
/// SBBMessage(
///   titleText: 'Operation failed',
///   illustration: SBBIllustration.display(),
/// )
/// ```
///
/// For the [action] field, typically add a [SBBTertiaryButton] with only [iconData] set to perform
/// a related action. For example:
/// ```dart
/// SBBMessage(
///   titleText: 'Error occurred',
///   action: SBBTertiaryButton(
///     onPressed: () => handleRetry(),
///     iconData: SBBIcons.arrows_small,
///   ),
/// )
/// ```
///
/// If [isLoading] is true, a [SBBLoadingIndicator] is shown instead of the [illustration].
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
/// * [SBBIllustration], for predefined illustration assets to use with the [illustration] field.
/// * [SBBTertiaryButton], for action buttons to use with the [action] field.
/// * [SBBLoadingIndicator], shown when [isLoading] is true.
/// * [digital.sbb.ch](https://digital.sbb.ch/de/design-system/mobile/components/message/)
class SBBMessage extends StatelessWidget {
  /// Creates an SBB Message.
  ///
  /// The following arguments are required:
  ///
  /// * Either [title] or [titleText] must be provided. They are mutually exclusive.
  ///
  /// The following arguments are mutually exclusive:
  ///
  /// * [title] and [titleText]
  /// * [subtitle] and [subtitleText]
  /// * [error] and [errorText]
  const SBBMessage({
    super.key,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.error,
    this.errorText,
    this.isLoading = false,
    this.illustration,
    this.action,
    this.style,
  }) : assert(title != null || titleText != null, 'One of title or titleText must be set!'),
       assert(title == null || titleText == null, 'Only titleText or title can be set!'),
       assert(subtitle == null || subtitleText == null, 'Only subtitleText or subtitle can be set!'),
       assert(error == null || errorText == null, 'Only error or errorText can be set!');

  /// A custom widget displayed as the message's title.
  ///
  /// For simple text titles, prefer [titleText].
  ///
  /// Cannot be used together with [titleText].
  final Widget? title;

  /// Text string to display as the message's title using the standard design.
  ///
  /// This text is displayed directly below the [illustration] or loading indicator.
  /// The title should be concise and clearly indicate the message's purpose.
  ///
  /// Cannot be used together with [title].
  final String? titleText;

  /// A custom widget displayed as the message's subtitle or body.
  ///
  /// For simple text subtitles, prefer [subtitleText].
  ///
  /// Cannot be used together with [subtitleText].
  final Widget? subtitle;

  /// Text string to display as the message's body using the standard design.
  ///
  /// This text provides a longer explanation of what has happened or what action
  /// the user should take. It appears below the [titleText] or [title].
  ///
  /// Cannot be used together with [subtitle].
  final String? subtitleText;

  /// A custom widget displayed below the subtitle for error information.
  ///
  /// For simple error text, prefer [errorText].
  ///
  /// Cannot be used together with [errorText].
  final Widget? error;

  /// Text string to display as error information using the standard design.
  ///
  /// This text is typically used only within error messages to show additional
  /// details like error codes. The text is excluded from semantics.
  ///
  /// Example: 'Error-Code: XYZ-9999'
  ///
  /// Cannot be used together with [error].
  final String? errorText;

  /// Whether to show a loading indicator instead of the [illustration].
  ///
  /// When true, a [SBBLoadingIndicator] is displayed in place of the [illustration].
  /// The button and text remain visible and functional.
  ///
  /// Defaults to false.
  final bool isLoading;

  /// A widget to display above the title, typically used for visual content.
  ///
  /// Usually populated with a [SBBIllustration] factory constructor for predefined
  /// illustrations. If null and [isLoading] is false, no illustration is displayed.
  ///
  /// This field is overridden by [isLoading] to show a [SBBLoadingIndicator].
  ///
  /// Example:
  /// ```dart
  /// illustration: SBBIllustration.staffMale()
  /// ```
  final Widget? illustration;

  /// An optional widget displayed below all text content, typically an action button.
  ///
  /// Usually populated with a [SBBTertiaryButton] for tertiary actions or navigation.
  /// Only the icon should be displayed when using the compact form.
  ///
  /// Example:
  /// ```dart
  /// action: SBBTertiaryButton(
  ///   onPressed: () => handleAction(),
  ///   iconData: SBBIcons.arrows_small,
  /// )
  /// ```
  final Widget? action;

  /// Customizes this message's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBMessageThemeData.style].
  final SBBMessageStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).sbbMessageTheme;
    final effectiveStyle = _getEffectiveStyle(themeData);

    Widget? resolvedIllustration;
    if (illustration != null || isLoading) {
      final Widget illustrationChild;
      if (isLoading) {
        illustrationChild = SBBLoadingIndicator.medium();
      } else {
        illustrationChild = illustration!;
      }
      resolvedIllustration = Padding(
        padding: EdgeInsets.only(bottom: effectiveStyle.illustrationTitleGap),
        child: AnimatedSwitcher(
          duration: Durations.medium1,
          child: illustrationChild,
        ),
      );
    }

    Widget resolvedTitle = title ?? Text(titleText!, textAlign: .center);
    resolvedTitle = _addDefaultAncestorWithResolved(
      textStyle: effectiveStyle.titleTextStyle?.copyWith(color: effectiveStyle.titleForegroundColor),
      child: resolvedTitle,
    )!;

    Widget? resolvedSubtitle = subtitle ?? (subtitleText != null ? Text(subtitleText!, textAlign: .center) : null);
    resolvedSubtitle = _addDefaultAncestorWithResolved(
      textStyle: effectiveStyle.subtitleTextStyle?.copyWith(color: effectiveStyle.subtitleForegroundColor),
      child: resolvedSubtitle,
    );

    Widget? resolvedError = error ?? (errorText != null ? Text(errorText!, textAlign: .center) : null);
    resolvedError = _addDefaultAncestorWithResolved(
      textStyle: effectiveStyle.errorTextStyle?.copyWith(color: effectiveStyle.errorForegroundColor),
      child: resolvedError,
    );

    final child = _buildSingleChildOrColumn(
      resolvedIllustration,
      resolvedTitle,
      resolvedSubtitle,
      resolvedError,
      effectiveStyle.textGap,
      effectiveStyle.textActionGap,
    );

    return Padding(
      padding: effectiveStyle.padding ?? SBBMessageStyle.defaultPadding,
      child: child,
    );
  }

  SBBMessageStyle _getEffectiveStyle(SBBMessageThemeData? themeData) {
    final themeStyle = themeData?.style;
    return style?.merge(themeStyle) ?? themeStyle ?? const SBBMessageStyle();
  }

  Widget? _addDefaultAncestorWithResolved({
    required TextStyle? textStyle,
    required Widget? child,
  }) {
    if (child == null) return null;
    return DefaultTextStyle.merge(
      style: textStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: textStyle?.color),
        child: child,
      ),
    );
  }

  Widget _buildSingleChildOrColumn(
    Widget? resolvedIllustration,
    Widget resolvedTitle,
    Widget? resolvedSubtitle,
    Widget? resolvedError,
    double textGap,
    double textActionGap,
  ) {
    final textChildren = [
      resolvedTitle,
      resolvedSubtitle,
      resolvedError,
    ].nonNulls.intersperseWith(SizedBox(height: textGap));

    final children = [
      resolvedIllustration,
      ...textChildren,
      if (action != null) SizedBox(height: textActionGap),
      action,
    ].nonNulls.toList(growable: false);

    return children.length < 2 ? children.first : Column(mainAxisSize: .min, children: children);
  }
}

extension _IntersperseOnIterableX on Iterable<Widget> {
  Iterable<Widget> intersperseWith(Widget widget) {
    return map((e) => [widget, e]).expand((e) => e).skip(1);
  }
}
