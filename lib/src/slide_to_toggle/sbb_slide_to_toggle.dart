import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Slide-To-Toggle.
///
/// TODO
///
/// See also:
///
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=6666-1023)
class SBBSlideToToggle extends StatefulWidget {
  /// Creates an SBB Slide-To-Toggle.
  ///
  /// TODO: Docs, maybe asserts
  const SBBSlideToToggle({
    super.key,
    this.style,
    this.enabled = true,
  });

  /// Customizes this Slide-To-Toggle appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBSlideToToggleThemeData.style] of the theme found in [context].
  final SBBSlideToToggleStyle? style;

  final bool enabled;

  @override
  State<SBBSlideToToggle> createState() => _SBBSlideToToggleState();
}

class _SBBSlideToToggleState extends State<SBBSlideToToggle> {
  late WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();
  }

  @override
  void didUpdateWidget(SBBSlideToToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      _updateStatesController();
    }
  }

  void _updateStatesController() {
    _statesController.update(WidgetState.disabled, !widget.enabled);
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbSlideToToggleTheme!.style!;
    final effectiveStyle = themeStyle.merge(widget.style);
    final states = _statesController.value;

    final borderColor = effectiveStyle.borderColor?.resolve(states) ?? SBBColors.granite;
    final backgroundColor = effectiveStyle.backgroundColor?.resolve(states) ?? SBBColors.white;

    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: StadiumBorder(side: BorderSide(color: borderColor)),
        color: backgroundColor,
      ),
      child: Text('TEST'),
    );
  }
}
