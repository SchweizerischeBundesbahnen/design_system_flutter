import 'package:flutter/material.dart';

class SBBIllustration extends StatelessWidget {
  static const String _parent = 'lib/assets/illustrations';
  static const String _package = 'sbb_design_system_mobile';

  const SBBIllustration._({
    required this.assetName,
    this.semanticLabel,
    this.excludeFromSemantics = false,
  });

  factory SBBIllustration.staffMale({String? semanticLabel, bool excludeFromSemantics = false}) => SBBIllustration._(
    assetName: 'man',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  factory SBBIllustration.staffFemale({String? semanticLabel, bool excludeFromSemantics = false}) => SBBIllustration._(
    assetName: 'woman',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  factory SBBIllustration.display({String? semanticLabel, bool excludeFromSemantics = false}) => SBBIllustration._(
    assetName: 'display',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  factory SBBIllustration.binoculars({String? semanticLabel, bool excludeFromSemantics = false}) => SBBIllustration._(
    assetName: 'binoculars',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  factory SBBIllustration.telescope({String? semanticLabel, bool excludeFromSemantics = false}) => SBBIllustration._(
    assetName: 'telescope',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  factory SBBIllustration.train({String? semanticLabel, bool excludeFromSemantics = false}) => SBBIllustration._(
    assetName: 'train',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  factory SBBIllustration.elevator({String? semanticLabel, bool excludeFromSemantics = false}) => SBBIllustration._(
    assetName: 'elevator',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  factory SBBIllustration.boat({String? semanticLabel, bool excludeFromSemantics = false}) => SBBIllustration._(
    assetName: 'boat',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  factory SBBIllustration.cableCar({String? semanticLabel, bool excludeFromSemantics = false}) => SBBIllustration._(
    assetName: 'cableCar',
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  final String assetName;

  /// The semantic label of the asset.
  final String? semanticLabel;

  /// Whether the image should be excluded from the Semantics Tree.
  final bool excludeFromSemantics;

  AssetImage _image(Brightness brightness) {
    final path = '$_parent/${brightness.name}/$assetName';
    return AssetImage(path, package: _package);
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: _image(Theme.brightnessOf(context)),
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
    );
  }
}
