part of 'sbb_segmented_button.dart';

typedef SegmentedButtonWidgetBuilder = Widget Function(SBBSegmentedButtonStyle? style, bool selected);

typedef SBBControlStyleSelector<T> = T? Function(SBBControlStyles s);
