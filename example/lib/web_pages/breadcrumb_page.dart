import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

List<Widget> _levels = [
  Text('Level 1'),
  Text('Level 2'),
  Row(mainAxisSize: MainAxisSize.min, children: [
    Text('Level 3 with Icon'),
    Icon(SBBIcons.cup_hot_medium),
  ]),
  Text('Level 4'),
  Text('Level 5'),
];

class BreadcrumbPage extends StatelessWidget {
  const BreadcrumbPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: SingleChildScrollView(
          primary: false,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  child: _StatefulContent()),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatefulContent extends StatefulWidget {
  const _StatefulContent({Key? key}) : super(key: key);

  @override
  State<_StatefulContent> createState() => __StatefulContentState();
}

class __StatefulContentState extends State<_StatefulContent> {
  int _index = 4;

  void _setIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SBBWebText.headerOne('Breadcrumb', color: SBBColors.red),
        SBBWebText.headerTwo('Ausprägungen'),
        SBBWebText.headerThree('- Standard'),
        _leveledBreadcrumb(index: _index, callback: _setIndex),
        SBBWebText.headerThree('- Wrapped'),
        SizedBox(
          width: 300.0,
          child: _leveledBreadcrumb(index: _index, callback: _setIndex),
        ),
        SBBWebText.headerTwo('Adjust levels'),
        _IndexButtons(index: _index, callback: _setIndex),
      ],
    );
  }
}

class _IndexButtons extends StatelessWidget {
  const _IndexButtons({Key? key, required this.index, required this.callback})
      : super(key: key);

  final int index;
  final Function(int i) callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SBBIconButtonSmall(
            icon: SBBIcons.minus_small,
            onPressed: () => callback(_restrictIndexToZero())),
        SizedBox(width: sbbDefaultSpacing),
        SBBIconButtonSmall(
            icon: SBBIcons.plus_small,
            onPressed: () => callback(_restrictToLevelLength())),
      ],
    );
  }

  int _restrictToLevelLength() {
    return index + 1 > _levels.length - 1 ? _levels.length - 1 : index + 1;
  }

  int _restrictIndexToZero() => index - 1 < 0 ? 0 : index - 1;
}

class _leveledBreadcrumb extends StatelessWidget {
  const _leveledBreadcrumb(
      {Key? key, required this.index, required this.callback})
      : super(key: key);

  final int index;
  final Function(int i) callback;

  @override
  Widget build(BuildContext context) {
    List<SBBBreadcrumbItem> items = [];

    for (int i = 0; i <= index; i++) {
      items.add(SBBBreadcrumbItem(
        child: _levels[i],
        onPressed: i == index ? null : () => callback(i),
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: sbbDefaultSpacing),
      child: SBBBreadcrumb(
        textStyle: SBBWebTextStyles.medium,
        onLeadingPressed: () => callback(0),
        breadcrumbItems: items,
      ),
    );
  }
}
