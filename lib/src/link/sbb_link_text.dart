import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

typedef OnLaunchCallback = void Function(String link);

/// SBB Link. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/link>
class SBBLinkText extends StatefulWidget {
  const SBBLinkText({
    super.key,
    required this.text,
    required this.onLaunch,
    this.style,
  });

  final String text;
  final OnLaunchCallback onLaunch;
  final TextStyle? style;

  @override
  SBBLinkTextState createState() => SBBLinkTextState();
}

class SBBLinkTextState extends State<SBBLinkText> {
  static const inlineLinkPattern = r'(?:\[([^\]]+)\]\((https?:\/\/[^"\)]+)\))';
  static const angleBracketsPattern = r'(?:<(https?:\/\/[^>]+)>)';
  static const plainLinkPattern =
      r'((?:http(?:s)?:\/\/.)(?:www\.)?[-a-zA-ZäöüÄÖÜ0-9@:%._\+~#=$]{2,256}\.[a-z]{2,6}\b(?:[-a-zA-ZäöüÄÖÜ0-9@:%_\+.~#?&//=$]*))';

  final combinedPattern = RegExp(
    [
      inlineLinkPattern,
      angleBracketsPattern,
      plainLinkPattern,
    ].join(r'|'),
  );

  final _isPressedValues = [];
  final _isHoveredValues = [];

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _textSpans(),
      ),
    );
  }

  List<TextSpan> _textSpans() {
    final style = SBBBaseStyle.of(context);
    TextStyle? textStyle = _resolveTextStyle(style);

    final plainTextSections = widget.text.split(combinedPattern);
    final linkSections = combinedPattern.allMatches(widget.text).toList();
    final List<TextSpan> inlineSpans = [];
    for (
      var i = 0;
      i < math.max(plainTextSections.length, linkSections.length);
      i++
    ) {
      if (i < plainTextSections.length) {
        inlineSpans.add(
          TextSpan(
            text: plainTextSections[i],
            style: textStyle,
          ),
        );
      }
      if (i < linkSections.length) {
        final link = linkSections[i];

        // 4: plain url; 3: url in angle brackets; 2: inline-style link
        final url = link.group(4) ?? link.group(3) ?? link.group(2) ?? '';
        final text = link.group(1);

        _isPressedValues.add(false);
        _isHoveredValues.add(false);

        final tapGestureRecognizer = TapGestureRecognizer();
        tapGestureRecognizer.onTapDown =
            (TapDownDetails details) =>
                setState(() => _isPressedValues[i] = true);
        tapGestureRecognizer.onTapCancel =
            () => setState(() => _isPressedValues[i] = false);
        tapGestureRecognizer.onTap = () {
          widget.onLaunch(url);
          setState(() => _isPressedValues[i] = false);
        };
        inlineSpans.add(
          TextSpan(
            onEnter:
                (_) => setState(() {
                  _isHoveredValues[i] = true;
                }),
            onExit:
                (_) => setState(() {
                  _isHoveredValues[i] = false;
                }),
            text: text ?? url,
            style: _linkTextStyle(
              _isPressedValues[i] == true,
              _isHoveredValues[i] == true,
            ),
            recognizer: tapGestureRecognizer,
          ),
        );
      }
    }
    return inlineSpans;
  }

  TextStyle? _resolveTextStyle(SBBBaseStyle style) {
    final hasCustomStyle = widget.style != null;
    final textStyle =
        hasCustomStyle
            ? widget.style!.copyWith(
              color: widget.style!.color ?? style.defaultTextStyle!.color,
            )
            : style.defaultTextStyle;
    return textStyle;
  }

  TextStyle _linkTextStyle(bool isPressed, bool isHovered) {
    final style = SBBBaseStyle.of(context);
    final controlStyle = SBBControlStyles.of(context);
    final hasCustomStyle = widget.style != null;
    final textStyle =
        hasCustomStyle
            ? widget.style!.copyWith(
              color: widget.style!.color ?? style.defaultTextStyle!.color,
            )
            : style.defaultTextStyle;
    final linkStyle =
        hasCustomStyle
            ? textStyle!.copyWith(color: controlStyle.linkTextStyle!.color)
            : controlStyle.linkTextStyle;
    final linkStylePressed =
        hasCustomStyle
            ? textStyle!.copyWith(
              color: controlStyle.linkTextStyleHighlighted!.color,
            )
            : controlStyle.linkTextStyleHighlighted;

    return (isPressed ? linkStylePressed : linkStyle)!;
  }
}
