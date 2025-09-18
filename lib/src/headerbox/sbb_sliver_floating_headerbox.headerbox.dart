part of 'sbb_sliver_floating_headerbox.dart';

const _headerBoxMinHeight = 56.0;
const _headerBoxNavBarExtensionHeight = 24.0;
const _headerBoxRadius = Radius.circular(sbbDefaultSpacing);
const _headerBoxFlapTopMargin = 8.0;

enum SBBHeaderboxFlapMode { static, resizable, hideable }

class _Headerbox extends StatelessWidget {
  const _Headerbox({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    this.padding = const EdgeInsets.all(sbbDefaultSpacing),
    this.flap,
    this.flapMode = SBBHeaderboxFlapMode.static,
    this.semanticsLabel,
  });

  /// The margin around the [SBBHeaderbox].
  ///
  /// Defaults to EdgeInsets.symmetric(horizonal: 8.0).
  final EdgeInsets margin;

  final Widget child;

  /// The space around [child].
  final EdgeInsets padding;

  /// The flap to display below the [SBBHeaderbox].
  final SBBHeaderboxFlap? flap;

  final SBBHeaderboxFlapMode flapMode;

  /// The semantic label for the Headerbox that will be announced by screen readers.
  ///
  /// This is announced by assistive technologies (e.g TalkBack/VoiceOver).
  ///
  /// This label does not show in the UI.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _HeaderBoxBackgroundBar(),
        Padding(
          padding: margin,
          child: _HeaderBoxForeground(
            padding: padding,
            flap: flap,
            flapMode: flapMode,
            semanticsLabel: semanticsLabel,
            child: child,
          ),
        ),
      ],
    );
  }
}

class _HeaderBoxForeground extends StatelessWidget {
  const _HeaderBoxForeground({
    required this.child,
    required this.padding,
    this.semanticsLabel,
    this.flap,
    this.flapMode = SBBHeaderboxFlapMode.static,
  });

  final EdgeInsets padding;
  final Widget child;
  final String? semanticsLabel;
  final SBBHeaderboxFlap? flap;
  final SBBHeaderboxFlapMode flapMode;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        header: true,
        label: semanticsLabel,
        child: flap != null ? _flappedHeaderBox(context) : _headerBox(context),
      ),
    );
  }

  Widget _flappedHeaderBox(BuildContext context) {
    final flap = this.flap!;

    return Container(
      decoration: _flappedBackgroundDecoration(context),
      child: _column(_headerBox(context), flap),
    );
  }

  Widget _column(Widget content, Widget flap) {
    switch (flapMode) {
      case SBBHeaderboxFlapMode.static:
        return Column(
          children: [
            Flexible(child: content),
            SizedBox(height: _headerBoxFlapTopMargin),
            flap,
          ],
        );
      case SBBHeaderboxFlapMode.resizable:
        return SBBStackedColumn(
          children: [
            content,
            SizedBox(height: _headerBoxFlapTopMargin),
            flap,
          ],
        );
      case SBBHeaderboxFlapMode.hideable:
        return SBBStackedColumn(
          children: [
            content,
            SBBStackedItem.aligned(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: _headerBoxFlapTopMargin),
                child: flap,
              ),
            ),
          ],
        );
    }
  }

  Widget _headerBox(BuildContext context) {
    final SBBHeaderBoxStyle style = SBBHeaderBoxStyle.of(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.all(_headerBoxRadius),
        boxShadow: _headerBoxShadow,
      ),
      constraints: BoxConstraints(minHeight: _headerBoxMinHeight, minWidth: double.infinity),
      padding: padding,
      child: child,
    );
  }

  BoxDecoration _flappedBackgroundDecoration(BuildContext context) {
    final Color flapBackgroundColor = SBBHeaderBoxStyle.of(context).flapBackgroundColor!;
    return BoxDecoration(
      boxShadow: SBBInternal.defaultBoxShadow,
      borderRadius: BorderRadius.only(bottomLeft: _headerBoxRadius, bottomRight: _headerBoxRadius),
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [flapBackgroundColor, flapBackgroundColor, SBBColors.white.withAlpha(0)],
        stops: [0.0, 0.5, 1.0],
      ),
    );
  }

  List<BoxShadow> get _headerBoxShadow => [
    BoxShadow(color: SBBColors.black.withAlpha(32), blurRadius: 4.0, offset: Offset(0, 2.0)),
  ];
}

class _HeaderBoxBackgroundBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // take AppBar background color to align with e.g. SBBHeader
    final Color? headerColorPrimary = Theme.of(context).appBarTheme.backgroundColor;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: headerColorPrimary,
        height: _headerBoxNavBarExtensionHeight,
      ),
    );
  }
}
