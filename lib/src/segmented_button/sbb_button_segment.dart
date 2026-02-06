import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// Describes the data for a segment in an [SBBSegmentedButton].
///
/// Provide either [label] for custom content or [labelText] for text-only
/// content with standard styling. These parameters are mutually exclusive.
///
/// Similarly, provide either [leading] for a custom leading widget or
/// [leadingIconData] for an icon with standard styling. These parameters
/// are also mutually exclusive.
///
/// The generic type [T] represents the value associated with this segment.
class SBBButtonSegment<T> with Diagnosticable {
  const SBBButtonSegment({
    required this.value,
    this.label,
    this.labelText,
    this.leading,
    this.leadingIconData,
    this.style,
  }) : assert(
         label == null || labelText == null,
         'Cannot provide both label and labelText!',
       ),
       assert(
         leading == null || leadingIconData == null,
         'Cannot provide both leading and leadingIconData!',
       );

  /// The value represented by this segment.
  ///
  /// This is used to identify which segment is selected.
  final T value;

  /// A custom widget displayed as the segment's label.
  ///
  /// For simple text labels, use [labelText] instead.
  ///
  /// Cannot be used together with [labelText].
  final Widget? label;

  /// Text string to display as the segment's label using the standard design.
  ///
  /// Cannot be used together with [label].
  final String? labelText;

  /// A custom widget displayed before the label.
  ///
  /// For simple icons, use [leadingIconData] instead.
  ///
  /// Cannot be used together with [leadingIconData].
  final Widget? leading;

  /// Icon data for an icon displayed before the label.
  ///
  /// Cannot be used together with [leading].
  final IconData? leadingIconData;

  /// Customizes this segment's appearance.
  final SBBButtonSegmentStyle? style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<T>('value', value));
    properties.add(DiagnosticsProperty<Widget>('label', label));
    properties.add(StringProperty('labelText', labelText, defaultValue: null));
    properties.add(DiagnosticsProperty<Widget>('leading', leading));
    properties.add(DiagnosticsProperty<IconData>('leadingIconData', leadingIconData, defaultValue: null));
    properties.add(DiagnosticsProperty<SBBButtonSegmentStyle>('style', style, defaultValue: null));
    super.debugFillProperties(properties);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBButtonSegment &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          label == other.label &&
          labelText == other.labelText &&
          leading == other.leading &&
          leadingIconData == other.leadingIconData &&
          style == other.style;

  @override
  int get hashCode => Object.hash(value, label, labelText, leading, leadingIconData, style);
}
