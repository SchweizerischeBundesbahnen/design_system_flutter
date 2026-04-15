part of 'header_box_page.dart';

class FloatingPage extends StatefulWidget {
  const FloatingPage({super.key});

  @override
  State<FloatingPage> createState() => _FloatingPageState();
}

class _FloatingPageState extends State<FloatingPage> {
  bool pushMode = true;
  bool resizing = true;
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return FocusScope(
      // This prevents the headerbox from shrinking when something is focused
      onFocusChange: (focused) => setState(() => resizing = !focused),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            SBBSliverFloatingHeaderbox.custom(
              resizing: resizing,
              padding: .zero,
              flap: _flap(),
              flapMode: .hideable,
              children: [
                _crossfadeExample(context),
                _additionalRowsSwitcher(context),
                _contractibleExample(sbbToast),
              ],
            ),
            SliverList.builder(
              itemCount: 60,
              itemBuilder: (context, index) => SBBListItem(
                titleText: 'Item $index',
                onTap: () {
                  FocusScope.of(context).unfocus();
                  sbbToast.show(titleText: 'Pressed Item $index', bottom: 96.0);
                },
              ),
            ),
            const SBBSliverFloatingHeaderboxSpacer(),
          ],
        ),
      ),
    );
  }

  SBBHeaderboxFlap _flap() {
    return SBBHeaderboxFlap.custom(
      child: Row(
        children: [
          Text('Thursday, 01/31/2025', style: SBBTextStyles.smallLight),
          Spacer(),
          SizedOverflowBox(
            size: Size(54, 24),
            alignment: .centerRight,
            child: SBBTertiaryButtonSmall(
              iconData: showAll ? SBBIcons.arrow_up_small : SBBIcons.arrow_down_small,
              onPressed: () {
                setState(() {
                  showAll = !showAll;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _crossfadeExample(BuildContext context) {
    final key = GlobalKey();
    final colorScheme = Theme.of(context).sbbBaseStyle.colorScheme;
    return SBBContractible.crossfade(
      // The contracted child is simply a summarized version of the origin and destination.
      contractedChild: Material(
        color: SBBColors.transparent,
        child: InkWell(
          key: key,
          onTap: () {
            // Expand the headerbox on tap.
            // For this to work, we need a context that is a descendant of the headerbox.
            // In this case, we capture it using a key.
            SBBSliverFloatingHeaderbox.expand(key.currentContext!);
          },
          child: Container(
            constraints: BoxConstraints(minWidth: .infinity),
            padding: const .all(SBBSpacing.medium),
            child: Text(
              'Bern → Bern Wankdorf',
              style: SBBTextStyles.mediumBold,
            ),
          ),
        ),
      ),
      // The expanded child is somewhat complicated to achieve the dynamic layout.
      // It could be simplified massively if we were fine with a simple crossfade that only changes the opacity.
      expandedChild: Padding(
        padding: const .only(left: SBBSpacing.medium, top: SBBSpacing.xSmall),
        child: Row(
          children: [
            Stack(
              children: [
                Align(
                  alignment: .topCenter,
                  child: Padding(
                    padding: const .only(top: SBBSpacing.medium),
                    child: _circle(context),
                  ),
                ),
                Positioned(
                  top: SBBSpacing.xLarge,
                  bottom: SBBSpacing.xLarge,
                  left: SBBSpacing.xSmall - 0.5,
                  child: Container(
                    color: colorScheme.labelColor,
                    width: 1,
                  ),
                ),
                Align(
                  alignment: .bottomCenter,
                  child: Padding(
                    padding: const .only(bottom: SBBSpacing.medium),
                    child: _circle(context),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Flexible(
                    child: OverflowBox(
                      maxHeight: .infinity,
                      child: SBBTextInput(
                        decoration: SBBInputDecoration(
                          labelText: 'Origin',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: OverflowBox(
                      maxHeight: .infinity,
                      child: SBBTextInput(
                        decoration: SBBInputDecoration(
                          labelText: 'Destination',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SBBContractible _contractibleExample(SBBToast sbbToast) {
    return SBBContractible(
      behavior: pushMode ? .displace : .clip,
      builder:
          // We can react to the current state of expansion and set an opacity accordingly.
          (context, state, child) => Opacity(
            opacity: state.expansionValue,
            child: child,
          ),
      child: Row(
        children: [
          SizedBox(width: 48),
          Center(child: pushMode ? Text('Footer that gets displaced') : Text('Footer that gets clipped')),
          Spacer(),
          ControlsButton(
            onTap: () {
              setState(() {
                pushMode = !pushMode;
                FocusScope.of(context).unfocus();
              });
              sbbToast.show(titleText: 'Toggled mode', bottom: 96.0);
            },
          ),
        ],
      ),
    );
  }

  Container _circle(BuildContext context) {
    var decoration = BoxDecoration(
      shape: .circle,
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
    return Container(
      decoration: decoration,
      width: SBBSpacing.medium,
      height: SBBSpacing.medium,
      child: Container(
        decoration: decoration,
        margin: .all(3),
      ),
    );
  }

  List<Widget> _additionalRows(BuildContext context) {
    final primaryColor = Theme.of(context).sbbBaseStyle.colorScheme.primaryColor;
    return [
      SBBListItem(titleText: 'Static with progress bar', onTap: null),
      SBBContractionListener(
        builder: (context, state, _) => FractionallySizedBox(
          widthFactor: state.contractionValue,
          alignment: .topLeft,
          child: Container(
            height: 5,
            color: primaryColor,
          ),
        ),
      ),
      SBBContractible.custom(
        behavior: .center,
        child: Center(child: SBBListItem(titleText: 'Stay center', onTap: null)),
      ),
      SBBContractible(
        builder: (context, state, child) => Transform.translate(
          offset: Offset((1.0 - state.expansionValue) * 30, 0.0),
          child: child,
        ),
        child: SBBListItem(titleText: 'React to progress', onTap: null),
      ),
    ];
  }

  Widget _additionalRowsSwitcher(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.long2,
      switchInCurve: Curves.easeInOutCubic,
      switchOutCurve: Curves.easeInOutCubic,
      transitionBuilder: (child, anim) => SizeTransition(
        sizeFactor: anim,
        child: child,
      ),
      child: showAll
          ? SBBCascadeColumn(
              children: _additionalRows(context),
            )
          : SizedBox(),
    );
  }
}

class ControlsButton extends StatelessWidget {
  const ControlsButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SBBColors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: BorderDirectional(
              start: BorderSide(color: Theme.of(context).dividerTheme.color!),
            ),
          ),
          padding: .all(12.0),
          margin: .zero,
          child: Icon(SBBIcons.controls_small),
        ),
      ),
    );
  }
}
