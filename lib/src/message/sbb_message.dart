import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const _kDefaultInteractionIcon = SBBIcons.arrows_circle_small;

const _kIllustrationMaxHeight = 145.0;
const _kTextBoxSpacing = 24.0;

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

/// The SBB Message. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system/mobile/components/message>
class SBBMessage extends StatelessWidget {
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

  const SBBMessage.error({
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

  final String title;
  final String description;

  /// Enum with illustrations provided by the library
  final MessageIllustration? illustration;

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
          if (_showIllustration) ...[
            if (isLoading) _loadingIndicator(context),
            if (!isLoading) customIllustration ?? _defaultIllustration(context),
            const SizedBox(height: _kTextBoxSpacing),
          ],
          _title(textTheme),
          const SizedBox(height: sbbDefaultSpacing),
          _description(textTheme),
          if (messageCode != null) ...[
            const SizedBox(height: sbbDefaultSpacing),
            _errorCode(textTheme),
          ],
          if (_showInteractionButton) ...[
            const SizedBox(height: _kTextBoxSpacing),
            _interactionButton(),
          ],
        ],
      ),
    );
  }

  SBBLoadingIndicator _loadingIndicator(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return isDarkTheme ? const SBBLoadingIndicator.mediumCloud() : const SBBLoadingIndicator.medium();
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
      constraints: const BoxConstraints(maxHeight: _kIllustrationMaxHeight),
      child: Image(image: illustration!.asset(brightness)),
    );
  }

  bool get _showInteractionButton => onInteraction != null && !isLoading;

  bool get _showIllustration => isLoading || illustration != null || customIllustration != null;
}
