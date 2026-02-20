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
  });

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final themeData = Theme.of(context).sbbMessageTheme;
    final style = themeData?.style;

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
        padding: EdgeInsets.only(bottom: style?.illustrationTitleGap ?? SBBSpacing.large),
        child: AnimatedSwitcher(
          duration: Durations.medium1,
          child: illustrationChild,
        ),
      );
    }

    Widget resolvedTitle =
        title ??
        DefaultTextStyle.merge(
          style: style?.titleTextStyle?.copyWith(color: style.titleForegroundColor),
          child: Text(titleText!),
        );

    Widget? resolvedSubtitle =
        subtitle ??
        (subtitleText != null
            ? DefaultTextStyle.merge(
                style: style?.subtitleTextStyle?.copyWith(color: style.subtitleForegroundColor),
                child: Text(subtitleText!),
              )
            : null);

    Widget? resolvedError =
        error ??
        (errorText != null
            ? Semantics(
                enabled: false,
                child: DefaultTextStyle.merge(
                  style: style?.errorTextStyle?.copyWith(color: style.errorForegroundColor),
                  child: Text(errorText!),
                ),
              )
            : null);

    Widget child = _buildSingleChildOrColumn(
      resolvedIllustration,
      resolvedTitle,
      resolvedSubtitle,
      resolvedError,
      style?.textGap ?? SBBSpacing.medium,
      style?.textActionGap ?? SBBSpacing.large,
    );

    return Padding(
      padding: themeData?.padding ?? SBBMessageStyle.defaultPadding,
      child: child,
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
