import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// Icon options available for the badge icon type.
enum SBBBadgeIconData { checkmark, exclamationMark, info, live }

const double _badgeIconSize = 18.0;

/// A base class for badge widgets displayed in tab bar items.
///
/// This widget is designed to be used as the badge content in [SBBTabBarItemBadge].
/// It provides a common interface for different badge types with customizable
/// foreground and background colors.
///
/// Subclasses:
/// - [SBBTabBarBadgeIcon]: Displays a badge with an icon (checkmark, exclamation, info, or live indicator).
/// - [SBBTabBarBadgeText]: Displays a badge with text content.
///
/// Example:
/// ```dart
/// SBBTabBarItemBadge(
///   id: 'tab_1',
///   badge: SBBTabBarBadgeIcon(badgeIcon: SBBBadgeIconData.info),
/// )
/// ```
sealed class SBBTabBarBadge extends StatelessWidget {
  const SBBTabBarBadge({super.key, this.foregroundColor, this.backgroundColor});

  /// The color of the badge foreground (e.g., icon or text).
  ///
  /// If null, defaults to white for icon badges or white for text badges.
  final Color? foregroundColor;

  /// The background color of the badge.
  ///
  /// If null, defaults to the theme's primary color.
  final Color? backgroundColor;
}

/// A badge widget that displays an icon inside a circular background.
///
/// This badge type is used to show status indicators such as checkmarks,
/// exclamation marks, info icons, or live indicators.
///
/// Example:
/// ```dart
/// SBBTabBarBadgeIcon(
///   badgeIcon: SBBBadgeIconData.checkmark,
///   foregroundColor: Colors.white,
///   backgroundColor: Colors.green,
/// )
/// ```
class SBBTabBarBadgeIcon extends SBBTabBarBadge {
  const SBBTabBarBadgeIcon({super.key, required this.badgeIcon, super.foregroundColor, super.backgroundColor});

  /// The icon to display in the badge.
  final SBBBadgeIconData badgeIcon;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).extension<SBBBaseStyle>()?.primaryColor;
    final resolvedForegroundColor = foregroundColor ?? SBBColors.white;
    final resolvedBackgroundColor = backgroundColor ?? primaryColor ?? SBBColors.red;

    return CustomPaint(
      size: Size.square(_badgeIconSize),
      painter: _BadgeIconPainter(
        badgeIcon: badgeIcon,
        foregroundColor: resolvedForegroundColor,
        backgroundColor: resolvedBackgroundColor,
      ),
    );
  }
}

/// A badge widget that displays text inside a stadium-shaped (pill-shaped) background.
///
/// This badge type is typically used for displaying counts, labels, or short
/// status text.
///
/// Example:
/// ```dart
/// SBBTabBarBadgeText(
///   labelText: '5',
///   backgroundColor: Colors.red,
/// )
/// ```
class SBBTabBarBadgeText extends SBBTabBarBadge {
  const SBBTabBarBadgeText({super.key, required this.labelText, this.textStyle, super.backgroundColor});

  /// The text content to display in the badge.
  final String labelText;

  /// Custom text style for the label.
  ///
  /// If null, defaults to [SBBTextStyles.extraExtraSmallBold] with white color
  /// and font weight w900.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).extension<SBBBaseStyle>()?.primaryColor;
    final resolvedBackgroundColor = backgroundColor ?? primaryColor ?? SBBColors.red;

