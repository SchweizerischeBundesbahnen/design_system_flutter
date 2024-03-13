import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

const _kDefaultInteractionIcon = SBBIcons.arrows_circle_small;

const _kIllustrationMaxHeight = 145.0;
const _kTextBoxSpacing = 24.0;

enum MessageIllustration {
  Man('man.png'),
  Woman('woman.png'),
  Display('display.png');

  const MessageIllustration(this.fileName);

  final String fileName;

  static String parent = 'lib/assets/illustrations';
  static String package = 'design_system_flutter';

  AssetImage asset(Brightness brightness) {
    final path = '$parent/${brightness.name}/$fileName';
    return AssetImage(path, package: package);
  }
}

/// The SBB Message. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system/mobile/components/message>
class SBBMessage extends StatelessWidget {
  const SBBMessage({
    required this.title,
    required this.description,
    this.illustration = MessageIllustration.Woman,
    this.isLoading = false,
    this.messageCode,
    this.onInteraction,
    this.interactionIcon = _kDefaultInteractionIcon,
    this.customIllustration,
  });

  const SBBMessage.error({
    required this.title,
    required this.description,
    this.illustration = MessageIllustration.Display,
    this.isLoading = false,
    this.messageCode,
    this.onInteraction,
    this.interactionIcon = _kDefaultInteractionIcon,
    this.customIllustration,
  });

  final String title;
  final String description;

  /// Enum with illustrations provided by the library
  final MessageIllustration illustration;

  /// If set, is shown below the description. For example: 'Error-Code: XYZ-9999'
  final String? messageCode;

  /// if [isLoading] is true, a loading indicator is shown at the position of the interaction button.
  final bool isLoading;

  /// Illustration shown above title of message
  /// if [customIllustration] is null, default illustrations will be used.
  final Widget? customIllustration;

  /// Callback for interaction with button.
  /// if [onInteraction] is null, no button will be shown.
  final VoidCallback? onInteraction;

  final IconData interactionIcon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading) _loadingIndicator(context),
          if (!isLoading) customIllustration ?? _defaultIllustration(context),
          SizedBox(height: _kTextBoxSpacing),
          _title(textTheme),
          SizedBox(height: sbbDefaultSpacing),
          _description(textTheme),
          if (messageCode != null) ...[
            SizedBox(height: sbbDefaultSpacing),
            _errorCode(textTheme),
          ],
          if (_showInteractionButton) ...[
            SizedBox(height: _kTextBoxSpacing),
            _interactionButton(),
          ],
        ],
      ),
    );
  }

  SBBLoadingIndicator _loadingIndicator(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return isDarkTheme
        ? SBBLoadingIndicator.mediumCloud()
        : SBBLoadingIndicator.medium();
  }

  Text _title(TextTheme textTheme) => Text(
        title,
        style: textTheme.bodyMedium,
        textAlign: TextAlign.center,
      );

  Text _description(TextTheme textTheme) => Text(
        description,
        style: textTheme.labelSmall,
        textAlign: TextAlign.center,
      );

  Text _errorCode(TextTheme textTheme) => Text(
        messageCode!,
        style: textTheme.labelSmall?.copyWith(fontSize: 12.0),
        textAlign: TextAlign.center,
      );

  SBBIconButtonLarge _interactionButton() => SBBIconButtonLarge(
        icon: interactionIcon,
        onPressed: onInteraction,
      );

  Widget _defaultIllustration(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      constraints: BoxConstraints(maxHeight: _kIllustrationMaxHeight),
      child: Image(image: illustration.asset(brightness)),
    );
  }

  bool get _showInteractionButton => onInteraction != null && !isLoading;
}
