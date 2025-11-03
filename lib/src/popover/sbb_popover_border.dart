class SBBPopoverBorder {
  const SBBPopoverBorder._({
    bool? notchLeft,
    bool? notchTop,
    bool? notchRight,
    bool? notchBottom,
  }) : notchTop = notchTop ?? false,
       notchLeft = notchLeft ?? false,
       notchBottom = notchBottom ?? false,
       notchRight = notchRight ?? false;

  const factory SBBPopoverBorder.only({
    bool? notchLeft,
    bool? notchTop,
    bool? notchRight,
    bool? notchBottom,
  }) = SBBPopoverBorder._;

  factory SBBPopoverBorder.fromLTRB(bool notchLeft, bool notchTop, bool notchRight, bool notchBottom) =>
      SBBPopoverBorder._(notchLeft: notchLeft, notchTop: notchTop, notchRight: notchRight, notchBottom: notchBottom);

  factory SBBPopoverBorder.all({required bool notchAll}) =>
      SBBPopoverBorder._(notchTop: notchAll, notchBottom: notchAll, notchLeft: notchAll, notchRight: notchAll);

  final bool notchTop;
  final bool notchLeft;
  final bool notchRight;
  final bool notchBottom;

  SBBPopoverBorder get withNotchLeft => copyWith(notchLeft: true);

  SBBPopoverBorder get withNotchTop => copyWith(notchTop: true);

  SBBPopoverBorder get withNotchRight => copyWith(notchRight: true);

  SBBPopoverBorder get withNotchBottom => copyWith(notchBottom: true);

  SBBPopoverBorder copyWith({bool? notchTop, bool? notchLeft, bool? notchRight, bool? notchBottom}) =>
      SBBPopoverBorder.fromLTRB(
        notchLeft ?? this.notchLeft,
        notchTop ?? this.notchTop,
        notchRight ?? this.notchRight,
        notchBottom ?? this.notchBottom,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SBBPopoverBorder &&
            notchBottom == other.notchBottom &&
            notchTop == other.notchTop &&
            notchLeft == other.notchLeft &&
            notchRight == other.notchRight);
  }

  @override
  int get hashCode => Object.hash(notchLeft, notchRight, notchBottom, notchTop);
}
