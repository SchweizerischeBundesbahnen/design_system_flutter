class const SBBTabBarWarningSetting({
  required final String id,
  required final String semantics,
  required final bool shown,
}) {
  SBBTabBarWarningSetting copyWith({String? id, String? semantics, bool? shown}) => SBBTabBarWarningSetting(
    id: id ?? this.id,
    semantics: semantics ?? this.semantics,
    shown: shown ?? this.shown,
  );
}
