import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

/// The SBB Onboarding. Use according to documentation.
///
/// See also:
///
/// * https://digital.sbb.ch/de/design-system-mobile-new/seitentypen/onboarding
class SBBOnboarding extends StatefulWidget {
  const SBBOnboarding({
    super.key,
    required this.builderDelegate,
    required this.onFinish,
    required this.cancelLabel,
    required this.backSemanticsLabel,
    required this.forwardSemanticsLabel,
    this.blocking = false,
  });

  final SBBOnboardingBuilderDelegate builderDelegate;
  final VoidCallback onFinish;
  final String cancelLabel;
  final String backSemanticsLabel;
  final String forwardSemanticsLabel;
  final bool blocking;

  @override
  SBBOnboardingState createState() => SBBOnboardingState();
}

class SBBOnboardingState extends State<SBBOnboarding> with SingleTickerProviderStateMixin {
  static const navigationAreaVerticalPadding = 24.0;
  static const navigationAreaHeight =
      navigationAreaVerticalPadding +
      SBBInternal.defaultButtonHeight +
      sbbDefaultSpacing +
      SBBInternal.defaultButtonHeightSmall +
      navigationAreaVerticalPadding;
  static const visibleBackCardsCount = 2;

  final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  double widgetWidth = double.infinity;
  double widgetHeight = double.infinity;
  double cardWidth = double.infinity;
  double cardHeight = double.infinity;
  double parentPadding = -1;
  late EdgeInsets frontCardPadding;

  bool isShowingStartPage = true;
  bool isShowingEndPage = false;

  int currentStepIndex = 0;
  bool? goToNextStep = true;

  int dragState = 0;
  late double dragStartPosition;
  double? dragEndPosition;
  double? cardLeftValue;

  late AnimationController animationController;
  late Animation<double> animation;
  late ColorTween colorTween;

  late List<SBBOnboardingCard> _cards;

  final ScrollController scrollController = ScrollController();
  ScrollController backScrollController = ScrollController();
  bool isBackScrollControllerAnimating = false;
  bool isScrollControllerAnimating = false;

  bool get isNotDragging => dragState == 0;

  bool get isDraggingToNext => dragState == 1;

  bool get isDraggingToPrevious => dragState == 2;

  bool get isAnimating => animationController.isAnimating;

  double get animationValue => animation.value;

  double get animationValueReversed => 1 - animation.value;

  SBBBaseStyle get style => Theme.of(context).extension()!;

  SBBControlStyles get controlStyle => Theme.of(context).extension()!;

  Orientation get orientation => MediaQuery.of(context).orientation;

