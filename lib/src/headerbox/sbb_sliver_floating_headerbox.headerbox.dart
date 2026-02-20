part of 'sbb_sliver_floating_headerbox.dart';

const _headerBoxMinHeight = 56.0;
const _headerBoxNavBarExtensionHeight = 24.0;
const _headerBoxRadius = Radius.circular(SBBSpacing.medium);
const _headerBoxFlapTopMargin = 8.0;

enum SBBHeaderboxFlapMode { static, resizable, hideable }

/// This is an adapted version of SBBHeaderbox.
/// The primary changes are:
///
/// - Wraps content in Flexible
/// - Supports special flap behavior
class _Headerbox extends StatelessWidget {
  const _Headerbox({
    required this.child,
    this.margin = const .symmetric(horizontal: SBBSpacing.xSmall),
    this.padding = const .all(SBBSpacing.medium),
    this.flap,
    this.flapMode = .static,
    this.semanticsLabel,
  });

  /// Defaults to EdgeInsets.symmetric(horizonal: 8.0).
  final EdgeInsets margin;

  final Widget child;

  /// The space around [child].
  final EdgeInsets padding;

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
    this.flapMode = .static,
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
    return Container(
      decoration: _flappedBackgroundDecoration(context),
      child: _column(_headerBox(context), flap!),
    );
  }

  Widget _column(Widget content, Widget flap) {
    switch (flapMode) {
      case .static:
        return Column(
          children: [
            Flexible(child: content),
            SizedBox(height: _headerBoxFlapTopMargin),
            flap,
          ],
        );
      case .resizable:
        return SBBCascadeColumn(
          children: [
            content,
            SizedBox(height: _headerBoxFlapTopMargin),
            flap,
          ],
        );
      case .hideable:
        return SBBCascadeColumn(
          children: [
            content,
            SBBContractible(
              behavior: .displace,
              child: Padding(
                padding: const .only(top: _headerBoxFlapTopMargin),
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
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.all(_headerBoxRadius),
        boxShadow: _headerBoxShadow,
      ),
      constraints: BoxConstraints(minHeight: _headerBoxMinHeight, minWidth: .infinity),
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
        begin: .bottomCenter,
        end: .topCenter,
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
      alignment: .topCenter,
      child: Container(
        color: headerColorPrimary,
        height: _headerBoxNavBarExtensionHeight,
      ),
    );
  }
}
