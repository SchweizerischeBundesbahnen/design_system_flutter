import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const _kDefaultInteractionIcon = SBBIcons.arrows_circle_small;

const _illustrationMaxHeight = 145.0;
const _messageSpacing = 24.0;

/// The illustrations that ship with this package.
///
/// The [Display] is typically used for error messages.
enum MessageIllustration {
  // ignore: constant_identifier_names
  Man('man.png'),
  // ignore: constant_identifier_names
  Woman('woman.png'),
  // ignore: constant_identifier_names
  Display('display.png');

  const MessageIllustration(this.fileName);

  final String fileName;

  static String parent = 'lib/assets/illustrations';
  static String package = 'sbb_design_system_mobile';

  AssetImage asset(Brightness brightness) {
    final path = '$parent/${brightness.name}/$fileName';
    return AssetImage(path, package: package);
  }
}

/// The SBB Message. This widget allows displaying messages to the user, e.g. for Error messages.
///
///
/// See also:
///
/// * <https://digital.sbb.ch/en/design-system/mobile/components/message/>
class SBBMessage extends StatelessWidget {
  /// Use the required [title] and [description] to display a message to the user.
  ///
  /// If [illustration] and [customIllustration] is null, will not display anything above the [title], unless
  /// [isLoading] is true.
  ///
  /// The [messageCode] is typically used only within an error message. See [SBBMessage.error].
  const SBBMessage({
    super.key,
    required this.title,
    required this.description,
    this.illustration,
    this.isLoading = false,
    this.messageCode,
    this.onInteraction,
    this.interactionIcon = _kDefaultInteractionIcon,
    this.customIllustration,
  });

  /// Used to display an error in form of a [SBBMessage] to the user.
  ///
  /// The [illustration] will default to [MessageIllustration.Display].
  const SBBMessage.error({
    super.key,
    required this.title,
    required this.description,
    this.illustration = MessageIllustration.Display,
    this.isLoading = false,
    this.messageCode,
    this.onInteraction,
    this.interactionIcon = _kDefaultInteractionIcon,
    this.customIllustration,
  });

  /// The title of the message displayed directly below the [illustration] or [customIllustration].
  final String title;

  /// The body of the message. Used to give a longer explanation of what has happened.
  final String description;

  /// Enum with illustrations provided by the library.
  ///
  /// See [MessageIllustration] for explanation.
  ///
  /// The illustration image is excluded from semantics.
  final MessageIllustration? illustration;

  /// Optional text displayed below the [description]. Usually depicts an error code.
  ///
  /// This text is excluded from semantics.
  ///
  /// Example: 'Error-Code: XYZ-9999'
  final String? messageCode;

  /// If [isLoading] is true, a [SBBLoadingIndicator] is shown instead of the [illustration] or [customIllustration].
  ///
  /// Defaults to false.
  final bool isLoading;

  /// Used to display a complete custom illustration instead of [illustration].
  ///
  /// If is null and [illustration] is non null, displays [illustration].
  ///
  /// Overriden by [isLoading] to show a [SBBLoadingIndicator].
  final Widget? customIllustration;

  /// Callback for interaction with a [SBBIconButtonLarge] at the bottom of the message.
  ///
  /// If null, no button will be shown.
  final VoidCallback? onInteraction;

  /// Allows the customization of the icon displayed in the [SBBIconButtonLarge] displayed at the bottom of the message.
  ///
  /// Defaults to [SBBIcons.arrows_circle_small]
  final IconData interactionIcon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_showLeading) ...[
            if (isLoading) _loadingIndicator(context),
            if (!isLoading) customIllustration ?? _illustration(context),
            const SizedBox(height: _messageSpacing),
          ],
          _title(textTheme),
          const SizedBox(height: sbbDefaultSpacing),
          _description(textTheme),
          if (messageCode != null) ...[
            const SizedBox(height: sbbDefaultSpacing),
            _errorCode(textTheme),
          ],
          if (_showInteractionButton) ...[
            const SizedBox(height: _messageSpacing),
            _interactionButton(),
          ],
        ],
      ),
    );
  }

  SBBLoadingIndicator _loadingIndicator(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return isDarkTheme
        ? const SBBLoadingIndicator.mediumCloud()
        : const SBBLoadingIndicator.medium();
  }

  Text _title(TextTheme textTheme) =>
      Text(title, style: textTheme.bodyMedium, textAlign: TextAlign.center);

  Text _description(TextTheme textTheme) =>
      Text(description, style: textTheme.labelSmall, textAlign: TextAlign.center);

  Widget _errorCode(TextTheme textTheme) => ExcludeSemantics(
    child: Text(
      messageCode!,
      style: textTheme.labelSmall?.copyWith(fontSize: 12.0),
      textAlign: TextAlign.center,
    ),
  );

  SBBIconButtonLarge _interactionButton() =>
      SBBIconButtonLarge(icon: interactionIcon, onPressed: onInteraction);

  Widget _illustration(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      constraints: const BoxConstraints(maxHeight: _illustrationMaxHeight),
      child: Image(image: illustration!.asset(brightness), excludeFromSemantics: true),
    );
  }

  bool get _showInteractionButton => onInteraction != null && !isLoading;

  bool get _showLeading => isLoading || illustration != null || customIllustration != null;
}
