import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

part 'sbb_segmented_button.typedefs.dart';

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
  }) : this.text(
          key: key,
          values: values,
          selectedStateIndex: selectedStateIndex,
          selectedIndexChanged: selectedIndexChanged,
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
        );

  SBBSegmentedButton.redText({
    Key? key,
    required List<String> values,
    required int selectedStateIndex,
    required ValueChanged<int> selectedIndexChanged,
  }) : this.textCustom(
          key: key,
          values: values,
          styleSelector: (style) => style.redSegmentedButton,
          selectedStateIndex: selectedStateIndex,
          selectedIndexChanged: selectedIndexChanged,
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
          styleSelector: (style) => style.redSegmentedButton,
          selectedStateIndex: selectedStateIndex,
          withText: withText,
          selectedIndexChanged: selectedIndexChanged,
        );

  SBBSegmentedButton.textCustom({
    Key? key,
    required List<String> values,
    required int selectedStateIndex,
    required ValueChanged<int> selectedIndexChanged,
    SBBControlStyleSelector<SBBSegmentedButtonStyle>? styleSelector,
  }) : this.custom(
          key: key,
          widgetBuilders: values.mapIndexed((i, value) {
            return (SBBSegmentedButtonStyle? style, bool selected) {
              return Text(
                value,
                maxLines: 1,
                style: style.getTextStyle(selected),
              );
            };
          }).toList(),
          styleSelector: styleSelector,
          selectedStateIndex: selectedStateIndex,
          selectedIndexChanged: selectedIndexChanged,
        );

  SBBSegmentedButton.iconCustom({
    Key? key,
    required Map<IconData, String> icons,
    required int selectedStateIndex,
    required ValueChanged<int> selectedIndexChanged,
    bool withText = false,
    SBBControlStyleSelector<SBBSegmentedButtonStyle>? styleSelector,
  }) : this.custom(
          key: key,
          widgetBuilders: icons.entries.map((icon) {
            return (SBBSegmentedButtonStyle? style, bool selected) {
              return Semantics(
                label: icon.value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon.key, color: style?.iconColor),
                    if (withText) ...[
                      const SizedBox(width: 4.0),
                      ExcludeSemantics(
                        child: Text(
                          icon.value,
                          style: style.getTextStyle(selected),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            };
          }).toList(),
          styleSelector: styleSelector,
          selectedStateIndex: selectedStateIndex,
          selectedIndexChanged: selectedIndexChanged,
        );

  const SBBSegmentedButton.custom({
    Key? key,
    required this.widgetBuilders,
    required this.selectedStateIndex,
    required this.selectedIndexChanged,
    this.styleSelector,
  })  : assert(widgetBuilders.length > 1),
        super(key: key);

  final List<SegmentedButtonWidgetBuilder> widgetBuilders;
  final int selectedStateIndex;
  final SBBControlStyleSelector<SBBSegmentedButtonStyle>? styleSelector;
  final ValueChanged<int> selectedIndexChanged;

  @override
  _SegmentedButton createState() => _SegmentedButton();
}

class _SegmentedButton extends State<SBBSegmentedButton> {
  static const _borderRadius = const BorderRadius.all(Radius.circular(22));

  late SBBSegmentedButtonStyle? style;

  Color get borderColor =>
      style?.defaultStyle?.borderColor ?? SBBColors.transparent;

  Color get selectedBorderColor =>
      style?.selectedStyle?.borderColor ?? SBBColors.transparent;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final styles = SBBControlStyles.of(context);
    style = widget.styleSelector?.call(styles) ?? styles.segmentedButton;
  }

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
              color: style?.defaultStyle?.backgroundColor,
              border: Border.all(color: borderColor),
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
                  boxShadow: style?.boxShadow,
                  border: Border.all(color: selectedBorderColor),
                ),
                child: Material(
                  borderRadius: _borderRadius,
                  color: style?.selectedStyle?.backgroundColor,
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
      child: ExcludeSemantics(
        child: Row(
          children: widget.widgetBuilders.mapIndexed((i, element) {
            final selected = i == widget.selectedStateIndex;
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
                  child: element(style, selected),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
