import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

/// The SBB Notification Box.
///
/// A dismissable widget to display important information to the user.
///
/// Provide either [title] for a custom title widget or [titleText] for a text-only
/// title with standard styling. For a custom leading widget, use [leading] instead of
/// [leadingIconData]. For a custom trailing widget, use [trailing] instead of
/// [trailingIconData]. These parameter pairs are mutually exclusive.
///
/// Use the factory constructors to create specific notification types:
/// * [SBBNotificationBox.alert] for error or alert states
/// * [SBBNotificationBox.warning] for warning states
/// * [SBBNotificationBox.success] for success states
/// * [SBBNotificationBox.information] for informational states
///
/// ## Sample code
///
/// ```dart
/// // Simple text notification
/// SBBNotificationBox.alert(text: 'Connection lost')
///
/// // Notification with title and tap handler
/// SBBNotificationBox.warning(
///   titleText: 'Maintenance',
///   text: 'The server will be unavailable tonight.',
///   trailingIconData: SBBIcons.chevron_small_right_small,
///   onTap: () => navigateToDetails(),
/// )
///
/// // Toggling visibility via parent state
/// SBBNotificationBox.success(
///   text: 'Upload complete',
///   isVisible: _showSuccess,
///   onDismissRequested: () => setState(() => _showSuccess = false),
/// )
/// ```
///
/// See also:
///
/// * [SBBNotificationBoxStyle], for customizing the appearance.
/// * [SBBNotificationBoxThemeData], for setting the style for all notification boxes within the current Theme.
/// * [SBBStatus] for a non-dismissable, compact way to display information to the user.
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=290-4135&p=f&t=YnIgdoYSNPGm5rTt-0)
sealed class SBBNotificationBox extends StatefulWidget {
  const SBBNotificationBox._({
    super.key,
    required this.text,
    this.controller,
    this.title,
    this.titleText,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    this.isVisible = true,
    this.onTap,
    this.onTapSemanticsHint,
    this.onDismissed,
    this.style,
    this.semanticLabel,
  }) : assert(title == null || titleText == null, 'Cannot provide both title and titleText.'),
       assert(leading == null || leadingIconData == null, 'Cannot provide both leading and leadingIconData.'),
       assert(trailing == null || trailingIconData == null, 'Cannot provide both trailing and trailingIconData.');

  /// Creates an alert notification box.
  ///
  /// The default leading icon is [SBBIcons.circle_cross_small].
  const factory SBBNotificationBox.alert({
    Key? key,
    required String text,
    SBBNotificationBoxController? controller,
    Widget? title,
    String? titleText,
    Widget? leading,
    IconData? leadingIconData,
    Widget? trailing,
    IconData? trailingIconData,
    bool isVisible,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    GestureTapCallback? onDismissed,
    SBBNotificationBoxStyle? style,
    String? semanticLabel,
  }) = _SBBNotificationBoxAlert;

  /// Creates a warning notification box.
  ///
  /// The default leading icon is [SBBIcons.circle_exclamation_point_small].
  const factory SBBNotificationBox.warning({
    Key? key,
    required String text,
    SBBNotificationBoxController? controller,
    Widget? title,
    String? titleText,
    Widget? leading,
    IconData? leadingIconData,
    Widget? trailing,
    IconData? trailingIconData,
    bool isVisible,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    GestureTapCallback? onDismissed,
    SBBNotificationBoxStyle? style,
    String? semanticLabel,
  }) = _SBBNotificationBoxWarning;

  /// Creates a success notification box.
  ///
  /// The default leading icon is [SBBIcons.circle_tick_small].
  const factory SBBNotificationBox.success({
    Key? key,
    required String text,
    SBBNotificationBoxController? controller,
    Widget? title,
    String? titleText,
    Widget? leading,
    IconData? leadingIconData,
    Widget? trailing,
    IconData? trailingIconData,
    bool isVisible,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    GestureTapCallback? onDismissed,
    SBBNotificationBoxStyle? style,
    String? semanticLabel,
  }) = _SBBNotificationBoxSuccess;