  bool get isBlocking => widget.blocking && !isShowingStartPage && !isShowingEndPage;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    _notifyOnboardingChanged();
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      colorTween = ColorTween(
        begin: style.themeValue(SBBColors.smoke, SBBColors.anthracite),
        end: style.themeValue(SBBColors.black, SBBColors.white),
      );
    });

    _setSize();
    animationController = AnimationController(vsync: this, duration: kThemeAnimationDuration)
      ..addListener(() {
        if (isAnimating) {
          if (backScrollController.hasClients && backScrollController.offset > 0 && !isBackScrollControllerAnimating) {
            isBackScrollControllerAnimating = true;
            backScrollController.animateTo(0, duration: kThemeAnimationDuration, curve: Curves.easeInOut);
          } else if (scrollController.hasClients && scrollController.offset > 0 && !isScrollControllerAnimating) {
            isScrollControllerAnimating = true;
            scrollController.animateTo(0, duration: kThemeAnimationDuration, curve: Curves.easeInOut);
          }
        }
        setState(() {});
      });
    animation = CurveTween(curve: Curves.easeInOut).animate(animationController);

    widget.builderDelegate.setPopCallback(_onPop);
  }

  void _setSize() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final context = globalKey.currentContext;
      if (context == null) return;

      setState(() {
        final size = context.size!;
        widgetWidth = size.width;
        widgetHeight = size.height;
        cardWidth = widgetWidth - frontCardPadding.horizontal;
        switch (orientation) {
          case Orientation.portrait:
            cardHeight = widgetHeight - navigationAreaHeight - frontCardPadding.vertical;
            break;
          case Orientation.landscape:
            cardHeight = widgetHeight - frontCardPadding.vertical;
            break;
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    switch (orientation) {
      case Orientation.portrait:
        parentPadding = style.defaultRootContainerPadding!;
        frontCardPadding = EdgeInsets.only(
          left: parentPadding,
          right: parentPadding,
          bottom: parentPadding,
          top: visibleBackCardsCount * parentPadding + parentPadding,
        );
        break;
      case Orientation.landscape:
        parentPadding = style.defaultRootContainerPadding! / 2;
        const horizontalPadding = 86.0;
        frontCardPadding = EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: parentPadding,
          top: visibleBackCardsCount * parentPadding + parentPadding,
        );
        break;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _cards = widget.builderDelegate.buildCards(context);
    final cardsCount = _cards.length;
    final List<Widget> stepIndicators = [];
    for (int i = 0; i < cardsCount; i++) {
      stepIndicators.add(buildStepIndicator(i));
    }
    final List<Widget> backCards = [];
    for (int i = 1; i < min(5, cardsCount - max(0, currentStepIndex)); i++) {
      backCards.add(buildBackCard(i));
    }

    final cardHeightCalculated = cardHeight != double.infinity;
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (n) {
        _setSize();
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              key: globalKey,
              color: style.themeValue(SBBColors.milk, SBBColors.black),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: controlStyle.headerBackgroundColor,
                        borderRadius: orientation == Orientation.portrait
                            ? const BorderRadius.vertical(bottom: Radius.circular(sbbDefaultSpacing))
                            : null,
                      ),
                      child: Padding(padding: frontCardPadding, child: Container()),
                    ),
                  ),
                  if (orientation == Orientation.portrait)
                    Semantics(
                      sortKey: const OrdinalSortKey(2),
                      child: Column(
                        children: [
                          const SizedBox(height: navigationAreaVerticalPadding),
                          Row(
                            children: <Widget>[
                              SizedBox(width: parentPadding),
                              SBBTertiaryButton(
                                semanticLabel: widget.backSemanticsLabel,
                                onPressed: () {
                                  changeStep(goToNextStep: false);
                                },
                                iconData: SBBIcons.chevron_small_left_small,
                              ),
                              const Spacer(),
                              ...stepIndicators,
                              const Spacer(),
                              SBBTertiaryButton(
                                semanticLabel: widget.forwardSemanticsLabel,
                                onPressed: () => changeStep(goToNextStep: true),
                                iconData: SBBIcons.chevron_small_right_small,
                              ),
                              SizedBox(width: parentPadding),
                            ],
                          ),
                          const SizedBox(height: sbbDefaultSpacing),
                          SizedBox(
                            height: SBBInternal.defaultButtonHeightSmall,
                            child: SBBTertiaryButtonSmall(onPressed: widget.onFinish, labelText: widget.cancelLabel),
                          ),
                          const SizedBox(height: navigationAreaVerticalPadding),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (cardHeightCalculated) ...backCards.reversed,
            if (cardHeightCalculated && ((isAnimating && !goToNextStep!) || isDraggingToPrevious)) buildBackCard(0),
            if (cardHeightCalculated) buildFrontCard(),
            if (cardHeightCalculated && currentStepIndex > 0 && currentStepIndex < _cards.length && !isShowingEndPage)
              Positioned(
                left: isDraggingToPrevious && isAnimating
                    ? min(
                        0,
                        (dragEndPosition! - dragStartPosition - frontCardPadding.left - cardWidth) *
                            animationValueReversed,
                      )
                    : isDraggingToPrevious && !isAnimating
                    ? cardLeftValue! - frontCardPadding.left
                    : goToNextStep!
                    ? -cardWidth * animationValue
                    : -(cardWidth + frontCardPadding.left) * animationValueReversed,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: isDraggingToPrevious || isAnimating && !goToNextStep! ? 1 : 0,
                    child: Padding(padding: frontCardPadding, child: buildCard(currentStepIndex - 1)),
                  ),
                ),
              ),
            if (orientation == Orientation.landscape) ...[
              Semantics(
                sortKey: const OrdinalSortKey(3),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: frontCardPadding.top, right: frontCardPadding.top),
                    child: SBBTertiaryButton(
                      semanticLabel: widget.cancelLabel,
                      onPressed: widget.onFinish,
                      iconData: SBBIcons.cross_small,
                    ),
                  ),
                ),
              ),
              Semantics(
                sortKey: const OrdinalSortKey(2),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: frontCardPadding.top),
                    child: SBBTertiaryButton(
                      semanticLabel: widget.forwardSemanticsLabel,
                      onPressed: () => changeStep(goToNextStep: true),
                      iconData: SBBIcons.chevron_small_right_small,
                    ),
                  ),
                ),
              ),
              BlockSemantics(
                blocking: isBlocking,
                child: Semantics(
                  sortKey: const OrdinalSortKey(0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: frontCardPadding.top),
                      child: SBBTertiaryButton(
                        semanticLabel: widget.backSemanticsLabel,
                        onPressed: () => changeStep(goToNextStep: false),
                        iconData: SBBIcons.chevron_small_left_small,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            buildStartPage(),
            buildEndPage(),
          ],
        ),
      ),
    );
  }

  Widget buildStartPage() => Positioned(
    left: isShowingStartPage && isAnimating
        ? isDraggingToPrevious
              ? dragEndPosition! - widgetWidth + (widgetWidth - dragEndPosition!) * animationValue
              : goToNextStep!
              ? -widgetWidth * animationValue
              : -widgetWidth + widgetWidth * animationValue
        : isShowingStartPage && isDraggingToPrevious
        ? cardLeftValue
        : null,
    child: SizedBox(
      width: widgetWidth,
      height: widgetHeight,
      child: IgnorePointer(
        ignoring: !isShowingStartPage,
        child: BlockSemantics(
          blocking: isShowingStartPage,
          child: Opacity(
            opacity: isShowingStartPage ? 1 : 0,
            child: widget.builderDelegate.buildStartPage(context, _onStartOnboarding, widget.onFinish),
          ),
        ),
      ),
    ),
  );

  Widget buildEndPage() => Positioned(
    left: isShowingEndPage && isDraggingToNext
        ? isAnimating
              ? dragEndPosition! * animationValueReversed
              : cardLeftValue! + widgetWidth
        : isShowingEndPage && isAnimating
        ? widgetWidth * (goToNextStep! ? animationValueReversed : animationValue)
        : null,
    child: SizedBox(
      width: widgetWidth,
      height: widgetHeight,
      child: IgnorePointer(
        ignoring: !isShowingEndPage,
        child: BlockSemantics(
          blocking: isShowingEndPage,
          child: Opacity(
            opacity: isShowingEndPage ? 1 : 0,
            child: widget.builderDelegate.buildEndPage(context, widget.onFinish),
          ),
        ),
      ),
    ),
  );

  Widget buildStepIndicator(int index) {
    Color? color = style.themeValue(SBBColors.smoke, SBBColors.anthracite);
    var sizeAdjustment = 0.0;
    var marginAdjustment = 2.0;
    if (isAnimating && !isShowingStartPage && !isShowingEndPage) {
      if (goToNextStep!) {
        if (currentStepIndex == index) {
          color = colorTween.transform(animationValueReversed);
          sizeAdjustment = 4.0 * animationValueReversed;
          marginAdjustment = 2.0 * animationValue;
        } else if (currentStepIndex == index - 1) {
          color = colorTween.transform(animationValue);
          sizeAdjustment = 4.0 * animationValue;
          marginAdjustment = 2.0 * animationValueReversed;
        }
      } else {
        if (currentStepIndex == index) {
          color = colorTween.transform(animationValueReversed);
          sizeAdjustment = 4.0 * animationValueReversed;
          marginAdjustment = 2.0 * animationValue;
        } else if (currentStepIndex == index + 1) {
          color = colorTween.transform(animationValue);
          sizeAdjustment = 4.0 * animationValue;
          marginAdjustment = 2.0 * animationValueReversed;
        }
      }
    } else if (currentStepIndex == index) {
      color = style.themeValue(SBBColors.black, SBBColors.white);
      sizeAdjustment = 4.0;
      marginAdjustment = 0.0;
    }

    return Container(
      height: 4.0 + sizeAdjustment,
      width: 4.0 + sizeAdjustment,
      margin: EdgeInsets.all(5.0 + marginAdjustment),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget buildFrontCard() => Positioned(
    left: isNotDragging && isAnimating && goToNextStep! && !isShowingStartPage && !isShowingEndPage
        ? -(cardWidth + frontCardPadding.left) * animationValue
        : isDraggingToNext && isAnimating && !isShowingEndPage
        ? min(
            0,
            dragEndPosition! -
                dragStartPosition -
                (cardWidth + frontCardPadding.left + dragEndPosition! - dragStartPosition) * animationValue,
          )
        : isDraggingToNext && !isAnimating && !isShowingEndPage
        ? cardLeftValue
        : null,
    child: BlockSemantics(
      blocking: isBlocking && orientation == Orientation.portrait,
      child: Semantics(
        sortKey: const OrdinalSortKey(1),
        child: GestureDetector(
          onHorizontalDragUpdate: (details) => setState(() {
            if (cardLeftValue == null) {
              setState(() => dragStartPosition = details.globalPosition.dx);
            }
            dragEndPosition = details.globalPosition.dx;
            final newLeftValue = dragEndPosition! - dragStartPosition;
            if (isNotDragging) {
              dragState = newLeftValue == 0
                  ? 0
                  : newLeftValue < 0
                  ? 1
                  : 2;
              backScrollController = ScrollController(initialScrollOffset: scrollController.offset);
              if (isDraggingToPrevious && currentStepIndex == 0) {
                setState(() => isShowingStartPage = true);
              } else if (isDraggingToNext && currentStepIndex == _cards.length - 1) {
                setState(() => isShowingEndPage = true);
              }
            }
            setState(
              () => cardLeftValue = isDraggingToNext ? min(0, newLeftValue) : min(0, newLeftValue - cardWidth),
            );
          }),
          onHorizontalDragEnd: (details) {
            if (dragEndPosition != null) {
              setState(() => changeStep(goToNextStep: isDraggingToNext));
            }
          },
          child: Container(
            color: SBBColors.transparent,
            padding: frontCardPadding,
            child: Opacity(
              opacity: isAnimating && !goToNextStep! ? 0 : 1,
              child: Container(child: buildCard(currentStepIndex)),
            ),
          ),
        ),
      ),
    ),
  );

  Widget buildBackCard(int layerIndex) {
    final resizeValue =
        animationValue *
        (isShowingStartPage || isShowingEndPage ? 0 : 1) *
        (goToNextStep!
            ? layerIndex == 0
                  ? 0
                  : 1
            : -1);
    const opacityMultiplier = 1.0 / (visibleBackCardsCount + 1);
    return ExcludeSemantics(
      child: Container(
        color: controlStyle.headerBackgroundColor,
        margin: EdgeInsets.only(
          top: max(
            0.0,
            visibleBackCardsCount * parentPadding -
                layerIndex * parentPadding +
                parentPadding * resizeValue +
                parentPadding,
          ),
        ),
        child: Opacity(
          opacity: max(0.0, 1.0 - layerIndex * opacityMultiplier + resizeValue * opacityMultiplier),
          child: Transform.scale(
            scale: 1.0 - 0.1 * layerIndex + 0.1 * resizeValue,
            alignment: Alignment.topCenter,
            child: buildCard(currentStepIndex + layerIndex, isBackCard: true),
          ),
        ),
      ),
    );
  }

  Widget buildCard(int index, {bool isBackCard = false}) => ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(sbbDefaultSpacing)),
    child: Container(
      color: style.themeValue(SBBColors.white, SBBColors.charcoal),
      width: cardWidth,
      height: cardHeight,
      child: SingleChildScrollView(
        controller: isBackCard && index == currentStepIndex
            ? backScrollController
            : index == currentStepIndex
            ? scrollController
            : null,
        child: LayoutBuilder(
          builder: (context, constraint) => ConstrainedBox(
            constraints: BoxConstraints(minHeight: cardHeight),
            child: IntrinsicHeight(child: _cards[index]),
          ),
        ),
      ),
    ),
  );

  void changeStep({bool? goToNextStep}) {
    if (isAnimating || !isAnimating && isNotDragging && isShowingStartPage && !goToNextStep!) {
      return;
    }
    setState(() {
      this.goToNextStep = goToNextStep;
      isShowingStartPage = !goToNextStep! && currentStepIndex == 0;
      isShowingEndPage = goToNextStep && currentStepIndex == _cards.length - 1;
    });
    backScrollController = ScrollController(initialScrollOffset: isShowingStartPage ? 0 : scrollController.offset);

    if (goToNextStep!) {
      _cards[currentStepIndex].onDismissed?.call();
    }

    animationController.forward().whenCompleteOrCancel(() {
      animationController.reset();
      scrollController.jumpTo(0);
      setState(() {
        dragState = 0;
        cardLeftValue = null;
        dragEndPosition = null;
        isScrollControllerAnimating = false;
        isBackScrollControllerAnimating = false;
        if (!isShowingStartPage && !isShowingEndPage) {
          currentStepIndex += goToNextStep ? 1 : -1;
        }
      });
    });
  }

  void _notifyOnboardingChanged() {
    if (isShowingStartPage) {
      SBBOnboardingNotification.startPage().dispatch(context);
    } else if (isShowingEndPage) {
      SBBOnboardingNotification.endPage().dispatch(context);
    } else {
      SBBOnboardingNotification.card(currentStepIndex).dispatch(context);
    }
  }

  void _onStartOnboarding() {
    setState(() => goToNextStep = true);
    animationController.forward().whenCompleteOrCancel(() {
      animationController.reset();
      setState(() => isShowingStartPage = false);
    });
  }

  Future<bool> _onPop() async {
    if (isShowingStartPage) {
      widget.onFinish();
      return true;
    } else if (isShowingEndPage) {
      setState(() => goToNextStep = false);
      animationController.forward().whenCompleteOrCancel(() {
        animationController.reset();
        setState(() => isShowingEndPage = false);
      });
      return false;
    } else {
      changeStep(goToNextStep: false);
      return false;
    }
  }
}
