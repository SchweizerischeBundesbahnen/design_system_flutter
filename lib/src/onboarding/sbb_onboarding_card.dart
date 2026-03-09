import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

@Deprecated(
  'SBBOnboarding is deprecated since it is no component in the official Design System. Will be removed in v5.',
)
class SBBOnboardingCard extends StatelessWidget {
  const SBBOnboardingCard({super.key, required this.widgetBuilder, this.onDismissed});

  SBBOnboardingCard.basic({required String title, required String content, VoidCallback? onDismissed, Key? key})
    : this.extended(title: title, content: content, customContent: null, onDismissed: onDismissed, key: key);

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
         widgetBuilder: (context, orientation) {
           switch (orientation) {
             case .portrait:
               return _VerticalCard(
                 embeddedChild: embeddedChild,
                 title: title,
                 content: content,
                 customContent: customContent,
               );
             case .landscape:
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
  Widget build(BuildContext context) => widgetBuilder(context, MediaQuery.of(context).orientation);
}

class _VerticalCard extends StatelessWidget {
  const _VerticalCard({required this.title, required this.content, this.embeddedChild, this.customContent});

  final String title;
  final String content;
  final Widget? embeddedChild;
  final Widget? customContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(height: 200, width: .infinity, child: embeddedChild),
        ),
        const SizedBox(height: 16.0),
        MergeSemantics(
          child: Column(
            children: [
              Padding(
                padding: const .symmetric(horizontal: 16.0),
                child: Text(
                  title,
                  style: SBBTextStyles.largeBold.copyWith(
                    height: 22.0 / 18.0,
                    color: SBBBaseStyle.of(context).themeValue(SBBColors.black, SBBColors.white),
                  ),
                  textAlign: .center,
                ),
              ),
              Padding(
                padding: const .all(16.0),
                child: Text(
                  content,
                  style: SBBTextStyles.mediumLight.copyWith(
                    color: SBBBaseStyle.of(context).themeValue(SBBColors.black, SBBColors.white),
                  ),
                  textAlign: .center,
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
  const _HorizontalCard({required this.title, required this.content, this.embeddedChild, this.customContent});

  final String title;
  final String content;
  final Widget? embeddedChild;
  final Widget? customContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (embeddedChild != null) Flexible(child: embeddedChild!),
        Flexible(
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .stretch,
            children: [
              MergeSemantics(
                child: Column(
                  children: [
                    Padding(
                      padding: const .symmetric(horizontal: 16.0),
                      child: Text(
                        title,
                        style: SBBTextStyles.largeBold.copyWith(
                          height: 22.0 / 18.0,
                          color: SBBBaseStyle.of(context).themeValue(SBBColors.black, SBBColors.white),
                        ),
                        textAlign: .center,
                      ),
                    ),
                    Padding(
                      padding: const .all(16.0),
                      child: Text(
                        content,
                        style: SBBTextStyles.mediumLight.copyWith(
                          color: SBBBaseStyle.of(context).themeValue(SBBColors.black, SBBColors.white),
                        ),
                        textAlign: .center,
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
