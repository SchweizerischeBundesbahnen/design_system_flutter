import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Message. This widget allows displaying messages to the user, e.g. for Error messages.
///
///
/// See also:
///
/// * <https://digital.sbb.ch/en/design-system/mobile/components/message/>
class SBBMessage extends StatelessWidget {
  /// Use the required [titleText] and [subtitleText] to display a message to the user.
  ///
  /// If [illustration] and [illustration] is null, will not display anything above the [titleText], unless
  /// [isLoading] is true.
  ///
  /// The [errorText] is typically used only within an error message. See [SBBMessage.error].
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

  final Widget? title;

  /// The title of the message displayed directly below the [illustration] or [illustration].
  final String? titleText;

  final Widget? subtitle;

  /// The body of the message. Used to give a longer explanation of what has happened.
  final String? subtitleText;

  final Widget? error;

  /// Optional text displayed below the [subtitleText]. Usually depicts an error code.
  ///
  /// This text is excluded from semantics.
  ///
  /// Example: 'Error-Code: XYZ-9999'
  final String? errorText;

  /// If [isLoading] is true, a [SBBLoadingIndicator] is shown instead of the [illustration] or [illustration].
  ///
  /// Defaults to false.
  final bool isLoading;

  /// Used to display a complete custom illustration instead of [illustration].
  ///
  /// If is null and [illustration] is non null, displays [illustration].
  ///
  /// Overridden by [isLoading] to show a [SBBLoadingIndicator].
  final Widget? illustration;

  final Widget? action;

  /// Customizes this message's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBMessageThemeData.style].
  final SBBMessageStyle? style;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final themeData = Theme.of(context).sbbMessageTheme;
    final effectiveStyle = _getEffectiveStyle(themeData);

    Widget? resolvedIllustration;
    if (illustration != null || isLoading) {
      final Widget illustrationChild;
      if (isLoading) {
        final loadingIndicatorColor = isDark ? SBBColors.redDark : SBBColors.red;
        illustrationChild = SBBLoadingIndicator.medium(color: loadingIndicatorColor);
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

    Widget resolvedTitle = title ?? Text(titleText!);
    resolvedTitle = _addDefaultAncestorWithResolved(
      textStyle: effectiveStyle.titleTextStyle?.copyWith(color: effectiveStyle.titleForegroundColor),
      child: resolvedTitle,
    )!;

    Widget? resolvedSubtitle = subtitle ?? (subtitleText != null ? Text(subtitleText!) : null);
    resolvedSubtitle = _addDefaultAncestorWithResolved(
      textStyle: effectiveStyle.subtitleTextStyle?.copyWith(color: effectiveStyle.subtitleForegroundColor),
      child: resolvedSubtitle,
    );

    Widget? resolvedError = error ?? (errorText != null ? Text(errorText!) : null);
    resolvedError = _addDefaultAncestorWithResolved(
      textStyle: effectiveStyle.errorTextStyle?.copyWith(color: effectiveStyle.errorForegroundColor),
      child: resolvedError,
    );

    Widget child = _buildSingleChildOrColumn(
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

    final child = children.length < 2 ? children.first : Column(mainAxisSize: .min, children: children);
    return child;
  }
}

extension _IntersperseOnIterable on Iterable<Widget> {
  Iterable<Widget> intersperseWith(Widget widget) {
    return map((e) => [widget, e]).expand((e) => e).skip(1);
  }
}
