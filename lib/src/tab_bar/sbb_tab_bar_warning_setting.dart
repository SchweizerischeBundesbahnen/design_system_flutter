class SBBTabBarWarningSetting {
  const SBBTabBarWarningSetting({required this.id, required this.semantics, required this.shown});

  final String id;
  final String semantics;
  final bool shown;

  SBBTabBarWarningSetting copyWith({String? id, String? semantics, bool? shown}) =>
      SBBTabBarWarningSetting(
        id: id ?? this.id,
        semantics: semantics ?? this.semantics,
        shown: shown ?? this.shown,
      );
}
