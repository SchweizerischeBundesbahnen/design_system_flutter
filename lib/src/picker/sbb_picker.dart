import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../design_system_flutter.dart';

part 'sbb_date_time_picker.dart';

part 'sbb_picker_scroll_view.dart';

part 'sbb_time_range_picker.dart';

const _highlightedAreaHeight = 34.0;

class SBBPicker extends StatelessWidget {
  SBBPicker({
    Key? key,
    String? label,
    int initialSelectedIndex = 0,
    required ValueChanged<int>? onSelectedItemChanged,
    required SBBPickerScrollViewItemBuilder itemBuilder,
    bool looping = true,
    bool isLastElement = false,
  }) : this.custom(
          key: key,
          label: label,
          child: SBBPickerScrollView(
            controller: SBBPickerScrollController(
              initialItem: initialSelectedIndex,
            ),
            onSelectedItemChanged: onSelectedItemChanged,
            itemBuilder: itemBuilder,
            looping: looping,
          ),
          isLastElement: isLastElement,
        );

  const SBBPicker.custom({
    super.key,
    this.label,
    required this.child,
    this.isLastElement = true,
  });

  // TODO to be removed?
  final String? label;
  final Widget child;
  final bool isLastElement;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label!,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: SBBTextStyles.helpersLabel,
                  ),
                ),
              ],
            ),
          ),
        Container(
          height: 224,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: _buildHighlightedArea(),
              ),
              Center(
                child: ShaderMask(
                  shaderCallback: _shaderCallback,
                  child: Container(
                    height: _scrollAreaHeight,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (label != null && !isLastElement)
          SizedBox(
            height: sbbDefaultSpacing * 0.5,
          ),
        if (!isLastElement) Divider(),
      ],
    );
  }

  Widget _buildHighlightedArea() {
    return Container(
      height: _highlightedAreaHeight,
      margin: EdgeInsets.symmetric(
        horizontal: sbbDefaultSpacing * 0.5,
      ),
      decoration: BoxDecoration(
        color: SBBColors.cloud,
        borderRadius: BorderRadius.all(
          Radius.circular(
            sbbDefaultSpacing * 0.5,
          ),
        ),
      ),
    );
  }

  Shader _shaderCallback(bounds) {
    const topFadeOutStartStop = 3.0 / _scrollAreaHeight;
    final topFadeOutEndStop = _visibleItemHeights[0] / _scrollAreaHeight;
    const highlightedAreaStartStop =
        (_scrollAreaHeight - _highlightedAreaHeight) * 0.5 / _scrollAreaHeight;
    const highlightedAreaEndStop = 1.0 - highlightedAreaStartStop;
    final bottomFadeOutStartStop = 1.0 - topFadeOutEndStop;
    const bottomFadeOutEndStop = 1.0 - topFadeOutStartStop;

    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        topFadeOutStartStop,
        topFadeOutEndStop,
        highlightedAreaStartStop,
        highlightedAreaStartStop,
        highlightedAreaEndStop,
        highlightedAreaEndStop,
        bottomFadeOutStartStop,
        bottomFadeOutEndStop,
      ],
      colors: [
        SBBColors.white.withOpacity(0.0),
        SBBColors.white,
        SBBColors.white,
        SBBColors.black,
        SBBColors.black,
        SBBColors.white,
        SBBColors.white,
        SBBColors.white.withOpacity(0.0),
      ],
    ).createShader(
      bounds,
    );
  }
}
