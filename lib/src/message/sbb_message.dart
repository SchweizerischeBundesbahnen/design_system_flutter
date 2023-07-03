import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

const _kWomanIllustration = 'woman.png';
const _kDisplayIllustration = 'display.png';
const _kMenIllustration = 'man.png';

const _kDefaultInteractionIcon = SBBIcons.arrow_circle_medium;

const _kIllustrationMaxHeight = 145.0;

enum MessageType {
  Info(_kMenIllustration),
  Hint(_kWomanIllustration),
  Warning(_kDisplayIllustration),
  Error(_kDisplayIllustration),
  Success(_kWomanIllustration);

  const MessageType(this.illustration);

  final String illustration;
}

/// The SBB Message. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system/mobile/components/message>
class SBBMessage extends StatelessWidget {
  const SBBMessage.info({
    required this.title,
    required this.description,
    this.type = MessageType.Info,
    this.isLoading = false,
    this.messageCode,
    this.onInteraction,
    this.interactionIcon = _kDefaultInteractionIcon,
    this.illustration,
  });

  const SBBMessage.hint({
    required this.title,
    required this.description,
    this.type = MessageType.Hint,
    this.isLoading = false,
    this.messageCode,
    this.onInteraction,
    this.interactionIcon = _kDefaultInteractionIcon,
    this.illustration,
  });

  const SBBMessage.warning({
    required this.title,
    required this.description,
    this.type = MessageType.Warning,
    this.isLoading = false,
    this.messageCode,
    this.onInteraction,
    this.interactionIcon = _kDefaultInteractionIcon,
    this.illustration,
  });

  const SBBMessage.error({
    required this.title,
    required this.description,
    this.type = MessageType.Error,
    this.isLoading = false,
    this.messageCode,
    this.onInteraction,
    this.interactionIcon = _kDefaultInteractionIcon,
    this.illustration,
  });

  const SBBMessage.success({
    required this.title,
    required this.description,
    this.type = MessageType.Success,
    this.isLoading = false,
    this.messageCode,
    this.onInteraction,
    this.interactionIcon = _kDefaultInteractionIcon,
    this.illustration,
  });

  final MessageType type;
  final String title;
  final String description;

  /// If set, is shown below the description. For example: 'Error code: XYZ-9999'
  final String? messageCode;

  /// if [isLoading] is true, a loading indicator is shown at the position of the interaction button.
  final bool isLoading;

  /// Illustration shown above title of message
  /// if [illustration] is null, default illustrations will be used.
  final Widget? illustration;

  /// Callback for interaction with button.
  /// if [onInteraction] is null, no button will be shown.
  final VoidCallback? onInteraction;

  final IconData interactionIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        illustration ?? _defaultIllustration(context),
        SizedBox(height: sbbDefaultSpacing * 2),
        _title(),
        SizedBox(height: sbbDefaultSpacing),
        _description(),
        if (messageCode != null)
          Padding(
            padding: const EdgeInsets.only(top: sbbDefaultSpacing),
            child: _errorCode(),
          ),
        // show spacing only, if loading indicator or interaction button is shown.
        if (isLoading || _showInteractionButton) SizedBox(height: sbbDefaultSpacing * 2),
        if (isLoading) SBBLoadingIndicator.tiny(),
        if (_showInteractionButton) _interactionButton(),
      ],
    );
  }

  Text _title() => Text(
        title,
        style: SBBTextStyles.mediumLight,
        textAlign: TextAlign.center,
      );

  Text _description() => Text(
        description,
        style: SBBTextStyles.smallLight,
        textAlign: TextAlign.center,
      );

  Text _errorCode() => Text(
        messageCode!,
        style: SBBTextStyles.smallLight.copyWith(fontSize: 12.0),
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
      child: Image.asset('packages/design_system_flutter/lib/images/${brightness.name}/${type.illustration}'),
    );
  }

  bool get _showInteractionButton => onInteraction != null && !isLoading;
}
