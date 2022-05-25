import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

const _kBorderRadius = 2.0;
const _kVerticalPadding = 12.0;
const _kHorizontalPadding = 16.0;
const _kScrollingDuration = Duration(milliseconds: 600);

class SBBWebNotification extends StatefulWidget {
  const SBBWebNotification.confirmation(
    this.text, {
    Key? key,
    this.textColor = SBBColors.green,
    this.borderColor = SBBColors.green,
    this.backgroundColor = SBBColors.white,
    this.icon = SBBIcons.tick_medium,
    this.jumpMarks,
    this.expand = false,
  }) : super(key: key);

  const SBBWebNotification.hint(
    this.text, {
    Key? key,
    this.textColor = SBBColors.granite,
    this.borderColor = SBBColors.granite,
    this.backgroundColor = SBBColors.white,
    this.icon = SBBIcons.circle_information_medium,
    this.jumpMarks,
    this.expand = false,
  }) : super(key: key);

  const SBBWebNotification.warning(
    this.text, {
    Key? key,
    this.textColor = SBBColors.white,
    this.borderColor,
    this.backgroundColor = SBBColors.orange,
    this.icon = SBBIcons.sign_x_medium,
    this.jumpMarks,
    this.expand = false,
  }) : super(key: key);

  const SBBWebNotification.error(
    this.text, {
    Key? key,
    this.textColor = SBBColors.white,
    this.borderColor,
    this.backgroundColor = SBBColors.red,
    this.icon = SBBIcons.sign_x_medium,
    this.jumpMarks,
    this.expand = false,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final Color? borderColor;
  final Color backgroundColor;
  final IconData icon;
  final List<SBBJumpMark>? jumpMarks;
  final bool expand;

  @override
  State<SBBWebNotification> createState() => _SBBWebNotificationState();
}

class _SBBWebNotificationState extends State<SBBWebNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  @override
  void didUpdateWidget(SBBWebNotification oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> jumpMarksWithSpacers = [];
    if (widget.jumpMarks != null) {
      for (int i = 0; i < widget.jumpMarks!.length; i++) {
        jumpMarksWithSpacers.add(widget.jumpMarks![i]);

        if (i == widget.jumpMarks!.length - 1) break;
        jumpMarksWithSpacers.add(SizedBox(width: 8.0));
        jumpMarksWithSpacers.add(Text('/'));
        jumpMarksWithSpacers.add(SizedBox(width: 8.0));
      }
    }

    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: _kHorizontalPadding, vertical: _kVerticalPadding),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: widget.textColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: _kHorizontalPadding),
                  child: DefaultTextStyle(
                    style: SBBWebTextStyles.medium
                        .copyWith(color: widget.textColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.text),
                        Row(
                          children: jumpMarksWithSpacers,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: Icon(SBBIcons.cross_medium, color: widget.textColor),
                  onTap: () {
                    setState(() {
                      expandController.reverse();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(_kBorderRadius)),
            border: widget.borderColor != null
                ? Border.all(color: widget.borderColor!)
                : null),
      ),
    );
  }
}

class SBBJumpMark extends StatelessWidget {
  const SBBJumpMark({Key? key, required this.text, required this.keyToScrollTo})
      : super(key: key);

  final String text;
  final GlobalKey keyToScrollTo;

  _scroll() {
    if (keyToScrollTo.currentContext == null) return;
    Scrollable.ensureVisible(keyToScrollTo.currentContext!,
        duration: _kScrollingDuration);

    // For highlighting
    //keyToScrollTo.currentState?._highlightChild();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _scroll(),
      child: Text(
        text,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(decoration: TextDecoration.underline),
      ),
    );
  }
}

/*class SBBJumpable extends StatefulWidget {
  const SBBJumpable(
      {required Key key,
      required this.child,
      this.highlightColor = SBBColors.peach})
      : super(key: key);

  final Widget child;
  final Color highlightColor;

  @override
  State<SBBJumpable> createState() => SBBJumpableState();
}

class SBBJumpableState extends State<SBBJumpable> {
  bool _highlight = false;

  void _highlightChild() {
    setState(() {
      _highlight = true;
    });
  }

  void _endHighlighting() {
    setState(() {
      _highlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        color: _highlight
            ? widget.highlightColor
            : widget.highlightColor.withOpacity(
                0), // setting the opacity to 0 ist better in animation.
        duration: _kScrollingDuration * 2,
        onEnd: () => _endHighlighting(),
        curve: Curves.easeInOut,
        child: widget.child);
  }
}*/
