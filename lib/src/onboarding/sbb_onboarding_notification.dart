import 'package:flutter/material.dart';

class SBBOnboardingNotification extends Notification {
  SBBOnboardingNotification._(this.type, this.index);

  SBBOnboardingNotification.startPage()
    : this._(SBBOnboardingNotificationType.startPage, null);

  SBBOnboardingNotification.endPage()
    : this._(SBBOnboardingNotificationType.endPage, null);

  SBBOnboardingNotification.card(int index)
    : this._(SBBOnboardingNotificationType.card, index);

  SBBOnboardingNotification.other(int index)
    : this._(SBBOnboardingNotificationType.other, index);

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

enum SBBOnboardingNotificationType {
  startPage,
  endPage,
  card,
  other,
}
