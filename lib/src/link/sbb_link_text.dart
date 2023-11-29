import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

typedef OnLaunchCallback = void Function(String link);

/// SBB Link. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/link>
class SBBLinkText extends StatefulWidget {
  const SBBLinkText({
    Key? key,
    required this.text,
    required this.onLaunch,
    this.style,
  }) : super(key: key);

  final String text;
  final OnLaunchCallback onLaunch;
  final TextStyle? style;

  @override
  _SBBLinkTextState createState() => _SBBLinkTextState();
}

class _SBBLinkTextState extends State<SBBLinkText> {
  // TODO support for link title needed?
  // Regex for inline-style link with text and title: (?:\[([^\]]+)\]\((https?:\/\/[^"\)]+) "(.+?)"\))
  final RegExp _regExpMarkDownLink = RegExp(
      r'(?:\[([^\]]+)\]\((https?:\/\/[^"\)]+)\))|(?:<(https?:\/\/[^>]+)>)|((?:http(?:s)?:\/\/.)(?:www\.)?[-a-zA-ZäöüÄÖÜ0-9@:%._\+~#=$]{2,256}\.[a-z]{2,6}\b(?:[-a-zA-ZäöüÄÖÜ0-9@:%_\+.~#?&//=$]*))');

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
    bool isWeb = SBBBaseStyle.of(context).hostPlatform == HostPlatform.web;
    final hasCustomStyle = widget.style != null;
    final textStyle = hasCustomStyle ? widget.style!.copyWith(color: widget.style!.color ?? style.defaultTextStyle!.color) : style.defaultTextStyle;

    final texts = widget.text.split(_regExpMarkDownLink);
    final links = _regExpMarkDownLink.allMatches(widget.text).toList();
    final List<TextSpan> _inlineSpans = [];
    for (var i = 0; i < math.max(texts.length, links.length); i++) {
      if (i < texts.length) {
        _inlineSpans.add(
          TextSpan(
            text: texts[i],
            style: textStyle,
          ),
        );
      }
      if (i < links.length) {
        final link = links[i];

        // 4: plain url; 3: url in angle brackets; 2: inline-style link
        final url = link.group(4) ?? link.group(3) ?? link.group(2) ?? '';
        final text = link.group(1);

        _isPressedValues.add(false);
        _isHoveredValues.add(false);

        final tapGestureRecognizer = TapGestureRecognizer();
        tapGestureRecognizer.onTapDown = (TapDownDetails details) => setState(() => _isPressedValues[i] = true);
        tapGestureRecognizer.onTapCancel = () => setState(() => _isPressedValues[i] = false);
        tapGestureRecognizer.onTap = () {
          widget.onLaunch(url);
          setState(() => _isPressedValues[i] = false);
        };
        _inlineSpans.add(
          TextSpan(
            onEnter: (_) => setState(() {
              _isHoveredValues[i] = true;
            }),
            onExit: (_) => setState(() {
              _isHoveredValues[i] = false;
            }),
            text: text ?? url,
            style: _linkTextStyle(isWeb, _isPressedValues[i] == true, _isHoveredValues[i] == true),
            recognizer: tapGestureRecognizer,
          ),
        );
      }
    }
    return _inlineSpans;
  }

  TextStyle _linkTextStyle(bool isWeb, bool isPressed, bool isHovered) {
    final style = SBBBaseStyle.of(context);
    final controlStyle = SBBControlStyles.of(context);
    final hasCustomStyle = widget.style != null;
    final textStyle = hasCustomStyle ? widget.style!.copyWith(color: widget.style!.color ?? style.defaultTextStyle!.color) : style.defaultTextStyle;
    final linkStyle = hasCustomStyle ? textStyle!.copyWith(color: controlStyle.linkTextStyle!.color) :
      isWeb ? controlStyle.linkTextStyle!.copyWith(color: SBBColors.black, decoration: TextDecoration.underline) : controlStyle.linkTextStyle;
    final linkStylePressed = hasCustomStyle ? textStyle!.copyWith(color: controlStyle.linkTextStyleHighlighted!.color) :
      isWeb ? controlStyle.linkTextStyleHighlighted!.copyWith(color: SBBColors.red125, decoration: TextDecoration.underline) : controlStyle.linkTextStyleHighlighted;

    if(isWeb) {
      return (isPressed ? linkStylePressed : isHovered ? linkStylePressed : linkStyle)!;
    }
    return (isPressed ? linkStylePressed : linkStyle)!;
  }
}
