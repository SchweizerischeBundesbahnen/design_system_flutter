import 'package:flutter/material.dart';

@Deprecated(
  'SBBOnboarding is deprecated since it is no component in the official Design System. Will be removed in v5.',
)
class SBBOnboardingNotification extends Notification {
  SBBOnboardingNotification._(this.type, this.index);

  SBBOnboardingNotification.startPage() : this._(.startPage, null);

  SBBOnboardingNotification.endPage() : this._(.endPage, null);

  SBBOnboardingNotification.card(int index) : this._(.card, index);

  SBBOnboardingNotification.other(int index) : this._(.other, index);

  final SBBOnboardingNotificationType type;
  final int? index;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBOnboardingNotification &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          index == other.index;

  @override
  int get hashCode => type.hashCode ^ index.hashCode;
}

enum SBBOnboardingNotificationType { startPage, endPage, card, other }
