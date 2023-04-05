import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

typedef TextStyleWidgetBuilder = Widget Function(
  BuildContext context,
  TextStyle? textStyle,
);

enum SelectedButtonColorType { white, red }

/// SBB Segmented Button. Use according to documentation.
///
/// See also:
///
/// * [SBBRadioButtonListItem] and [SBBRadioButton], a widget with semantics
/// similar to [SBBSegmentedButton].
/// * [SBBSlider], for selecting a value in a range.
/// * [SBBCheckboxListItem], [SBBCheckbox] and [SBBSwitch], for toggling a
/// particular value on or off.
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/radiobutton>
class SBBSegmentedButton extends StatefulWidget {
  SBBSegmentedButton({
    Key? key,
    required List<String> values,
    required int selectedStateIndex,
    required ValueChanged<int> selectedIndexChanged,
  }) : this.textCustom(
          key: key,
          values: values,
          selectedStateIndex: selectedStateIndex,
          selectedIndexChanged: selectedIndexChanged,
          colorType: SelectedButtonColorType.white,
        );

  SBBSegmentedButton.text({
    Key? key,
    required List<String> values,
    required int selectedStateIndex,
    required ValueChanged<int> selectedIndexChanged,
  }) : this.textCustom(
          key: key,
          values: values,
          selectedStateIndex: selectedStateIndex,
          selectedIndexChanged: selectedIndexChanged,
          colorType: SelectedButtonColorType.white,
        );

  SBBSegmentedButton.icon({
    Key? key,
    required Map<IconData, String> icons,
    required int selectedStateIndex,
    required ValueChanged<int> selectedIndexChanged,
    bool withText = false,
  }) : this.iconCustom(
          key: key,
          icons: icons,
          selectedStateIndex: selectedStateIndex,
          selectedIndexChanged: selectedIndexChanged,
          withText: withText,
          colorType: SelectedButtonColorType.white,
        );

  SBBSegmentedButton.redText({
    Key? key,
    required List<String> values,
    required int selectedStateIndex,
    required ValueChanged<int> selectedIndexChanged,
  }) : this.textCustom(
          key: key,
          values: values,
          selectedStateIndex: selectedStateIndex,
          backgroundColor: const Color(0xFFD30000),
          selectedColor: SBBColors.red,
          selectedBorderColor: SBBColors.red150,
          borderColor: SBBColors.transparent,
          boxShadow: SBBInternal.defaultRedBoxShadow,
          selectedIndexChanged: selectedIndexChanged,
          colorType: SelectedButtonColorType.red,
        );

  SBBSegmentedButton.redIcon({
    Key? key,
    required Map<IconData, String> icons,
    required int selectedStateIndex,
    required ValueChanged<int> selectedIndexChanged,
    bool withText = false,
  }) : this.iconCustom(
          key: key,
          icons: icons,
          selectedStateIndex: selectedStateIndex,
          withText: withText,
          backgroundColor: const Color(0xFFD30000),
          selectedColor: SBBColors.red,
          selectedBorderColor: SBBColors.red150,
          iconColor: SBBColors.white,
          borderColor: SBBColors.transparent,
          boxShadow: SBBInternal.defaultRedBoxShadow,
          selectedIndexChanged: selectedIndexChanged,
          colorType: SelectedButtonColorType.red,
        );

  SBBSegmentedButton.textCustom({
    Key? key,
    required List<String> values,
    required int selectedStateIndex,
    Color? backgroundColor,
    Color? selectedColor,
    Color? selectedBorderColor,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
    required ValueChanged<int> selectedIndexChanged,
    required SelectedButtonColorType colorType,
  }) : this.custom(
          key: key,
          widgetBuilders: values
              .mapIndexed(
                (i, value) => (BuildContext context, textStyle) => Text(
                      value,
                      maxLines: 1,
                      style: textStyle,
                    ),
              )
              .toList(),
          selectedStateIndex: selectedStateIndex,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          selectedBorderColor: selectedBorderColor,
          borderColor: borderColor,
          boxShadow: boxShadow,
          selectedIndexChanged: selectedIndexChanged,
          colorType: colorType,
        );

