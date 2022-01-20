import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _textSpans(),
      ),
    );
  }

  List<TextSpan> _textSpans() {
    final sbbTheme = SBBTheme.of(context);
    final hasCustomStyle = widget.style != null;
    final textStyle = hasCustomStyle ? widget.style!.copyWith(color: widget.style!.color ?? sbbTheme.defaultTextStyle.color) : sbbTheme.defaultTextStyle;
    final linkStyle = hasCustomStyle ? textStyle.copyWith(color: sbbTheme.linkTextStyle.color) : sbbTheme.linkTextStyle;
    final linkStylePressed = hasCustomStyle ? textStyle.copyWith(color: sbbTheme.linkTextStyleHighlighted.color) : sbbTheme.linkTextStyleHighlighted;

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

        final tapGestureRecognizer = TapGestureRecognizer();
        tapGestureRecognizer.onTapDown = (TapDownDetails details) => setState(() => _isPressedValues[i] = true);
        tapGestureRecognizer.onTapCancel = () => setState(() => _isPressedValues[i] = false);
        tapGestureRecognizer.onTap = () {
          widget.onLaunch(url);
          setState(() => _isPressedValues[i] = false);
        };
        _inlineSpans.add(
          TextSpan(
            text: text ?? url,
            style: _isPressedValues[i] ? linkStylePressed : linkStyle,
            recognizer: tapGestureRecognizer,
          ),
        );
      }
    }
    return _inlineSpans;
  }
}
