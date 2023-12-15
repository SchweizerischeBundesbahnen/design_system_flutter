import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// Signature for the callback that's called when an [SBBAccordionItem] is
/// expanded or collapsed.
///
/// The position of the item within an [SBBAccordion] is given by [index].
typedef AccordionCallback = void Function(int index, bool isExpanded);

/// Variant of [AccordionCallback] for constructor [SBBAccordion.single]
typedef SingleAccordionCallback = void Function(bool isExpanded);

/// The SBB Accordion item - heavily inspired be the material expansion panel.
/// Use according to documentation.
///
/// It has a title and a body and can be either expanded or collapsed. The body
/// of the item is only visible when it is expanded.
///
/// Accordion items are only intended to be used as children for [SBBAccordion].
///
/// See also:
///
/// * [SBBAccordion], which is intended to be used as the parent widget.
/// * [ExpansionPanel], which this widget is based on.
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/accordion>
class SBBAccordionItem {
  /// Creates an accordion item to be used as a child for [SBBAccordion].
  /// See [SBBAccordion] for an example on how to use this widget.
  ///
  /// The [title], [body], and [isExpanded] arguments must not be null.
  SBBAccordionItem({
    required this.title,
    required this.body,
    this.isExpanded = false,
    this.padding = const EdgeInsetsDirectional.fromSTEB(
      sbbDefaultSpacing,
      10.0,
      sbbDefaultSpacing,
      sbbDefaultSpacing,
    ),
  });

  SBBAccordionItem.text({
    required String title,
    required String text,
    bool isExpanded = false,
  }) : this(
          title: title,
          body: Text(text),
          isExpanded: isExpanded,
        );

  /// The title text that's displayed in the header.
  final String title;

  /// The body of the accordion item that's displayed below the header.
  ///
  /// This widget is visible only when the item is expanded.
  final Widget body;

  /// Whether the item is expanded.
  ///
  /// Defaults to false.
  final bool isExpanded;

  /// The padding around the body.
  ///
  /// Defaults to ```EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 16.0)```
  final EdgeInsetsGeometry padding;
}

