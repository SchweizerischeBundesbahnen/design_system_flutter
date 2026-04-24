import 'package:flutter/material.dart';

class SBBIllustration extends StatelessWidget {
  const SBBIllustration._({
    required this.assetName,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    required this.constraints,
  });

  /// Creates a male staff illustration.
  ///
  /// The [constraints] is set to a maxHeight of 145px by default.
  factory SBBIllustration.staffMale({
    String? semanticLabel,
    bool excludeFromSemantics = false,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 145),
  }) => SBBIllustration._(
    assetName: 'man.png',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    constraints: constraints,
  );

  /// Creates a female staff illustration.
  ///
  /// The [constraints] is set to a maxHeight of 145px by default.
  factory SBBIllustration.staffFemale({
    String? semanticLabel,
    bool excludeFromSemantics = false,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 145),
  }) => SBBIllustration._(
    assetName: 'woman.png',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    constraints: constraints,
  );

  /// Creates a display illustration.
  ///
  /// The [constraints] is set to a maxHeight of 118px by default.
  factory SBBIllustration.display({
    String? semanticLabel,
    bool excludeFromSemantics = false,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 118),
  }) => SBBIllustration._(
    assetName: 'display.png',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    constraints: constraints,
  );

  /// Creates a binoculars illustration.
  ///
  /// The [constraints] is set to a maxHeight of 100px by default.
  factory SBBIllustration.binoculars({
    String? semanticLabel,
    bool excludeFromSemantics = false,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 100),
  }) => SBBIllustration._(
    assetName: 'binoculars.png',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    constraints: constraints,
  );

  /// Creates a telescope illustration.
  ///
  /// The [constraints] is set to a maxHeight of 156px by default.
  factory SBBIllustration.telescope({
    String? semanticLabel,
    bool excludeFromSemantics = false,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 156),
  }) => SBBIllustration._(
    assetName: 'telescope.png',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    constraints: constraints,
  );

  /// Creates a train illustration.
  ///
  /// The [constraints] is set to a maxHeight of 80px by default.
  factory SBBIllustration.train({
    String? semanticLabel,
    bool excludeFromSemantics = false,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 80),
  }) => SBBIllustration._(
    assetName: 'train.png',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    constraints: constraints,
  );

  /// Creates an elevator illustration.
  ///
  /// The [constraints] is set to a maxHeight of 138px by default.
  factory SBBIllustration.elevator({
    String? semanticLabel,
    bool excludeFromSemantics = false,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 138),
  }) => SBBIllustration._(
    assetName: 'elevator.png',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    constraints: constraints,
  );

  /// Creates a boat illustration.
  ///
  /// The [constraints] is set to a maxHeight of 133px by default.
  factory SBBIllustration.boat({
    String? semanticLabel,
    bool excludeFromSemantics = false,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 133),
  }) => SBBIllustration._(
    assetName: 'boat.png',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    constraints: constraints,
  );

  /// Creates a cable car illustration.
  ///
  /// The [constraints] is set to a maxHeight of 160px by default.
  factory SBBIllustration.cableCar({
    String? semanticLabel,
    bool excludeFromSemantics = false,
    BoxConstraints constraints = const BoxConstraints(maxHeight: 160),
  }) => SBBIllustration._(
    assetName: 'cableCar.png',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
    constraints: constraints,
  );

  static const String _parent = 'lib/assets/illustrations';
  static const String _package = 'sbb_design_system_mobile';

  final String assetName;

  /// The semantic label of the asset.
  final String? semanticLabel;

  /// Whether the image should be excluded from the Semantics Tree.
  final bool excludeFromSemantics;

  /// The layout constraints for the illustration.
  ///
  /// By default, this is set to the value specified in the
  /// [Figma design system](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=229-52&m=dev).
  final BoxConstraints constraints;

  AssetImage _image(Brightness brightness) {
    final path = '$_parent/${brightness.name}/$assetName';
    return AssetImage(path, package: _package);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints,
      child: Image(
        image: _image(Theme.brightnessOf(context)),
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
      ),
    );
  }
}
