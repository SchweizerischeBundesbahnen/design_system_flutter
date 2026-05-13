import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/header_box/utils.dart';

class HeaderBoxContent extends StatelessWidget {
  const HeaderBoxContent({
    super.key,
    this.leading,
    this.leadingIconData,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.trailing,
    this.style = const SBBHeaderBoxStyle(),
  });

  final Widget? leading;
  final IconData? leadingIconData;
  final Widget? title;
  final String? titleText;
  final Widget? subtitle;
  final String? subtitleText;
  final Widget? trailing;
  final SBBHeaderBoxStyle style;

  static const double _textPadding = 2.0;

  @override
  Widget build(BuildContext context) {
    final titleWidget = _addDefaultAncestorWithResolved(
      textStyle: style.titleTextStyle,
      foregroundColor: style.titleForegroundColor,
      child: _resolveTitle(),
    );

    final subtitleWidget = _addDefaultAncestorWithResolved(
      textStyle: style.subtitleTextStyle,
      foregroundColor: style.subtitleForegroundColor,
      child: _resolveSubtitle(),
    );

    final leadingWidget = _addDefaultAncestorWithResolved(
      textStyle: style.leadingTextStyle,
      foregroundColor: style.leadingForegroundColor,
      child: _resolveLeading(),
    );

    if (titleWidget == null) {
      return SizedBox.shrink();
    }

    Widget child = Padding(
      padding: const EdgeInsets.symmetric(vertical: _textPadding),
      child: titleWidget,
    );
    if (leadingWidget != null) {
      child = Row(
        spacing: SBBSpacing.xSmall,
        children: [
          leadingWidget,
          Expanded(child: child),
        ],
      );
    }

    if (subtitleWidget != null) {
      child = Column(
        crossAxisAlignment: .start,
        spacing: style.titleSubtitleGap ?? 0.0,
        children: [
          child,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: _textPadding),
            child: subtitleWidget,
          ),
        ],
      );
    }

    if (trailing != null) {
      child = Row(
        spacing: SBBSpacing.xSmall,
        children: [
          Expanded(child: child),
          trailing!,
        ],
      );
    }

    return child;
  }

  Widget? _resolveLeading() {
    if (leadingIconData != null) {
      return Icon(leadingIconData);
    }

    return leading;
  }

  Widget? _resolveTitle() {
    if (titleText != null) {
      return Text(
        titleText!,
        maxLines: 1,
        overflow: .ellipsis,
      );
    }

    return title;
  }

  Widget? _resolveSubtitle() {
    if (subtitleText != null) {
      return Text(subtitleText!);
    }

    return subtitle;
  }

  static double calculateHeight({
    required SBBHeaderBoxStyle style,
    PreferredSizeWidget? title,
    String? titleText,
    PreferredSizeWidget? subtitle,
    String? subtitleText,
    PreferredSizeWidget? leading,
    IconData? leadingIconData,
    TextScaler textScaler = TextScaler.noScaling,
  }) {
    if (title == null && titleText == null) {
      return 0.0;
    }

    final iconSize = IconThemeData.fallback().size!;
    final titleHeight =
        calculateHeightWithTextFallback(title, titleText, style.titleTextStyle, textScaler) + _textPadding * 2;
    final leadingHeight = leading?.preferredSize.height ?? (leadingIconData != null ? iconSize : 0.0);
    final subtitleHeight = calculateHeightWithTextFallback(subtitle, subtitleText, style.subtitleTextStyle, textScaler);

    final titleRowHeight = math.max(titleHeight, leadingHeight);

    if (subtitleHeight > 0) {
      return titleRowHeight + style.titleSubtitleGap! + subtitleHeight + _textPadding * 2;
    } else {
      return titleRowHeight;
    }
  }
}

class LargeHeaderBoxContent extends StatelessWidget {
  const LargeHeaderBoxContent({
    super.key,
    this.leading,
    this.leadingIconData,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.trailing,
    this.style = const SBBHeaderBoxStyle(),
  });

  final Widget? leading;
  final IconData? leadingIconData;
  final Widget? title;
  final String? titleText;
  final Widget? subtitle;
  final String? subtitleText;
  final Widget? trailing;
  final SBBHeaderBoxStyle style;

  @override
  Widget build(BuildContext context) {
    final titleWidget = _addDefaultAncestorWithResolved(
      textStyle: style.titleTextStyle,
      foregroundColor: style.titleForegroundColor,
      child: _resolveTitle(),
    );
    final subtitleWidget = _addDefaultAncestorWithResolved(
      textStyle: style.subtitleTextStyle,
      foregroundColor: style.subtitleForegroundColor,
      child: _resolveSubtitle(),
    );

    final leadingWidget = _addDefaultAncestorWithResolved(
      textStyle: style.leadingTextStyle,
      foregroundColor: style.leadingForegroundColor,
      child: _resolveLeading(),
    );

    if (titleWidget == null) {
      return SizedBox.shrink();
    }

    Widget child = titleWidget;
    if (subtitleWidget != null) {
      child = Column(
        crossAxisAlignment: .start,
        spacing: style.titleSubtitleGap ?? 0.0,
        children: [
          child,
          subtitleWidget,
        ],
      );
    }

    if (leadingWidget != null || trailing != null) {
      child = Row(
        spacing: SBBSpacing.xSmall,
        children: [
          ?leadingWidget,
          Expanded(child: child),
          ?trailing,
        ],
      );
    }

    return child;
  }

  Widget? _resolveLeading() {
    if (leadingIconData != null) {
      return Icon(leadingIconData, size: sbbIconSizeMedium);
    }

    return leading;
  }

  Widget? _resolveTitle() {
    if (titleText != null) {
      return Text(titleText!);
    }

    return title;
  }

  Widget? _resolveSubtitle() {
    if (subtitleText != null) {
      return Text(subtitleText!);
    }

    return subtitle;
  }
}

Widget? _addDefaultAncestorWithResolved({
  Widget? child,
  Color? foregroundColor,
  TextStyle? textStyle,
}) {
  if (child == null) {
    return null;
  }

  final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);

  child = DefaultTextStyle.merge(
    style: resolvedTextStyle,
    child: IconTheme.merge(
      data: IconThemeData(color: foregroundColor),
      child: child,
    ),
  );
  return child;
}