  SBBSegmentedButton.iconCustom({
    Key? key,
    required Map<IconData, String> icons,
    required int selectedStateIndex,
    bool withText = false,
    Color? backgroundColor,
    Color? selectedColor,
    Color? selectedBorderColor,
    Color? iconColor,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
    required ValueChanged<int> selectedIndexChanged,
    required SelectedButtonColorType colorType,
  }) : this.custom(
          key: key,
          widgetBuilders: icons.entries
              .map((icon) => (BuildContext context, textStyle) => Semantics(
                    label: icon.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon.key, color: iconColor),
                        if (withText) ...[
                          const SizedBox(width: 4.0),
                          ExcludeSemantics(
                            child: Text(
                              icon.value,
                              style: textStyle,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ))
              .toList(),
          selectedStateIndex: selectedStateIndex,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          selectedBorderColor: selectedBorderColor,
          borderColor: borderColor,
          boxShadow: boxShadow,
          selectedIndexChanged: selectedIndexChanged,
          colorType: colorType,
        );

  const SBBSegmentedButton.custom({
    Key? key,
    required this.widgetBuilders,
    required this.selectedStateIndex,
    this.backgroundColor,
    this.selectedColor,
    this.selectedBorderColor,
    this.borderColor,
    this.boxShadow,
    required this.selectedIndexChanged,
    required this.colorType,
  })  : assert(widgetBuilders.length > 1),
        super(key: key);

  final List<TextStyleWidgetBuilder> widgetBuilders;
  final int selectedStateIndex;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? selectedBorderColor;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final ValueChanged<int> selectedIndexChanged;
  final SelectedButtonColorType colorType;

  @override
  _SegmentedButton createState() => _SegmentedButton();
}

class _SegmentedButton extends State<SBBSegmentedButton> {
  static const _borderRadius = const BorderRadius.all(Radius.circular(22));

  SBBSegmentedButtonStyle? get style =>
      SBBControlStyles.of(context).segmentedButton;

  bool get isRed => widget.colorType == SelectedButtonColorType.red;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SBBInternal.defaultButtonHeight,
      child: Stack(
        children: [
          _buildBackgroundLayer(),
          _buildIndicatorLayer(),
          _buildForegroundLayer(),
        ],
      ),
    );
  }

  Widget _buildBackgroundLayer() {
    final List<Widget> children = [];
    for (var i = 0; i < widget.widgetBuilders.length; i++) {
      children.add(
        Expanded(
          child: Material(
            color: SBBColors.transparent,
            child: InkWell(
              customBorder: const RoundedRectangleBorder(
                borderRadius: _borderRadius,
              ),
              onTap: i != widget.selectedStateIndex
                  ? () => widget.selectedIndexChanged(i)
                  : null,
            ),
          ),
        ),
      );
    }
    return ExcludeSemantics(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? style?.backgroundColor,
              border: Border.all(
                color: (widget.borderColor ?? style?.borderColor)!,
              ),
              borderRadius: _borderRadius,
            ),
          ),
          Row(children: children),
        ],
      ),
    );
  }

  Widget _buildIndicatorLayer() {
    return ExcludeSemantics(
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Row(
            children: <Widget>[
              AnimatedContainer(
                duration: kThemeAnimationDuration,
                curve: Curves.easeInOut,
                width: constraints.maxWidth /
                    widget.widgetBuilders.length *
                    widget.selectedStateIndex,
              ),
              Container(
                width: constraints.maxWidth / widget.widgetBuilders.length,
                decoration: BoxDecoration(
                  borderRadius: _borderRadius,
                  boxShadow: widget.boxShadow ?? style?.boxShadow,
                  border: Border.all(
                    color: (widget.selectedBorderColor ??
                        style?.selectedBorderColor)!,
                  ),
                ),
                child: Material(
                  borderRadius: _borderRadius,
                  color: widget.selectedColor ?? style?.selectedColor,
                  child: InkWell(
                    borderRadius: _borderRadius,
                    onTap: () {
                      widget.selectedIndexChanged(widget.selectedStateIndex);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildForegroundLayer() {
    final loc = Localizations.of(context, MaterialLocalizations);
    return IgnorePointer(
      ignoringSemantics: false,
      child: Row(
        children: widget.widgetBuilders.mapIndexed((i, element) {
          final selected = i == widget.selectedStateIndex;
          final textStyle = style?.getTextStyle(selected, isRed);
          return Expanded(
            child: Semantics(
              focusable: true,
              selected: selected,
              button: !selected,
              hint: loc.tabLabel(
                tabIndex: i + 1,
                tabCount: widget.widgetBuilders.length,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                child: element(context, textStyle),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