/// The SBB Accordion - heavily inspired be the material expansion panel list.
/// Use according to documentation.
///
/// See also:
///
/// * [SBBAccordionItem], which is intended to be used as children for this widget.
/// * [ExpansionPanelList], which this widget is based on.
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/accordion>
class SBBAccordion extends StatefulWidget {
  const SBBAccordion({
    Key? key,
    this.children = const <SBBAccordionItem>[],
    this.titleMaxLines,
    this.accordionCallback,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  SBBAccordion.single({
    required String title,
    required Widget body,
    bool isExpanded = false,
    int? titleMaxLines,
    SingleAccordionCallback? singleAccordionCallback,
    backgroundColor,
    borderColor,
  }) : this(
          children: [
            SBBAccordionItem(
              title: title,
              body: body,
              isExpanded: isExpanded,
            ),
          ],
          titleMaxLines: titleMaxLines,
          accordionCallback: (index, isExpanded) =>
              singleAccordionCallback?.call(
            isExpanded,
          ),
          backgroundColor: backgroundColor,
          borderColor: borderColor,
        );

  final List<SBBAccordionItem> children;
  final int? titleMaxLines;
  final AccordionCallback? accordionCallback;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  State<StatefulWidget> createState() => _SBBAccordionState();
}

class _SBBAccordionState extends State<SBBAccordion> {
  bool _isChildExpanded(int index) {
    return widget.children[index].isExpanded;
  }

  void _handlePressed(bool isExpanded, int index) {
    widget.accordionCallback?.call(index, isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    // TODO use these: MaterialLocalizations.of(context).expandedIconTapHint; MaterialLocalizations.of(context).collapsedIconTapHint;
    final bool isWeb = SBBBaseStyle.of(context).hostPlatform == HostPlatform.web;
    final style = SBBControlStyles.of(context);
    final List<Widget> items = <Widget>[];
    for (int i = 0; i < widget.children.length; i++) {
      final SBBAccordionItem child = widget.children[i];
      items.add(
        isWeb
            ? _buildAccordionWeb(context, child, i)
            : _buildAccordionNative(context, child, i),
      );
    }

    return Material(
      color: widget.backgroundColor ?? style.accordionBackgroundColor,
      child: Column(
        children: items,
      ),
    );
  }

  Container _buildAccordionNative(BuildContext context, SBBAccordionItem child, int i) {
    final style = SBBControlStyles.of(context);
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: widget.borderColor ?? SBBColors.transparent)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MergeSemantics(
            child: InkWell(
              onTap: () => _handlePressed(_isChildExpanded(i), i),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: sbbDefaultSpacing),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Text(
                        child.title,
                        style: style.accordionTitleTextStyle,
                        maxLines: widget.titleMaxLines,
                        overflow: widget.titleMaxLines == null
                            ? null
                            : TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: sbbDefaultSpacing / 2,
                    ),
                    child: _ExpandIcon(
                      _isChildExpanded(i),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(height: 0.0),
            secondChild: Container(
              width: double.infinity,
              padding: child.padding,
              child: DefaultTextStyle(
                style: style.accordionBodyTextStyle!,
                child: child.body,
              ),
            ),
            firstCurve: const Interval(
              0.0,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
            secondCurve: const Interval(
              0.4,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState: _isChildExpanded(i)
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: kThemeAnimationDuration,
          ),
          if (i < widget.children.length - 1) const Divider(),
        ],
      ),
    );
  }

  Widget _buildAccordionWeb(BuildContext context, SBBAccordionItem child, int i) {
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor ??
              (_isChildExpanded(i) ? SBBColors.white : SBBColors.milk),
          border: Border.all(
              color: widget.borderColor ??
                  (_isChildExpanded(i) ? SBBColors.graphite : SBBColors.milk))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MergeSemantics(
            child: InkWell(
              highlightColor: SBBColors.transparent,
              splashColor: SBBColors.transparent,
              hoverColor: SBBColors.transparent,
              onTap: () => _handlePressed(_isChildExpanded(i), i),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: sbbDefaultSpacing),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        child.title,
                        style: SBBWebTextStyles.accordionHeader,
                        maxLines: widget.titleMaxLines,
                        overflow: widget.titleMaxLines == null
                            ? null
                            : TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: sbbDefaultSpacing / 2,
                    ),
                    child: _ExpandIcon(
                      _isChildExpanded(i),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isChildExpanded(i))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const SBBMenuDivider(),
            ),
          AnimatedCrossFade(
            firstChild: Container(height: 0.0),
            secondChild: Container(
              width: double.infinity,
              padding: child.padding,
              child: DefaultTextStyle(
                style: SBBWebTextStyles.medium.copyWith(color: SBBColors.black),
                child: child.body,
              ),
            ),
            firstCurve: const Interval(
              0.0,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
            secondCurve: const Interval(
              0.4,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState: _isChildExpanded(i)
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: kThemeAnimationDuration,
          ),
          if ((i < widget.children.length - 1) && !_isChildExpanded(i))
            const Divider(),
        ],
      ),
    );
  }
}

class _ExpandIcon extends StatefulWidget {
  const _ExpandIcon(this.isExpanded);

  final bool isExpanded;

  @override
  _ExpandIconState createState() => _ExpandIconState();
}

class _ExpandIconState extends State<_ExpandIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );
    _iconTurns = _controller.drive(
      Tween<double>(
        begin: 0.0,
        end: 0.5,
      ).chain(
        CurveTween(
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    // If the widget is initially expanded, rotate the icon without animating it.
    if (widget.isExpanded) {
      _controller.value = _controller.upperBound;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeb = SBBBaseStyle.of(context).hostPlatform == HostPlatform.web;
    return IgnorePointer(
      child: RotationTransition(
        turns: _iconTurns,
        child: isWeb ? _iconWeb() : _iconNative(),
      ),
    );
  }

  Widget _iconNative() {
    return SBBIconButtonSmall(
      icon: SBBIcons.chevron_small_down_small,
      onPressed: () {},
    );
  }

  Widget _iconWeb() {
    return Icon(
      SBBIcons.chevron_small_down_medium,
      size: 36,
    );
  }

  @override
  void didUpdateWidget(_ExpandIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