    return Container(
      decoration: ShapeDecoration(shape: StadiumBorder(), color: resolvedBackgroundColor),
      constraints: BoxConstraints(minWidth: _badgeIconSize, minHeight: _badgeIconSize),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            labelText,
            style:
                textStyle ??
                SBBTextStyles.extraExtraSmallBold.copyWith(color: SBBColors.white, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

class _BadgeIconPainter extends CustomPainter {
  final SBBBadgeIconData badgeIcon;

  final Color foregroundColor;

  final Color backgroundColor;

  const _BadgeIconPainter({required this.badgeIcon, required this.foregroundColor, required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    final backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = backgroundColor;
    canvas.drawCircle(center, size.shortestSide * .5, backgroundPaint);

    badgeIcon.toPaintMethod.call(canvas, size, foregroundColor);
  }

  @override
  bool shouldRepaint(covariant _BadgeIconPainter oldDelegate) {
    return badgeIcon != oldDelegate.badgeIcon ||
        foregroundColor != oldDelegate.foregroundColor ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}

extension _SBBBadgeIconDataX on SBBBadgeIconData {
  Function(Canvas, Size, Color) get toPaintMethod => switch (this) {
    SBBBadgeIconData.checkmark => _paintCheckmarkIcon,
    SBBBadgeIconData.exclamationMark => _paintExclamationIcon,
    SBBBadgeIconData.info => _paintInfoIcon,
    SBBBadgeIconData.live => _paintLiveIcon,
  };
}

// google Flutter Shap3Mak3r with 3 replaced by `e`
void _paintCheckmarkIcon(Canvas canvas, Size size, Color color) {
  Path path = Path();
  path.moveTo(3.85366, 7.87097);
  path.lineTo(9.87805, 1.67742);
  path.cubicTo(9.91057, 1.64301, 9.93902, 1.6043, 9.96341, 1.56129);
  path.cubicTo(9.9878, 1.51828, 10, 1.47097, 10, 1.41935);
  path.cubicTo(10, 1.36774, 9.9878, 1.31613, 9.96341, 1.26452);
  path.cubicTo(9.93902, 1.2129, 9.91057, 1.16989, 9.87805, 1.13548);
  path.lineTo(8.90244, 0.129032);
  path.cubicTo(8.86992, 0.0946235, 8.82927, 0.0645163, 8.78049, 0.0387097);
  path.cubicTo(8.73171, 0.0129031, 8.68293, 0, 8.63415, 0);
  path.cubicTo(8.58537, 0, 8.53658, 0.0129031, 8.4878, 0.0387097);
  path.cubicTo(8.43902, 0.0645163, 8.39837, 0.0946235, 8.36585, 0.129032);
  path.lineTo(3.58537, 5.03226);
  path.lineTo(1.63415, 3.07097);
  path.cubicTo(1.60163, 3.01935, 1.56098, 2.98495, 1.5122, 2.96774);
  path.cubicTo(1.46341, 2.95054, 1.41463, 2.94194, 1.36585, 2.94194);
  path.cubicTo(1.31707, 2.94194, 1.27236, 2.95054, 1.23171, 2.96774);
  path.cubicTo(1.19106, 2.98495, 1.14634, 3.01935, 1.09756, 3.07097);
  path.lineTo(0.121951, 4.07742);
  path.cubicTo(0.0894307, 4.11183, 0.0609757, 4.15484, 0.0365854, 4.20645);
  path.cubicTo(0.012195, 4.25806, 0, 4.30108, 0, 4.33548);
  path.cubicTo(0, 4.4043, 0.012195, 4.46021, 0.0365854, 4.50323);
  path.cubicTo(0.0609757, 4.54624, 0.0894307, 4.58495, 0.121951, 4.61935);
  path.lineTo(3.31707, 7.87097);
  path.cubicTo(3.34959, 7.92258, 3.39024, 7.95699, 3.43902, 7.97419);
  path.cubicTo(3.48781, 7.9914, 3.53659, 8, 3.58537, 8);
  path.cubicTo(3.63415, 8, 3.68293, 7.9914, 3.73171, 7.97419);
  path.cubicTo(3.78049, 7.95699, 3.82114, 7.92258, 3.85366, 7.87097);
  path.close();

  final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = color;
  path = path.shift(Offset(size.width / 2 - 5, size.height / 2 - 4));
  canvas.drawPath(path, paint);
}

void _paintExclamationIcon(Canvas canvas, Size size, Color color) {
  final paintFill = Paint()
    ..style = PaintingStyle.fill
    ..color = color;
  final paintStroke = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = size.width * 0.08333333
    ..color = color;

  Path path0 = Path();
  path0.moveTo(2.03211, 3.29713);
  path0.lineTo(2.03211, 0.125);
  path0.lineTo(0.236618, 0.125);
  path0.lineTo(0.236618, 3.29713);
  path0.lineTo(0.683736, 7.90039);
  path0.lineTo(1.56694, 7.90039);
  path0.lineTo(2.03211, 3.29713);
  path0.close();
  path0 = path0.shift(Offset(size.width / 2 - 1, size.height / 2 - 6));

  canvas.drawPath(path0, paintFill);

  Path path1 = Path();
  path1.moveTo(2.125, 11.1244);
  path1.cubicTo(2.125, 11.6767, 1.67728, 12.1244, 1.125, 12.1244);
  path1.cubicTo(0.572715, 12.1244, 0.125, 11.6767, 0.125, 11.1244);
  path1.lineTo(0.125, 11.0537);
  path1.cubicTo(0.125, 10.5014, 0.572715, 10.0537, 1.125, 10.0537);
  path1.cubicTo(1.67728, 10.0537, 2.125, 10.5014, 2.125, 11.0537);
  path1.lineTo(2.125, 11.1244);
  path1.close();
  path1 = path1.shift(Offset(size.width / 2 - 1, size.height / 2 - 6));

  canvas.drawPath(path1, paintFill);

  Path path2 = Path();
  path2.moveTo(2.03211, 3.29713);
  path2.lineTo(2.03211, 0.125);
  path2.lineTo(0.236618, 0.125);
  path2.lineTo(0.236618, 3.29713);
  path2.lineTo(0.683736, 7.90039);
  path2.lineTo(1.56694, 7.90039);
  path2.lineTo(2.03211, 3.29713);
  path2.close();

  path2 = path2.shift(Offset(size.width / 2 - 1, size.height / 2 - 6));

  canvas.drawPath(path2, paintStroke);

  canvas.drawPath(path2, paintFill);

  Path path3 = Path();
  path3.moveTo(2.125, 11.1244);
  path3.cubicTo(2.125, 11.6767, 1.67728, 12.1244, 1.125, 12.1244);
  path3.cubicTo(0.572715, 12.1244, 0.125, 11.6767, 0.125, 11.1244);
  path3.lineTo(0.125, 11.0537);
  path3.cubicTo(0.125, 10.5014, 0.572715, 10.0537, 1.125, 10.0537);
  path3.cubicTo(1.67728, 10.0537, 2.125, 10.5014, 2.125, 11.0537);
  path3.lineTo(2.125, 11.1244);
  path3.close();

  path3 = path3.shift(Offset(size.width / 2 - 1, size.height / 2 - 6));
  canvas.drawPath(path3, paintStroke);
  canvas.drawPath(path3, paintFill);
}

void _paintInfoIcon(Canvas canvas, Size size, Color color) {
  final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = color;
  Path path0 = Path();
  path0.moveTo(0.842318, 1.40386);
  path0.cubicTo(0.842318, 0.628689, 1.47087, 0, 2.24649, 0);
  path0.cubicTo(3.02149, 0, 3.65004, 0.628689, 3.65004, 1.40386);
  path0.cubicTo(3.65004, 2.17967, 3.02149, 2.80773, 2.24649, 2.80773);
  path0.cubicTo(1.47087, 2.80773, 0.842318, 2.17967, 0.842318, 1.40386);
  path0.close();

  path0 = path0.shift(Offset(size.width / 2 - 2.4, size.height / 2 - 5.5));
  canvas.drawPath(path0, paint);

  Path path1 = Path();
  path1.moveTo(0.275399, 10.4492);
  path1.lineTo(1.14502, 10.4492);
  path1.lineTo(1.14502, 4.46982);
  path1.lineTo(0.275399, 4.46982);
  path1.cubicTo(0.123433, 4.46982, 0, 4.347, 0, 4.19504);
  path1.cubicTo(0, 4.04307, 0.123433, 3.92026, 0.275399, 3.92026);
  path1.lineTo(3.64097, 3.92026);
  path1.lineTo(3.64097, 10.4492);
  path1.lineTo(4.48764, 10.4492);
  path1.cubicTo(4.63961, 10.4492, 4.76242, 10.5726, 4.76242, 10.724);
  path1.cubicTo(4.76242, 10.8759, 4.63961, 10.9988, 4.48764, 10.9988);
  path1.lineTo(1.14502, 11);
  path1.lineTo(0.275399, 10.9988);
  path1.cubicTo(0.123433, 10.9988, 0, 10.8759, 0, 10.724);
  path1.cubicTo(0, 10.5726, 0.123433, 10.4492, 0.275399, 10.4492);
  path1.close();
  path1 = path1.shift(Offset(size.width / 2 - 2.4, size.height / 2 - 5.5));

  canvas.drawPath(path1, paint);
}

void _paintLiveIcon(Canvas canvas, Size size, Color color) {
  final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = color;

  Path path0 = Path();
  path0.moveTo(0.0102563, 1.16352);
  path0.cubicTo(0.0880213, 1.70787, 0.590493, 2.08684, 1.13449, 2.01304);
  path0.lineTo(1.13895, 2.01253);
  path0.cubicTo(1.14683, 2.01165, 1.1632, 2.00996, 1.18739, 2.0081);
  path0.cubicTo(1.23585, 2.00438, 1.31514, 2, 1.42005, 2);
  path0.cubicTo(1.63057, 2, 1.93945, 2.01762, 2.30669, 2.09107);
  path0.cubicTo(3.03662, 2.23705, 3.99431, 2.60199, 4.88929, 3.49697);
  path0.cubicTo(5.78427, 4.39195, 6.14921, 5.34964, 6.2952, 6.07957);
  path0.cubicTo(6.36865, 6.44681, 6.38626, 6.75569, 6.38626, 6.96621);
  path0.cubicTo(6.38626, 7.07112, 6.38189, 7.15042, 6.37816, 7.19888);
  path0.cubicTo(6.3763, 7.22307, 6.37463, 7.24003, 6.37375, 7.24792);
  path0.lineTo(6.37342, 7.25034);
  path0.lineTo(6.37322, 7.25178);
  path0.cubicTo(6.29943, 7.79578, 6.67839, 8.29824, 7.22275, 8.37601);
  path0.cubicTo(7.76948, 8.45411, 8.27615, 8.07326, 8.35425, 7.52652);
  path0.lineTo(8.3544, 7.52551);
  path0.lineTo(8.35471, 7.5233);
  path0.lineTo(8.35541, 7.51817);
  path0.lineTo(8.35711, 7.50515);
  path0.cubicTo(8.35838, 7.49524, 8.35987, 7.48289, 8.3615, 7.46818);
  path0.cubicTo(8.36477, 7.43877, 8.36861, 7.3999, 8.37227, 7.35227);
  path0.cubicTo(8.37959, 7.2571, 8.38626, 7.12647, 8.38626, 6.96621);
  path0.cubicTo(8.38626, 6.6464, 8.35969, 6.20399, 8.25636, 5.68734);
  path0.cubicTo(8.04879, 4.6495, 7.52985, 3.3091, 6.30351, 2.08276);
  path0.cubicTo(5.07717, 0.856417, 3.73676, 0.337472, 2.69892, 0.129905);
  path0.cubicTo(2.18228, 0.0265755, 1.73986, 0, 1.42005, 0);
  path0.cubicTo(1.25979, 0, 1.12917, 0.00667316, 1.03399, 0.0139941);
  path0.cubicTo(0.986369, 0.0176577, 0.947493, 0.0214933, 0.918086, 0.0247607);
  path0.cubicTo(0.903378, 0.0263949, 0.891025, 0.0278886, 0.881116, 0.0291499);
  path0.lineTo(0.86809, 0.0308565);
  path0.lineTo(0.862968, 0.0315584);
  path0.lineTo(0.860759, 0.0318676);
  path0.lineTo(0.858784, 0.0321477);
  path0.cubicTo(0.31205, 0.110253, -0.0678486, 0.616785, 0.0102563, 1.16352);
  path0.close();

  path0 = path0.shift(Offset(size.width / 2 - 0.5, size.height / 2 - 7.5));

  canvas.drawPath(path0, paint);

  Path path1 = Path();
  path1.moveTo(0.0196122, 4.75382);
  path1.cubicTo(0.126944, 5.29047, 0.645247, 5.64022, 1.18161, 5.54111);
  path1.lineTo(1.18659, 5.54041);
  path1.cubicTo(1.19804, 5.53886, 1.22259, 5.53595, 1.25779, 5.53388);
  path1.cubicTo(1.32923, 5.52967, 1.4377, 5.52934, 1.56588, 5.54765);
  path1.cubicTo(1.81852, 5.58374, 2.13074, 5.68825, 2.41441, 5.97191);
  path1.cubicTo(2.69807, 6.25558, 2.80258, 6.5678, 2.83867, 6.82044);
  path1.cubicTo(2.85698, 6.94862, 2.85665, 7.05709, 2.85244, 7.12853);
  path1.cubicTo(2.85037, 7.16373, 2.84746, 7.18828, 2.84591, 7.19973);
  path1.lineTo(2.84521, 7.20472);
  path1.cubicTo(2.7461, 7.74108, 3.09585, 8.25938, 3.6325, 8.36671);
  path1.cubicTo(4.17406, 8.47502, 4.70089, 8.1238, 4.8092, 7.58224);
  path1.lineTo(3.83742, 7.38789);
  path1.cubicTo(4.8092, 7.58224, 4.80911, 7.58269, 4.8092, 7.58224);
  path1.lineTo(4.80956, 7.58042);
  path1.lineTo(4.80995, 7.57847);
  path1.lineTo(4.81077, 7.57423);
  path1.lineTo(4.81263, 7.56436);
  path1.lineTo(4.81708, 7.53914);
  path1.cubicTo(4.82032, 7.51994, 4.82406, 7.49596, 4.8279, 7.46756);
  path1.cubicTo(4.83556, 7.41088, 4.8437, 7.33599, 4.84899, 7.24598);
  path1.cubicTo(4.85952, 7.06698, 4.85918, 6.8219, 4.81857, 6.5376);
  path1.cubicTo(4.73681, 5.96528, 4.48776, 5.21684, 3.82862, 4.5577);
  path1.cubicTo(3.16948, 3.89856, 2.42104, 3.64951, 1.84872, 3.56775);
  path1.cubicTo(1.56442, 3.52714, 1.31934, 3.5268, 1.14034, 3.53733);
  path1.cubicTo(1.05033, 3.54262, 0.975439, 3.55076, 0.918755, 3.55842);
  path1.cubicTo(0.890362, 3.56226, 0.86638, 3.566, 0.847183, 3.56924);
  path1.lineTo(0.821962, 3.57369);
  path1.lineTo(0.812088, 3.57555);
  path1.lineTo(0.807848, 3.57637);
  path1.lineTo(0.805903, 3.57676);
  path1.cubicTo(0.805452, 3.57685, 0.804077, 3.57712, 1.00019, 4.5577);
  path1.lineTo(0.804077, 3.57712);
  path1.cubicTo(0.262517, 3.68543, -0.0886998, 4.21226, 0.0196122, 4.75382);
  path1.close();

  path1 = path1.shift(Offset(size.width / 2 - 0.5, size.height / 2 - 7.5));

  canvas.drawPath(path1, paint);
}
