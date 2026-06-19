import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/debug.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

/// The SBB Notification Box.
///
/// A dismissable widget to display important information to the user.
///
/// Provide [content] for a custom widget or [contentText] for text-only content.
///
/// Optionally, provide either [title] or [titleText] for a title shown above the content. Provide [leading] or
/// [leadingIconData] to override the default icon determined by the type of notification, and [trailing] or
/// [trailingIconData] to show a trailing widget.
///
/// These parameter pairs are mutually exclusive.
///
/// Use [showLeading] to disable the leading icon altogether.
///
/// Use [state] to specify the status type, or use the factory constructors:
/// * [SBBNotificationBox.alert] for error or alert states
/// * [SBBNotificationBox.warning] for warning states
/// * [SBBNotificationBox.success] for success states
/// * [SBBNotificationBox.information] for informational states
///
/// ## Sample code
///
/// ```dart
/// // Simple text notification
/// SBBNotificationBox.alert(contentText: 'Connection lost')
///
/// // Using dynamic state
/// SBBNotificationBox(state: SBBNotificationBoxState.alert, contentText: 'Connection lost')
///
/// // Notification with title and tap handler
/// SBBNotificationBox.warning(
///   titleText: 'Maintenance',
///   contentText: 'The server will be unavailable tonight.',
///   trailingIconData: SBBIcons.chevron_small_right_small,
///   onTap: () => navigateToDetails(),
/// )
/// ```
///
/// See also:
///
/// * [SBBNotificationBoxStyle], for customizing the appearance.
/// * [SBBNotificationBoxThemeData], for setting the style for all notification boxes within the current Theme.
/// * [SBBNotificationBoxController] for programmatically showing and hiding a promotion box.
/// * [SBBNotificationBoxState], defines the visual state of the notification box.
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=290-4135&p=f&t=YnIgdoYSNPGm5rTt-0)
class SBBNotificationBox extends StatefulWidget {
  const SBBNotificationBox({
    super.key,
    required this.state,
    this.content,
    this.contentText,
    this.controller,
    this.title,
    this.titleText,
    this.leading,
    this.leadingIconData,
    this.showLeading = true,
    this.trailing,
    this.trailingIconData,
    this.onTap,
    this.onTapSemanticsHint,
    this.isDismissable = true,
    this.onDismissed,
    this.style,
    this.semanticLabel,
  }) : assert(title == null || titleText == null, 'Cannot provide both title and titleText.'),
       assert(leading == null || leadingIconData == null, 'Cannot provide both leading and leadingIconData.'),
       assert(trailing == null || trailingIconData == null, 'Cannot provide both trailing and trailingIconData.'),
       assert(content != null || contentText != null, 'Either content or contentText must be provided');

  /// Creates an alert notification box.
  ///
  /// The default leading icon is [SBBIcons.circle_cross_small].
  factory SBBNotificationBox.alert({
    Key? key,
    Widget? content,
    String? contentText,
    SBBNotificationBoxController? controller,
    Widget? title,
    String? titleText,
    Widget? leading,
    IconData? leadingIconData,
    bool showLeading = true,
    Widget? trailing,
    IconData? trailingIconData,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    bool isDismissable = true,
    GestureTapCallback? onDismissed,
    SBBNotificationBoxStyle? style,
    String? semanticLabel,
  }) => SBBNotificationBox(
    key: key,
    state: .alert,
    content: content,
    contentText: contentText,
    controller: controller,
    title: title,
    titleText: titleText,
    leading: leading,
    leadingIconData: leadingIconData,
    showLeading: showLeading,
    trailing: trailing,
    trailingIconData: trailingIconData,
    onTap: onTap,
    onTapSemanticsHint: onTapSemanticsHint,
    isDismissable: isDismissable,
    onDismissed: onDismissed,
    style: style,
    semanticLabel: semanticLabel,
  );

  /// Creates a warning notification box.
  ///
  /// The default leading icon is [SBBIcons.circle_exclamation_point_small].
  factory SBBNotificationBox.warning({
    Key? key,
    Widget? content,
    String? contentText,
    SBBNotificationBoxController? controller,
    Widget? title,
    String? titleText,
    Widget? leading,
    IconData? leadingIconData,
    bool showLeading = true,
    Widget? trailing,
    IconData? trailingIconData,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    bool isDismissable = true,
    GestureTapCallback? onDismissed,
    SBBNotificationBoxStyle? style,
    String? semanticLabel,
  }) => SBBNotificationBox(
    key: key,
    state: .warning,
    content: content,
    contentText: contentText,
    controller: controller,
    title: title,
    titleText: titleText,
    leading: leading,
    leadingIconData: leadingIconData,
    showLeading: showLeading,
    trailing: trailing,
    trailingIconData: trailingIconData,
    onTap: onTap,
    onTapSemanticsHint: onTapSemanticsHint,
    isDismissable: isDismissable,
    onDismissed: onDismissed,
    style: style,
    semanticLabel: semanticLabel,
  );

