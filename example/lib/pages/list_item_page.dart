import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    ' Curabitur finibus, nulla nec tempor ornare, purus orci dictum tortor, non tristique velit tellus eu ligula.';

class ListItemPage extends StatefulWidget {
  const ListItemPage({super.key});

  @override
  State<ListItemPage> createState() => _ListItemPageState();
}

class _ListItemPageState extends State<ListItemPage> with TickerProviderStateMixin {
  bool _showImages = false;
  late final AnimationController _controller;

  // Slot indices for staggered image pop-in (top-left to bottom-right)
  static const _totalSlots = 85;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _showImages = !_showImages);
    if (_showImages) {
      _controller.forward(from: 0);
    } else {
      _controller.reverse(from: 1);
    }
  }

  bool _isSlotVisible(int index) {
    if (!_showImages && _controller.isDismissed) return false;
    if (_showImages && _controller.isCompleted) return true;
    final slotStart = index / _totalSlots;
    final slotEnd = (index + 1) / _totalSlots;
    final interval = Interval(slotStart, slotEnd, curve: Curves.easeOut);
    return interval.transform(_controller.value) > 0.0;
  }

  double _slotScale(int index) {
    if (!_showImages && _controller.isDismissed) return 0.0;
    if (_showImages && _controller.isCompleted) return 1.0;
    final slotStart = index / _totalSlots;
    final slotEnd = ((index + 3).clamp(0, _totalSlots)) / _totalSlots;
    final interval = Interval(slotStart, slotEnd, curve: Curves.elasticOut);
    return interval.transform(_controller.value);
  }

  Widget _buildImage({double size = 24}) {
    return Image.asset(
      'assets/images/app_bakery_logo_transparent_500.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }

  double _variedSize(int index, double baseSize) {
    final variation = ((index * 7) % 9 - 4) * 3.0;
    return baseSize + variation;
  }

  double _variedRotation(int index) {
    final angles = [-0.08, 0.05, -0.03, 0.07, 0.0, -0.06, 0.04, -0.02];
    return angles[index % angles.length];
  }

  Widget _animatedImage(int index, {double size = 24}) {
    final scale = _slotScale(index);
    final variedSize = _variedSize(index, size);
    final rotation = _variedRotation(index) * scale;
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Opacity(
          opacity: scale.clamp(0.0, 1.0),
          child: _buildImage(size: variedSize),
        ),
      ),
    );
  }

  Widget? _slotLeading(int index) {
    if (!_isSlotVisible(index)) return null;
    return _animatedImage(index, size: 24);
  }

  Widget? _slotTitle(int index, {double size = 20}) {
    if (!_isSlotVisible(index)) return null;
    return _animatedImage(index, size: size);
  }

  Widget? _slotSubtitle(int index) {
    if (!_isSlotVisible(index)) return null;
    return _animatedImage(index, size: 16);
  }

  Widget? _slotTrailing(int index) {
    if (!_isSlotVisible(index)) return null;
    return _animatedImage(index, size: 24);
  }

  /// Builds a coffee-themed [ThemeData] by lerping the base style.
  ThemeData _buildCoffeeTheme(BuildContext context) {
    final t = _controller.value;
    final currentTheme = Theme.of(context);
    if (t == 0) return currentTheme;

    final defaultBaseStyle = currentTheme.sbbBaseStyle;

    // Coffee color scheme
    final coffeeColorScheme = SBBColorScheme(
      primary: const Color(0xFF6D4C41), // solid mocha for buttons
      primary85: const Color(0xFF8D6E63),
      primary125: const Color(0xFF4E342E),
      primary150: const Color(0xFF3E2723),
      brand: const Color(0xFF6D4C41),
      backgroundBase: const Color(0xFFD7CCC8), // warm latte background
      backgroundContent: const Color(0xFFFFF8F0), // light cream cards
      error: const Color(0xFFD32F2F),
      iconPrimary: const Color(0xFF3E2723), // espresso
      iconSecondary: const Color(0xFF5D4037),
      textPrimary: const Color(0xFF3E2723), // dark espresso
      textSecondary: const Color(0xFF4E342E), // medium brown
      strokePrimary: const Color(0xFF5D4037),
      strokeSecondary: const Color(0xFF8D6E63),
      strokeSeparator: const Color(0xFFBCAAA4), // darker latte separator
      selection: const Color(0xFFA1887F),
    );

    // Lerp the color scheme
    final lerpedColorScheme = defaultBaseStyle.colorScheme.lerp(coffeeColorScheme, t);

    // Create a coffee text theme with serif font
    final coffeeTextTheme = SBBTextTheme(
      xxSmallLight: defaultBaseStyle.textTheme.xxSmallLight?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      xxSmallBold: defaultBaseStyle.textTheme.xxSmallBold?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      xSmallLight: defaultBaseStyle.textTheme.xSmallLight?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      xSmallBold: defaultBaseStyle.textTheme.xSmallBold?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      smallLight: defaultBaseStyle.textTheme.smallLight?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textSecondary),
      smallBold: defaultBaseStyle.textTheme.smallBold?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      mediumLight: defaultBaseStyle.textTheme.mediumLight?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      mediumBold: defaultBaseStyle.textTheme.mediumBold?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      largeLight: defaultBaseStyle.textTheme.largeLight?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      largeBold: defaultBaseStyle.textTheme.largeBold?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      xLargeLight: defaultBaseStyle.textTheme.xLargeLight?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      xLargeBold: defaultBaseStyle.textTheme.xLargeBold?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      xxLargeLight: defaultBaseStyle.textTheme.xxLargeLight?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
      xxLargeBold: defaultBaseStyle.textTheme.xxLargeBold?.copyWith(fontFamily: 'Georgia', color: coffeeColorScheme.textPrimary),
    );

    // Lerp the text theme
    final lerpedTextTheme = defaultBaseStyle.textTheme.lerp(coffeeTextTheme, t);

    // Build the lerped base style
    final lerpedBaseStyle = SBBBaseStyle(
      brightness: defaultBaseStyle.brightness,
      colorScheme: lerpedColorScheme,
      textTheme: lerpedTextTheme,
      iconTheme: IconThemeData.lerp(
        defaultBaseStyle.iconTheme,
        IconThemeData(color: coffeeColorScheme.iconPrimary, size: sbbIconSizeSmall),
        t,
      ),
      dividerTheme: DividerThemeData.lerp(
        defaultBaseStyle.dividerTheme,
        DividerThemeData(thickness: 1.0, space: 0.0, color: coffeeColorScheme.strokeSeparator),
        t,
      ),
    );

    // Create a full theme from the lerped base style
    return SBBTheme.light(baseStyle: lerpedBaseStyle);
  }

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    final coffeeTheme = _buildCoffeeTheme(context);

    return Theme(
      data: coffeeTheme,
      child: ColoredBox(
        color: Color.lerp(
          Theme.of(context).scaffoldBackgroundColor,
          const Color(0xFFD7CCC8), // warm latte
          _controller.value,
        )!,
        child: DemoPageScaffold(
        componentConfig: SBBPrimaryButton(
          labelText: _showImages ? 'Unbake' : 'Bake',
          onPressed: _toggle,
        ),
        body: Column(
          children: [
            SBBListHeader('Listed'),
            SBBContentBox(
              child: Column(
                children: SBBDivider.divideItems(
                  context: context,
                  items: [
                    // Row 0: Default — leading(0), title(1)
                    SBBListItem(
                      leading: _slotLeading(0),
                      leadingIconData: _isSlotVisible(0) ? null : SBBIcons.dog_small,
                      title: _slotTitle(1),
                      titleText: _isSlotVisible(1) ? null : 'Default',
                      onTap: () => sbbToast.show(titleText: 'Default'),
                    ),
                    // Row 1: Without Icon — leading(2), title(3)
                    SBBListItem(
                      leading: _slotLeading(2),
                      title: _slotTitle(3),
                      titleText: _isSlotVisible(3) ? null : 'Without Icon',
                      onTap: () => sbbToast.show(titleText: 'Without Icon'),
                    ),
                    // Row 2: With Subtext — leading(4), title(5), subtitle(6)
                    SBBListItem(
                      leading: _slotLeading(4),
                      leadingIconData: _isSlotVisible(4) ? null : SBBIcons.dog_small,
                      title: _slotTitle(5),
                      titleText: _isSlotVisible(5) ? null : 'With Subtext',
                      subtitle: _slotSubtitle(6),
                      subtitleText: _isSlotVisible(6) ? null : loremIpsum,
                      onTap: () => sbbToast.show(titleText: 'With Subtext'),
                    ),
                    // Row 3: With Trailing Icon — leading(7), title(8), trailing(9)
                    SBBListItem(
                      leading: _slotLeading(7),
                      leadingIconData: _isSlotVisible(7) ? null : SBBIcons.dog_small,
                      title: _slotTitle(8),
                      titleText: _isSlotVisible(8) ? null : 'With Trailing Icon',
                      trailing: _slotTrailing(9),
                      trailingIconData: _isSlotVisible(9) ? null : SBBIcons.chevron_small_right_small,
                      onTap: () => sbbToast.show(titleText: 'With Trailing Icon'),
                    ),
                    // Row 4: With Button — leading(10), title(11), trailing(12)
                    SBBListItem(
                      leading: _slotLeading(10),
                      leadingIconData: _isSlotVisible(10) ? null : SBBIcons.dog_small,
                      title: _slotTitle(11),
                      titleText: _isSlotVisible(11) ? null : 'With Button',
                      trailing: _slotTrailing(12),
                      trailingIconButton: _isSlotVisible(12)
                          ? null
                          : SBBTertiaryButtonSmall(onPressed: () {}, iconData: SBBIcons.dog_small),
                      onTap: () => sbbToast.show(titleText: 'Mit Button'),
                    ),
                    // Row 5: With Status Message — title(13), subtitle(14)
                    SBBListItem(
                      title: _slotTitle(13),
                      titleText: _isSlotVisible(13) ? null : 'With Status Message',
                      subtitle: _isSlotVisible(14)
                          ? _animatedImage(14, size: 16)
                          : SBBStatus.information(labelText: 'Lorem ipsum sit dolor amet unt.'),
                      onTap: () => sbbToast.show(titleText: 'With Status Message'),
                    ),
                    // Row 6: With Links — leading(15), title(16)
                    SBBListItem(
                      leading: _slotLeading(15),
                      leadingIconData: _isSlotVisible(15) ? null : SBBIcons.globe_small,
                      title: _isSlotVisible(16) ? _animatedImage(16, size: 20) : Text('With Links'),
                      onTap: () => sbbToast.show(titleText: 'With Links'),
                      links: [
                        SBBListItem(
                          title: _slotTitle(17),
                          titleText: _isSlotVisible(17) ? null : 'Link',
                          trailing: _slotTrailing(18),
                          trailingIconData: _isSlotVisible(18) ? null : SBBIcons.chevron_small_right_small,
                          onTap: () => sbbToast.show(titleText: 'Link'),
                        ),
                        SBBListItem(
                          title: _slotTitle(19),
                          titleText: _isSlotVisible(19) ? null : 'Link 2',
                          trailing: _slotTrailing(20),
                          trailingIconData: _isSlotVisible(20) ? null : SBBIcons.chevron_small_right_small,
                          onTap: () => sbbToast.show(titleText: 'Link 2'),
                        ),
                      ],
                    ),
                    // Row 7: Loading — leading(21), title(22)
                    SBBListItem(
                      leading: _slotLeading(21),
                      leadingIconData: _isSlotVisible(21) ? null : SBBIcons.dog_small,
                      title: _slotTitle(22),
                      titleText: _isSlotVisible(22) ? null : 'Loading',
                      onTap: () => sbbToast.show(titleText: 'Loading'),
                      isLoading: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SBBSpacing.medium),
            SBBListHeader('Boxed'),
            Column(
              spacing: SBBSpacing.xSmall,
              children: [
                // Row 8: leading(23), title(24)
                SBBListItemBoxed(
                  leading: _slotLeading(23),
                  leadingIconData: _isSlotVisible(23) ? null : SBBIcons.dog_small,
                  title: _slotTitle(24),
                  titleText: _isSlotVisible(24) ? null : 'Default',
                  onTap: () => sbbToast.show(titleText: 'Default'),
                ),
                // Row 9: leading(25), title(26)
                SBBListItemBoxed(
                  leading: _slotLeading(25),
                  title: _slotTitle(26),
                  titleText: _isSlotVisible(26) ? null : 'Without Icon',
                  onTap: () => sbbToast.show(titleText: 'Without Icon'),
                ),
                // Row 10: leading(27), title(28), subtitle(29)
                SBBListItemBoxed(
                  leading: _slotLeading(27),
                  leadingIconData: _isSlotVisible(27) ? null : SBBIcons.dog_small,
                  title: _slotTitle(28),
                  titleText: _isSlotVisible(28) ? null : 'With Subtext',
                  subtitle: _slotSubtitle(29),
                  subtitleText: _isSlotVisible(29) ? null : loremIpsum,
                  onTap: () => sbbToast.show(titleText: 'With Subtext'),
                ),
                // Row 11: leading(30), title(31), trailing(32)
                SBBListItemBoxed(
                  leading: _slotLeading(30),
                  leadingIconData: _isSlotVisible(30) ? null : SBBIcons.dog_small,
                  title: _slotTitle(31),
                  titleText: _isSlotVisible(31) ? null : 'With Trailing Icon',
                  trailing: _slotTrailing(32),
                  trailingIconData: _isSlotVisible(32) ? null : SBBIcons.chevron_small_right_small,
                  onTap: () => sbbToast.show(titleText: 'With Trailing Icon'),
                ),
                // Row 12: leading(33), title(34)
                SBBListItemBoxed(
                  leading: _slotLeading(33),
                  leadingIconData: _isSlotVisible(33) ? null : SBBIcons.dog_small,
                  title: _slotTitle(34),
                  titleText: _isSlotVisible(34) ? null : 'Loading',
                  onTap: () => sbbToast.show(titleText: 'Loading'),
                  isLoading: true,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SBBSpacing.xSmall),
              child: SBBListHeader('Dynamically generated'),
            ),
            Padding(
              padding: EdgeInsets.all(SBBSpacing.xSmall).copyWith(bottom: SBBSpacing.xLarge),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 50,
                itemBuilder: (context, idx) {
                  final slotIndex = 35 + idx;
                  return SBBListItem(
                    onTap: () {},
                    title: _slotTitle(slotIndex),
                    titleText: _isSlotVisible(slotIndex) ? null : 'Index ${idx + 1}',
                  );
                },
                separatorBuilder: SBBDivider.separatorBuilder,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
