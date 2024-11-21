import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class SBBOnboardingCard extends StatelessWidget {
  const SBBOnboardingCard({
    super.key,
    required this.widgetBuilder,
    this.onDismissed,
  });

  SBBOnboardingCard.basic({
    required String title,
    required String content,
    VoidCallback? onDismissed,
    Key? key,
  }) : this.extended(
          title: title,
          content: content,
          customContent: null,
          onDismissed: onDismissed,
          key: key,
        );

  SBBOnboardingCard.extended({
    required String title,
    required String content,
    Widget? embeddedChild,
    Widget? customContent,
    VoidCallback? onDismissed,
    Key? key,
  }) : this(
          key: key,
          onDismissed: onDismissed,
          widgetBuilder: (BuildContext context, Orientation orientation) {
            switch (orientation) {
              case Orientation.portrait:
                return _VerticalCard(
                  embeddedChild: embeddedChild,
                  title: title,
                  content: content,
                  customContent: customContent,
                );
              case Orientation.landscape:
                return _HorizontalCard(
                  embeddedChild: embeddedChild,
                  title: title,
                  content: content,
                  customContent: customContent,
                );
            }
          },
        );

  final OrientationWidgetBuilder widgetBuilder;
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) => widgetBuilder(
        context,
        MediaQuery.of(context).orientation,
      );
}

class _VerticalCard extends StatelessWidget {
  const _VerticalCard({
    required this.title,
    required this.content,
    this.embeddedChild,
    this.customContent,
  });

  final String title;
  final String content;
  final Widget? embeddedChild;
  final Widget? customContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: embeddedChild,
          ),
        ),
        const SizedBox(height: 16.0),
        MergeSemantics(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title,
                  style: SBBTextStyles.largeBold.copyWith(
                    height: 22.0 / 18.0,
                    color: SBBBaseStyle.of(context).themeValue(
                      SBBColors.black,
                      SBBColors.white,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  content,
                  style: SBBTextStyles.mediumLight.copyWith(
                    color: SBBBaseStyle.of(context).themeValue(
                      SBBColors.black,
                      SBBColors.white,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        if (customContent != null) customContent!,
      ],
    );
  }
}

class _HorizontalCard extends StatelessWidget {
  const _HorizontalCard({
    required this.title,
    required this.content,
    this.embeddedChild,
    this.customContent,
  });

  final String title;
  final String content;
  final Widget? embeddedChild;
  final Widget? customContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (embeddedChild != null)
          Flexible(
            child: embeddedChild!,
          ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MergeSemantics(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        title,
                        style: SBBTextStyles.largeBold.copyWith(
                          height: 22.0 / 18.0,
                          color: SBBBaseStyle.of(context).themeValue(
                            SBBColors.black,
                            SBBColors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        content,
                        style: SBBTextStyles.mediumLight.copyWith(
                          color: SBBBaseStyle.of(context).themeValue(
                            SBBColors.black,
                            SBBColors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              if (customContent != null) customContent!,
            ],
          ),
        ),
      ],
    );
  }
}