  /// Creates a success notification box.
  ///
  /// The default leading icon is [SBBIcons.circle_tick_small].
  factory SBBNotificationBox.success({
    Key? key,
    Widget? content,
    String? contentText,
    SBBNotificationBoxController? controller,
    Widget? title,
    String? titleText,
    Widget? leading,
    IconData? leadingIconData,
    bool showLeading = true,
    Widget? trailing,
    IconData? trailingIconData,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    bool isDismissable = true,
    GestureTapCallback? onDismissed,
    SBBNotificationBoxStyle? style,
    String? semanticLabel,
  }) => SBBNotificationBox(
    key: key,
    state: .success,
    content: content,
    contentText: contentText,
    controller: controller,
    title: title,
    titleText: titleText,
    leading: leading,
    leadingIconData: leadingIconData,
    showLeading: showLeading,
    trailing: trailing,
    trailingIconData: trailingIconData,
    onTap: onTap,
    onTapSemanticsHint: onTapSemanticsHint,
    isDismissable: isDismissable,
    onDismissed: onDismissed,
    style: style,
    semanticLabel: semanticLabel,
  );

  /// Creates an information notification box.
  ///
  /// The default leading icon is [SBBIcons.circle_information_small].
  factory SBBNotificationBox.information({
    Key? key,
    Widget? content,
    String? contentText,
    SBBNotificationBoxController? controller,
    Widget? title,
    String? titleText,
    Widget? leading,
    IconData? leadingIconData,
    bool showLeading = true,
    Widget? trailing,
    IconData? trailingIconData,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    bool isDismissable = true,
    GestureTapCallback? onDismissed,
    SBBNotificationBoxStyle? style,
    String? semanticLabel,
  }) => SBBNotificationBox(
    key: key,
    state: .information,
    content: content,
    contentText: contentText,
    controller: controller,
    title: title,
    titleText: titleText,
    leading: leading,
    leadingIconData: leadingIconData,
    showLeading: showLeading,
    trailing: trailing,
    trailingIconData: trailingIconData,
    onTap: onTap,
    onTapSemanticsHint: onTapSemanticsHint,
    isDismissable: isDismissable,
    onDismissed: onDismissed,
    style: style,
    semanticLabel: semanticLabel,
  );

  /// Defines which notification variant is shown.
  final SBBNotificationBoxState state;

  /// An optional controller to programmatically show and hide the [SBBNotificationBox].
  ///
  /// If not provided, an internal controller is created automatically.
  final SBBNotificationBoxController? controller;

  /// A custom widget displayed as the content.
  ///
  /// For simple text content, use [contentText] instead.
  ///
  /// Cannot be used together with [contentText].
  final Widget? content;

  /// Text displayed as content of the notification box.
  ///
  /// Cannot be used together with [content].
  final String? contentText;

  /// A custom widget displayed as the notification title.
  ///
  /// For simple text titles, use [titleText] instead.
  ///
  /// Cannot be used together with [titleText].
  final Widget? title;

  /// Text displayed as title of the notification box.
  ///
  /// Cannot be used together with [title].
  final String? titleText;

  /// A custom widget displayed in the leading position.
  ///
  /// For simple icon changes, use [leadingIconData] instead.
  /// If this and [leadingIconData] is null, [SBBNotificationBoxStyle.leadingIconData] is used.
  ///
  /// Can be hidden by using [showLeading].
  ///
  /// Cannot be used together with [leadingIconData].
  final Widget? leading;

  /// Icon to display in the leading position.
  /// If this and [leading] is null, [SBBNotificationBoxStyle.leadingIconData] is used.
  ///
  /// Can be hidden by using [showLeading].
  ///
  /// Cannot be used together with [leading].
  final IconData? leadingIconData;

  /// Whether the [leading] or [leadingIconData] is shown.
  final bool showLeading;

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

  /// The semantic hint used if the notification box is tappable. See [onTap].
  final String? onTapSemanticsHint;

  /// Callback when the user taps the notification box except on the dismiss button.
  final GestureTapCallback? onTap;

  /// If true, an inline [InkWell] close button is displayed in the title row.
  /// Tapping it will hide the promotion box via the [SBBNotificationBoxController]
  /// and invoke [onDismissed].
  final bool isDismissable;

  /// Callback invoked once the user taps the dismiss button.
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

  @override
  State<SBBNotificationBox> createState() => _SBBNotificationBoxState();
}

class _SBBNotificationBoxState extends State<SBBNotificationBox> with SingleTickerProviderStateMixin {
  SBBNotificationBoxController? _internalController;

  SBBNotificationBoxController get _effectiveController =>
      widget.controller ?? (_internalController ??= SBBNotificationBoxController());

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
      final oldValue = (oldWidget.controller ?? _internalController)?.value;

      oldWidget.controller?.removeListener(_animate);
      _internalController?.dispose();
      _internalController = null;

      _effectiveController.addListener(_animate);