  /// Creates an information notification box.
  ///
  /// The default leading icon is [SBBIcons.circle_information_small].
  const factory SBBNotificationBox.information({
    Key? key,
    required String text,
    SBBNotificationBoxController? controller,
    Widget? title,
    String? titleText,
    Widget? leading,
    IconData? leadingIconData,
    Widget? trailing,
    IconData? trailingIconData,
    bool isVisible,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    GestureTapCallback? onDismissed,
    SBBNotificationBoxStyle? style,
    String? semanticLabel,
  }) = _SBBNotificationBoxInformation;

  /// An optional controller to programmatically show and hide the [SBBNotificationBox].
  ///
  /// If not provided, an internal controller is created automatically.
  final SBBNotificationBoxController? controller;

  /// The body text of the notification.
  final String text;

  /// A custom widget displayed as the notification title.
  ///
  /// For simple text titles, use [titleText] instead.
  ///
  /// Cannot be used together with [titleText].
  final Widget? title;

  /// Text string to display as the notification title using the standard design.
  ///
  /// Cannot be used together with [title].
  final String? titleText;

  /// A custom widget displayed in the leading position.
  ///
  /// For simple icon changes, use [leadingIconData] instead.
  /// If neither [leading] nor [leadingIconData] are provided, the default icon
  /// for this notification type is used from the current theme.
  ///
  /// Cannot be used together with [leadingIconData].
  final Widget? leading;

  /// Icon to display in the leading position instead of the default icon.
  ///
  /// Cannot be used together with [leading].
  final IconData? leadingIconData;

  /// A custom widget displayed in the trailing position.
  ///
  /// For simple icon changes, use [trailingIconData] instead.
  ///
  /// Cannot be used together with [trailingIconData].
  final Widget? trailing;

  /// Icon to display in the trailing position.
  ///
  /// Cannot be used together with [trailing].
  final IconData? trailingIconData;

  /// Whether the notification box is visible.
  ///
  /// When this value changes, the widget animates between shown and
  /// dismissed states. Set to `false` to dismiss with animation.
  ///
  /// Defaults to `true`.
  final bool isVisible;

  /// The semantic hint used if the notification box is tappable. See [onTap].
  final String? onTapSemanticsHint;

  /// Callback when the user taps the notification box except on the dismiss button.
  final GestureTapCallback? onTap;

  /// Callback invoked once the user taps the dismiss button.
  ///
  /// If non null, an inline [InkWell] close button is displayed in the title row.
  /// Tapping it will hide the promotion box via the [SBBNotificationBoxController]
  /// and invoke [onDismissed].
  ///
  /// This will not be invoked if the hiding is done through the [SBBNotificationBoxController].
  final GestureTapCallback? onDismissed;

  /// Customizes the appearance of this notification box.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in the theme and default styles.
  final SBBNotificationBoxStyle? style;

  /// Provides a textual description of the widget for assistive technologies.
  ///
  /// If non-null, semantics of child widgets are excluded.
  final String? semanticLabel;

  SBBNotificationBoxStyle? _getThemedStyle(BuildContext context);

  @override
  State<SBBNotificationBox> createState() => _SBBNotificationBoxState();
}

final class _SBBNotificationBoxAlert extends SBBNotificationBox {
  const _SBBNotificationBoxAlert({
    super.key,
    required super.text,
    super.controller,
    super.title,
    super.titleText,
    super.leading,
    IconData? leadingIconData,
    super.trailing,
    super.trailingIconData,
    super.isVisible,
    super.onTap,
    super.onTapSemanticsHint,
    super.onDismissed,
    super.style,
    super.semanticLabel,
  }) : super._(
         leadingIconData: leading == null && leadingIconData == null ? SBBIcons.circle_cross_small : leadingIconData,
       );

  @override
  SBBNotificationBoxStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbNotificationBoxTheme?.alert;
  }
}

