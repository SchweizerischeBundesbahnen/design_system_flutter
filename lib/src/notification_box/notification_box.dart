import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

import '../shared/close_button.dart';
import '../shared/tapable_element.dart';
import 'notification_box_content.dart';
import 'notification_box_title_content.dart';

part 'notification_box.type.dart';

class SBBNotificationBox extends StatefulWidget {
  const SBBNotificationBox({
    required this.type,
    required this.text,
    super.key,
    this.title,
    this.onControllerCreated,
    this.onTap,
    this.isCloseable = true,
    this.onClose,
  });

  factory SBBNotificationBox.alert({
    String? title,
    required String text,
    Function(CloseableBoxController controller)? onControllerCreated,
    GestureTapCallback? onTap,
    bool isCloseable = true,
    GestureTapCallback? onClose,
  }) =>
      SBBNotificationBox(
        type: SBBNotificationBoxType.alert,
        title: title,
        text: text,
        onControllerCreated: onControllerCreated,
        onTap: onTap,
        isCloseable: isCloseable,
        onClose: onClose,
      );

  factory SBBNotificationBox.warning({
    String? title,
    required String text,
    Function(CloseableBoxController controller)? onControllerCreated,
    GestureTapCallback? onTap,
    bool isCloseable = true,
    GestureTapCallback? onClose,
  }) =>
      SBBNotificationBox(
        type: SBBNotificationBoxType.warning,
        title: title,
        text: text,
        onControllerCreated: onControllerCreated,
        onTap: onTap,
        isCloseable: isCloseable,
        onClose: onClose,
      );

  factory SBBNotificationBox.success({
    String? title,
    required String text,
    Function(CloseableBoxController controller)? onControllerCreated,
    GestureTapCallback? onTap,
    bool isCloseable = true,
    GestureTapCallback? onClose,
  }) =>
      SBBNotificationBox(
        type: SBBNotificationBoxType.success,
        title: title,
        text: text,
        onControllerCreated: onControllerCreated,
        onTap: onTap,
        isCloseable: isCloseable,
        onClose: onClose,
      );

  factory SBBNotificationBox.information({
    String? title,
    required String text,
    Function(CloseableBoxController controller)? onControllerCreated,
    GestureTapCallback? onTap,
    bool isCloseable = true,
    GestureTapCallback? onClose,
  }) =>
      SBBNotificationBox(
        type: SBBNotificationBoxType.information,
        title: title,
        text: text,
        onControllerCreated: onControllerCreated,
        onTap: onTap,
        isCloseable: isCloseable,
        onClose: onClose,
      );

  final SBBNotificationBoxType type;
  final String? title;
  final String text;
  final Function(CloseableBoxController controller)? onControllerCreated;
  final GestureTapCallback? onTap;
  final bool isCloseable;
  final GestureTapCallback? onClose;

  @override
  State<SBBNotificationBox> createState() => _SBBNotificationBoxState();
}

class _SBBNotificationBoxState extends State<SBBNotificationBox>
    with SingleTickerProviderStateMixin {
  late CloseableBoxController _controller = CloseableBoxController(this);

  Widget _animationBuilder({
    required Animation<double> animation,
    required Widget child,
  }) {
    return SizeTransition(
      axisAlignment: -1.0,
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.onControllerCreated?.call(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = SBBBaseStyle.of(context).themeValue(
      widget.type.iconColor,
      widget.type.iconColorDark,
    );
    final icon = Icon(
      widget.type.icon,
      color: iconColor,
    );
    Widget child;
    switch (widget.title) {
      case null:
        child = SBBNotificationBoxContent(
          icon: icon,
          text: widget.text,
          isCloseable: widget.isCloseable,
        );
      default:
        child = SBBNotificationBoxTitleContent(
          icon: icon,
          title: widget.title!,
          text: widget.text,
          hasDetails: widget.onTap != null,
        );
    }
    return _animationBuilder(
      animation: _controller.animation,
      child: Stack(
        children: [
          TapableElement.roundedBox(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color: widget.type.backgroundColor, width: 8.0),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: widget.type.backgroundColor),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  color: widget.type.backgroundColor.withOpacity(.05),
                ),
                padding: const EdgeInsets.all(sbbDefaultSpacing),
                child: child,
              ),
            ),
          ),
          if (widget.isCloseable)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                child: SBBCloseButton(
                  onTap: () async {
                    await _controller.hide();
                    widget.onClose?.call();
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
