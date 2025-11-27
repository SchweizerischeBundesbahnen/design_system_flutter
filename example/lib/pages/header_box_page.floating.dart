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
    final style = SBBBaseStyle.of(context);
    return FocusScope(
      // This prevents the headerbox from shrinking when something is focused
      onFocusChange: (focused) => setState(() => resizing = !focused),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            SBBSliverFloatingHeaderbox.custom(
              resizing: resizing,
              padding: EdgeInsets.zero,
              flap: _flap(),
              flapMode: SBBHeaderboxFlapMode.hideable,
              children: [
                _crossfadeExample(context, style),
                _additionalRowsSwitcher(context),
                _contractibleExample(sbbToast, style),
              ],
            ),
            SliverList.builder(
              itemCount: 60,
              itemBuilder: (context, index) => SBBListItem(
                title: 'Item $index',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  sbbToast.show(title: 'Pressed Item $index', bottom: sbbDefaultSpacing * 6);
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
            alignment: Alignment.centerRight,
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

  Widget _crossfadeExample(BuildContext context, SBBBaseStyle style) {
    final key = GlobalKey();
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
            constraints: BoxConstraints(minWidth: double.infinity),
            padding: const EdgeInsets.all(sbbDefaultSpacing),
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
        padding: const EdgeInsets.only(left: sbbDefaultSpacing, top: sbbDefaultSpacing * 0.5),
        child: Row(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: sbbDefaultSpacing),
                    child: _circle(context),
                  ),
                ),
                Positioned(
                  top: sbbDefaultSpacing * 2,
                  bottom: sbbDefaultSpacing * 2,
                  left: sbbDefaultSpacing * 0.5 - 0.5,
                  child: Container(
                    color: style.labelColor,
                    width: 1,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: sbbDefaultSpacing),
                    child: _circle(context),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: OverflowBox(
                      maxHeight: double.infinity,
                      child: SBBTextField(
                        labelText: 'Origin',
                      ),
                    ),
                  ),
                  Flexible(
                    child: OverflowBox(
                      maxHeight: double.infinity,
                      child: SBBTextField(
                        labelText: 'Destination',
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

  SBBContractible _contractibleExample(SBBToast sbbToast, SBBBaseStyle style) {
    return SBBContractible(
      behavior: pushMode ? SBBContractionBehavior.displace : SBBContractionBehavior.clip,
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
            pushMode: pushMode,
            onTap: () {
              setState(() {
                pushMode = !pushMode;
                FocusScope.of(context).unfocus();
              });
              sbbToast.show(title: 'Toggled mode', bottom: sbbDefaultSpacing * 6);
            },
          ),
        ],
      ),
    );
  }

  Container _circle(BuildContext context) {
    var decoration = BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
    return Container(
      decoration: decoration,
      width: sbbDefaultSpacing,
      height: sbbDefaultSpacing,
      child: Container(
        decoration: decoration,
        margin: EdgeInsets.all(3),
      ),
    );
  }

  List<Widget> _additionalRows(BuildContext context) {
    return [
      SBBListItem(title: 'Static with progress bar', onPressed: null),
      SBBContractionListener(
        builder: (context, state, _) => FractionallySizedBox(
          widthFactor: state.contractionValue,
          alignment: Alignment.topLeft,
          child: Container(
            height: 5,
            color: SBBColors.red,
          ),
        ),
      ),
      SBBContractible.custom(
        behavior: SBBContractionBehavior.center,
        child: Center(child: SBBListItem(title: 'Stay center', onPressed: null)),
      ),
      SBBContractible(
        builder: (context, state, child) => Transform.translate(
          offset: Offset((1.0 - state.expansionValue) * 30, 0.0),
          child: child,
        ),
        child: SBBListItem(title: 'React to progress', onPressed: null),
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
    required this.pushMode,
    required this.onTap,
  });

  final bool pushMode;
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
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.zero,
          child: Icon(SBBIcons.controls_small),
        ),
      ),
    );
  }
}