final class _SBBNotificationBoxWarning extends SBBNotificationBox {
  const _SBBNotificationBoxWarning({
    super.key,
    required super.text,
    super.controller,
    super.title,
    super.titleText,
    super.leading,
    IconData? leadingIconData,
    super.trailing,
    super.trailingIconData,
    super.isVisible,
    super.onTap,
    super.onTapSemanticsHint,
    super.onDismissed,
    super.style,
    super.semanticLabel,
  }) : super._(
         leadingIconData: leading == null && leadingIconData == null
             ? SBBIcons.circle_exclamation_point_small
             : leadingIconData,
       );

  @override
  SBBNotificationBoxStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbNotificationBoxTheme?.warning;
  }
}

final class _SBBNotificationBoxSuccess extends SBBNotificationBox {
  const _SBBNotificationBoxSuccess({
    super.key,
    required super.text,
    super.controller,
    super.title,
    super.titleText,
    super.leading,
    IconData? leadingIconData,
    super.trailing,
    super.trailingIconData,
    super.isVisible,
    super.onTap,
    super.onTapSemanticsHint,
    super.onDismissed,
    super.style,
    super.semanticLabel,
  }) : super._(
         leadingIconData: leading == null && leadingIconData == null ? SBBIcons.circle_tick_small : leadingIconData,
       );

  @override
  SBBNotificationBoxStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbNotificationBoxTheme?.success;
  }
}

final class _SBBNotificationBoxInformation extends SBBNotificationBox {
  const _SBBNotificationBoxInformation({
    super.key,
    required super.text,
    super.controller,
    super.title,
    super.titleText,
    super.leading,
    IconData? leadingIconData,
    super.trailing,
    super.trailingIconData,
    super.isVisible,
    super.onTap,
    super.onTapSemanticsHint,
    super.onDismissed,
    super.style,
    super.semanticLabel,
  }) : super._(
         leadingIconData: leading == null && leadingIconData == null
             ? SBBIcons.circle_information_small
             : leadingIconData,
       );

  @override
  SBBNotificationBoxStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbNotificationBoxTheme?.information;
  }
}

class _SBBNotificationBoxState extends State<SBBNotificationBox> with SingleTickerProviderStateMixin {
  SBBNotificationBoxController? _internalController;

  SBBNotificationBoxController get _effectiveController =>
      widget.controller ?? (_internalController ??= SBBNotificationBoxController());

