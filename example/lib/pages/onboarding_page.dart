import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../native_app.dart';

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
      body: PopScope(
        onPopInvoked: (didPop) => builderDelegate.onPop(),
        child: SBBOnboarding(
          builderDelegate: builderDelegate,
          onFinish: () => Navigator.of(context).pop(),
          forwardSemanticsLabel: 'Next page',
          backSemanticsLabel: 'Previous page',
          cancelLabel: 'Cancel Onboarding',
        ),
      ),
    );
  }
}

class _PreferredSizeWidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: statusBarHeight,
      color: style.headerBackgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(24.0);
}

class DemoOnboardingBuilderDelegate extends SBBOnboardingBuilderDelegate {
  late Future<bool> Function() onPop;

  @override
  Widget buildStartPage(
    BuildContext context,
    VoidCallback onStartOnboarding,
    VoidCallback onFinish,
  ) {
    final orientation = MediaQuery.of(context).orientation;
    switch (orientation) {
      case Orientation.portrait:
        return _VerticalStartPage(
          onStartOnboarding: onStartOnboarding,
          onFinish: onFinish,
        );
      case Orientation.landscape:
        return _HorizontalStartPage(
          onStartOnboarding: onStartOnboarding,
          onFinish: onFinish,
        );
    }
  }

  @override
  Widget buildEndPage(
    BuildContext context,
    VoidCallback onFinish,
  ) {
    final orientation = MediaQuery.of(context).orientation;
    switch (orientation) {
      case Orientation.portrait:
        return _VerticalEndPage(
          onFinish: onFinish,
        );
      case Orientation.landscape:
        return _HorizontalEndPage(
          onFinish: onFinish,
        );
    }
  }

  @override
  List<SBBOnboardingCard> buildCards(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    return [
      SBBOnboardingCard.extended(
        embeddedChild: Container(
          color: style.backgroundColor,
          child: Center(
            child: Text(
              'Page 1',
              style: SBBTextStyles.extraLargeLight,
            ),
          ),
        ),
        title: 'Page 1',
        content: 'Page 1',
        customContent: Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBSecondaryButton(
            label: 'Custom Action',
            onPressed: () {},
          ),
        ),
      ),
      SBBOnboardingCard.extended(
        embeddedChild: _IllustrationWidget(),
        title: 'Page 2',
        content: 'Page 2',
        customContent: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: SBBSecondaryButton(
            label: 'Testbutton',
            onPressed: () {},
          ),
        ),
      ),
      SBBOnboardingCard.basic(
        title: 'Page 3',
        content: 'Page 3',
      ),
      SBBOnboardingCard.basic(
        title: 'Page 4',
        content: 'Page 4',
      ),
      SBBOnboardingCard.basic(
        title: 'Page 5',
        content: 'Page 5',
      ),
      SBBOnboardingCard.basic(
        title: 'Page 6',
        content: 'Page 6',
      ),
    ];
  }

  @override
  void setPopCallback(Future<bool> Function() callback) => onPop = callback;
}

class _VerticalEndPage extends StatelessWidget {
  const _VerticalEndPage({
    required this.onFinish,
    Key? key,
  }) : super(key: key);

  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final controlStyle = SBBControlStyles.of(context);
    return Container(
      color: controlStyle.headerBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(
          style.defaultRootContainerPadding!,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'Thank you! Bye Bye!',
              style: SBBTextStyles.extraLargeLight.copyWith(
                color: controlStyle.headerTextStyle!.color,
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
}

class _HorizontalEndPage extends StatelessWidget {
  const _HorizontalEndPage({
    required this.onFinish,
    Key? key,
  }) : super(key: key);

  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final controlStyle = SBBControlStyles.of(context);
    return Container(
      color: controlStyle.headerBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(
          style.defaultRootContainerPadding!,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Thank you! Bye Bye!',
                    style: SBBTextStyles.extraLargeLight.copyWith(
                      color: controlStyle.headerTextStyle!.color,
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
          ],
        ),
      ),
    );
  }
}

class _VerticalStartPage extends StatelessWidget {
  const _VerticalStartPage({
    required this.onStartOnboarding,
    required this.onFinish,
    Key? key,
  }) : super(key: key);

  final VoidCallback onStartOnboarding;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final controlStyle = SBBControlStyles.of(context);
    return Container(
      color: controlStyle.headerBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(
          style.defaultRootContainerPadding!,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'Welcome to the Onboarding',
              style: SBBTextStyles.extraLargeLight.copyWith(
                color: controlStyle.headerTextStyle!.color,
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
}

class _HorizontalStartPage extends StatelessWidget {
  const _HorizontalStartPage({
    required this.onStartOnboarding,
    required this.onFinish,
    Key? key,
  }) : super(key: key);

  final VoidCallback onStartOnboarding;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final controlStyle = SBBControlStyles.of(context);
    return Container(
      color: controlStyle.headerBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(
          style.defaultRootContainerPadding!,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to the Onboarding',
                    style: SBBTextStyles.extraLargeLight.copyWith(
                      color: controlStyle.headerTextStyle!.color,
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
          ],
        ),
      ),
    );
  }
}

class _IllustrationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.orientation == Orientation.portrait
        ? 200
        : mediaQuery.size.height;
    return SizedBox(
      height: height,
      child: SvgPicture.asset(
        'assets/images/szene-2.svg',
        fit: BoxFit.cover,
        excludeFromSemantics: true,
      ),
    );
  }
}