      if (oldValue != _effectiveController.value) _animate();
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_animate);
    _animationController.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasSBBBaseStyle(context));

    final themedStyle = _getThemedStyle(context)!;
    final effectiveStyle = themedStyle.merge(widget.style);

    final content = addDefaultAncestorWithResolved(
      foregroundColor: effectiveStyle.foregroundColor,
      child: _hasTitle ? _defaultLayout(effectiveStyle) : _titlelessLayout(effectiveStyle),
    )!;

    return Semantics(
      container: true,
      label: widget.semanticLabel,
      excludeSemantics: widget.semanticLabel != null,
      child: _animationBuilder(
        animation: _animationController,
        child: _tappableBackground(style: effectiveStyle, child: content),
      ),
    );
  }

  Material _tappableBackground({
    required SBBNotificationBoxStyle style,
    required Widget child,
  }) {
    return Material(
      color: SBBColors.transparent,
      child: Semantics(
        onTapHint: widget.onTap != null ? widget.onTapSemanticsHint : null,
        child: InkWell(
          overlayColor: style.overlayColor,
          borderRadius: SBBNotificationBoxStyle.outerBorderRadius,
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: style.borderColor!,
                  width: SBBNotificationBoxStyle.leftBorderWidth,
                ),
              ),
              borderRadius: SBBNotificationBoxStyle.outerBorderRadius,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: style.borderColor!),
                borderRadius: SBBNotificationBoxStyle.innerBorderRadius,
                color: style.backgroundColor,
              ),
              padding: style.padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Widget _titlelessLayout(SBBNotificationBoxStyle effectiveStyle) {
    final resolvedTrailing = _resolveTrailing();
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: .start,
        spacing: SBBSpacing.xSmall,
        children: [
          ?_resolveLeading(effectiveStyle),
          Expanded(child: _resolveContent(effectiveStyle)),
          if (resolvedTrailing != null || widget.isDismissable)
            Column(
              children: [
                ?_dismissButton(context, effectiveStyle),
                if (resolvedTrailing != null)
                  Expanded(
                    child: Center(child: resolvedTrailing),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _defaultLayout(SBBNotificationBoxStyle effectiveStyle) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: SBBSpacing.xSmall,
      children: [
        Row(
          spacing: SBBSpacing.xSmall,
          children: [
            ?_resolveLeading(effectiveStyle),
            Expanded(child: _resolveTitle(effectiveStyle)!),
            ?_dismissButton(context, effectiveStyle),
          ],
        ),
        Row(
          children: [
            Expanded(child: _resolveContent(effectiveStyle)),
            ?_resolveTrailing(),
          ],
        ),
      ],
    );
  }

  Widget? _resolveLeading(SBBNotificationBoxStyle effectiveStyle) {
    if (widget.showLeading == false) return null;

    return addDefaultAncestorWithResolved(
      foregroundColor: effectiveStyle.iconColor,
      child: widget.leading ?? Icon(widget.leadingIconData ?? effectiveStyle.leadingIconData),
    )!;
  }

  Widget? _resolveTitle(SBBNotificationBoxStyle effectiveStyle) {
    var title = widget.title;
    if (widget.titleText != null) {
      title = Text(widget.titleText!);
    }

    return addDefaultAncestorWithResolved(
      foregroundColor: effectiveStyle.foregroundColor,
      textStyle: effectiveStyle.titleTextStyle,
      child: title,
    );
  }

  Widget _resolveContent(SBBNotificationBoxStyle effectiveStyle) {
    var content = widget.content;
    if (widget.contentText != null) {
      content = Text(
        widget.contentText!,
        maxLines: effectiveStyle.contentMaxLines,
        overflow: TextOverflow.ellipsis,
      );
    }

    return addDefaultAncestorWithResolved(
      foregroundColor: effectiveStyle.foregroundColor,
      textStyle: effectiveStyle.contentTextStyle,
      child: content,
    )!;
  }

  Widget? _resolveTrailing() {
    if (widget.trailingIconData != null) return Icon(widget.trailingIconData);
    return widget.trailing;
  }

  Widget? _dismissButton(BuildContext context, SBBNotificationBoxStyle effectiveStyle) {
    if (!widget.isDismissable) return null;

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
          child: Icon(
            SBBIcons.cross_tiny_small,
            size: sbbIconSizeSmall,
            color: effectiveStyle.dismissButtonForegroundColor,
          ),
        ),
      ),
    );
  }

  Widget _animationBuilder({required Animation<double> animation, required Widget child}) {
    return SizeTransition(
      alignment: Alignment(-1.0, -1.0),
      sizeFactor: animation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  SBBNotificationBoxStyle? _getThemedStyle(BuildContext context) {
    final theme = Theme.of(context).sbbNotificationBoxTheme;
    return switch (widget.state) {
      .alert => theme?.alert,
      .warning => theme?.warning,
      .success => theme?.success,
      .information => theme?.information,
    };
  }

  void _animate() => _animationController.animateTo(_effectiveController.value ? 1.0 : 0.0);

  bool get _hasTitle => widget.title != null || widget.titleText != null;
}