  bool get _isDismissible => widget.onDismissed != null;

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: _effectiveController.value ? 1.0 : 0.0,
      duration: kThemeAnimationDuration,
    );
    _effectiveController.addListener(_animate);
  }

  @override
  void didUpdateWidget(covariant SBBNotificationBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_animate);
      _effectiveController.addListener(_animate);
      if (widget.controller?.value != oldWidget.controller?.value) _animate();
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_animate);
    _animationController.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  bool get _hasTitle => widget.title != null || widget.titleText != null;

  bool get _hasTrailing => widget.trailing != null || widget.trailingIconData != null;

  @override
  Widget build(BuildContext context) {
    final themedStyle = widget._getThemedStyle(context)!;
    final effectiveStyle = themedStyle.merge(widget.style);

    final resolvedBackgroundColor = effectiveStyle.backgroundColor!;
    final resolvedBorderColor = effectiveStyle.borderColor!;
    final resolvedForegroundColor = effectiveStyle.foregroundColor!;
    final resolvedIconColor = effectiveStyle.iconColor!;
    final resolvedAlphaValue = effectiveStyle.alphaValue!;
    final resolvedTextStyle = effectiveStyle.textStyle!;
    final resolvedTitleTextStyle = effectiveStyle.titleTextStyle!;

    return _animationBuilder(
      animation: _animationController,
      child: Semantics(
        container: true,
        label: widget.semanticLabel,
        excludeSemantics: widget.semanticLabel != null,
        child: Stack(
          children: [
            Material(
              color: SBBColors.transparent,
              child: Semantics(
                onTapHint: widget.onTap != null ? widget.onTapSemanticsHint : null,
                child: InkWell(
                  overlayColor: effectiveStyle.overlayColor,
                  borderRadius: SBBNotificationBoxStyle.outerBorderRadius,
                  onTap: widget.onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: resolvedBackgroundColor,
                          width: SBBNotificationBoxStyle.leftBorderWidth,
                        ),
                      ),
                      borderRadius: SBBNotificationBoxStyle.outerBorderRadius,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: resolvedBorderColor),
                        borderRadius: SBBNotificationBoxStyle.innerBorderRadius,
                        color: resolvedBackgroundColor.withValues(alpha: resolvedAlphaValue),
                      ),
                      padding: const EdgeInsets.all(SBBSpacing.medium),
                      child: DefaultTextStyle.merge(
                        style: resolvedTextStyle.copyWith(color: resolvedForegroundColor),
                        child: IconTheme.merge(
                          data: IconThemeData(color: resolvedForegroundColor),
                          child: _hasTitle
                              ? _buildTitleLayout(
                                  resolvedIconColor: resolvedIconColor,
                                  resolvedTitleTextStyle: resolvedTitleTextStyle,
                                  resolvedForegroundColor: resolvedForegroundColor,
                                )
                              : _buildFlatLayout(
                                  resolvedIconColor: resolvedIconColor,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_isDismissible)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: SBBSpacing.medium, right: SBBSpacing.medium),
                  child: _dismissButton(context, effectiveStyle),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlatLayout({
    required Color resolvedIconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLeading(resolvedIconColor),
        const SizedBox(width: 8.0),
        Expanded(child: _buildTextContent()),
        if (_isDismissible) const SizedBox(width: sbbIconSizeSmall),
      ],
    );
  }

  Widget _buildTitleLayout({
    required Color resolvedIconColor,
    required TextStyle resolvedTitleTextStyle,
    required Color resolvedForegroundColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            _buildLeading(resolvedIconColor),
            const SizedBox(width: 8.0),
            Expanded(child: _buildTitle(resolvedTitleTextStyle, resolvedForegroundColor)),
          ],
        ),
        const SizedBox(height: 8.0),
        _buildTextContent(),
      ],
    );
  }

  Widget _buildLeading(Color iconColor) {
    if (widget.leading != null) return widget.leading!;

    if (widget.leadingIconData == null) return const SizedBox.shrink();

    return Icon(widget.leadingIconData, color: iconColor);
  }

  Widget _buildTitle(TextStyle titleTextStyle, Color foregroundColor) {
    if (widget.title != null) return widget.title!;

    return Text(
      widget.titleText!,
      style: titleTextStyle.copyWith(color: foregroundColor),
    );
  }

  Widget _buildTextContent() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.text,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (_hasTrailing) ...[
          const SizedBox(width: 8.0),
          _buildTrailing(),
        ],
      ],
    );
  }

  Widget _buildTrailing() {
    if (widget.trailing != null) return widget.trailing!;
    return Icon(widget.trailingIconData);
  }

  Widget? _dismissButton(BuildContext context, SBBNotificationBoxStyle effectiveStyle) {
    if (!_isDismissible) return null;
    return Material(
      borderRadius: .circular(sbbIconSizeSmall),
      color: SBBColors.transparent,
      child: Semantics(
        label: MaterialLocalizations.of(context).closeButtonTooltip,
        button: true,
        child: InkWell(
          borderRadius: .circular(sbbIconSizeSmall),
          onTap: () {
            _effectiveController.hide();
            widget.onDismissed?.call();
          },
          child: addDefaultAncestorWithResolved(
            child: const Icon(SBBIcons.cross_tiny_small, size: sbbIconSizeSmall),
            foregroundColor: effectiveStyle.dismissButtonForegroundColor,
          ),
        ),
      ),
    );
  }

  Widget _animationBuilder({required Animation<double> animation, required Widget child}) {
    return SizeTransition(
      axisAlignment: -1.0,
      sizeFactor: animation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  void _animate() => _animationController.animateTo(_effectiveController.value ? 1.0 : 0.0);
}
