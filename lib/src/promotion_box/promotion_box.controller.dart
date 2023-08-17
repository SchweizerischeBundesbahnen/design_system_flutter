part of 'promotion_box.dart';

class PromotionBoxController {
  PromotionBoxController(TickerProvider vsync)
      : _animation = AnimationController(
          vsync: vsync,
          value: 1.0,
          duration: kThemeAnimationDuration,
        );

  final AnimationController _animation;

  Future<void> show() => _animation.animateTo(1.0);

  Future<void> hide() => _animation.animateTo(0.0);
}
