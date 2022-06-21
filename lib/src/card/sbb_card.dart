import '../../design_system_flutter.dart';
import 'package:flutter/material.dart';

class SBBCard extends StatefulWidget {
  const SBBCard(
      {Key? key,
      this.title,
      required this.body,
      this.backgroundColor,
      this.borderColor,
      this.onTap})
      : this.width = null,
        this.height = null,
        this.icon = null,
        this.head = null,
        super(key: key);

  const SBBCard.sized(
      {Key? key,
      required this.width,
      required this.height,
      this.title,
      this.icon,
      this.head,
      required this.body,
      this.backgroundColor,
      this.borderColor,
      this.onTap})
      : super(key: key);

  const SBBCard.icon(
      {Key? key,
      this.title,
      required this.icon,
      required this.body,
      this.backgroundColor,
      this.borderColor,
      this.onTap})
      : this.width = null,
        this.height = null,
        this.head = null,
        super(key: key);

  const SBBCard.image(
      {Key? key,
      this.title,
      required this.head,
      required this.body,
      this.backgroundColor,
      this.borderColor,
      this.onTap})
      : this.width = null,
        this.height = null,
        this.icon = null,
        super(key: key);

  final String? title;
  final IconData? icon;
  final Widget? head;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget body;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  @override
  State<SBBCard> createState() => _SBBCardState();
}

class _SBBCardState extends State<SBBCard> {
  double scale = 1.0;

  void _changeScale(isHovering) {
    if (isHovering) {
      setState(() {
        scale = 1.02;
      });
    } else {
      setState(() {
        scale = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: SBBColors.transparent,
        highlightColor: SBBColors.transparent,
        overlayColor: SBBThemeData.allStates(SBBColors.transparent),
        onHover: (hovering) {
          setState(() => _changeScale(hovering));
        },
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: widget.backgroundColor ?? SBBColors.white,
                border: Border.all(
                    color: widget.borderColor ?? SBBColors.graphite)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.head != null) _buildHead(),
                if (widget.icon != null) _buildIcon(),
                _buildBody()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHead() {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        child: widget.head!);
  }

  Widget _buildIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(child: Icon(widget.icon, size: 36)),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: (widget.height != null && widget.width != null)
          ? Container(
              width: widget.width,
              height: widget.height,
              child: _buildBodyContent())
          : _buildBodyContent(),
    );
  }

  Column _buildBodyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              widget.title!,
              style:
                  SBBWebTextStyles.medium.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        widget.body
      ],
    );
  }
}
