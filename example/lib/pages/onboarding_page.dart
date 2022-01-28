import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: ThemeModeSegmentedButton(),
        ),
        SBBTertiaryButtonLarge(
          label: 'Show Onboarding',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => _OnboardingPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final builderDelegate = DemoOnboardingBuilderDelegate();
    return Scaffold(
      appBar: _PreferredSizeWidget(),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            return builderDelegate.onPop();
          },
          child: SBBOnboarding(
            builderDelegate: builderDelegate,
            onFinish: () => Navigator.of(context).pop(),
            forwardSemanticsLabel: 'Next page',
            backSemanticsLabel: 'Previous page',
            cancelLabel: 'Cancel Onboarding',
          ),
        ),
      ),
    );
  }
}

class _PreferredSizeWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var sbbTheme = SBBTheme.of(context);
    return Container(
      height: sbbTheme.statusBarHeight,
      color: sbbTheme.headerBackgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(24.0);
}

class DemoOnboardingBuilderDelegate extends SBBOnboardingBuilderDelegate {
  late Future<bool> Function() onPop;

  @override
  Widget buildStartPage(BuildContext context, double widgetWidth, double widgetHeight, VoidCallback onStartOnboarding, VoidCallback onFinish) {
    final sbbTheme = SBBTheme.of(context);
    return Container(
      width: widgetWidth,
      height: widgetHeight,
      color: sbbTheme.headerBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(
          sbbTheme.defaultRootContainerPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'Welcome to the Onboarding',
              style: SBBTextStyles.extraLargeLight.copyWith(
                color: sbbTheme.headerTextStyle.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 67),
            SBBPrimaryButtonNegative(
              label: 'Start Onboarding',
              onPressed: onStartOnboarding,
            ),
            const SizedBox(height: sbbDefaultSpacing),
            SBBPrimaryButton(
              label: 'Skip Onboarding',
              onPressed: onFinish,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildEndPage(BuildContext context, double widgetWidth, double widgetHeight, VoidCallback onFinish) {
    final sbbTheme = SBBTheme.of(context);
    return Container(
      width: widgetWidth,
      height: widgetHeight,
      color: sbbTheme.headerBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(
          sbbTheme.defaultRootContainerPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'Thank you! Bye Bye!',
              style: SBBTextStyles.extraLargeLight.copyWith(
                color: sbbTheme.headerTextStyle.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 67),
            SBBPrimaryButtonNegative(
              label: 'Close Onboarding',
              onPressed: onFinish,
            ),
          ],
        ),
      ),
    );
  }

  @override
  List<SBBOnboardingCard> buildCards(BuildContext context) => [
        SBBOnboardingCard.basic(
          embeddedChild: Container(
            color: SBBTheme.of(context).backgroundColor,
            child: Center(
              child: Text(
                'Page 1',
                style: SBBTextStyles.extraLargeLight,
              ),
            ),
          ),
          title: 'Page 1',
          content: 'Page 1',
        ),
        SBBOnboardingCard.basic(
          embeddedChild: Container(
            color: SBBTheme.of(context).backgroundColor,
            child: Center(
              child: Text(
                'Page 2',
                style: SBBTextStyles.extraLargeLight,
              ),
            ),
          ),
          title: 'Page 2',
          content: 'Page 2',
        ),
        SBBOnboardingCard.basic(
          embeddedChild: Container(
            color: SBBTheme.of(context).backgroundColor,
            child: Center(
              child: Text(
                'Page 3',
                style: SBBTextStyles.extraLargeLight,
              ),
            ),
          ),
          title: 'Page 3',
          content: 'Page 3',
        ),
        SBBOnboardingCard.basic(
          embeddedChild: Container(
            color: SBBTheme.of(context).backgroundColor,
            child: Center(
              child: Text(
                'Page 4',
                style: SBBTextStyles.extraLargeLight,
              ),
            ),
          ),
          title: 'Page 4',
          content: 'Page 4',
        ),
        SBBOnboardingCard.basic(
          embeddedChild: Container(
            color: SBBTheme.of(context).backgroundColor,
            child: Center(
              child: Text(
                'Page 5',
                style: SBBTextStyles.extraLargeLight,
              ),
            ),
          ),
          title: 'Page 5',
          content: 'Page 5',
        ),
        SBBOnboardingCard.basic(
          embeddedChild: Container(
            color: SBBTheme.of(context).backgroundColor,
            child: Center(
              child: Text(
                'Page 6',
                style: SBBTextStyles.extraLargeLight,
              ),
            ),
          ),
          title: 'Page 6',
          content: 'Page 6',
        ),
      ];

  @override
  void setPopCallback(Future<bool> Function() callback) => onPop = callback;
}
