class TabBarWarningSetting {
  const TabBarWarningSetting({
    required this.id,
    required this.semantics,
    required this.shown,
  });

  final String id;
  final String semantics;
  final bool shown;

  TabBarWarningSetting copyWith({
    String? id,
    String? semantics,
    bool? shown,
  }) =>
      TabBarWarningSetting(
        id: id ?? this.id,
        semantics: semantics ?? this.semantics,
        shown: shown ?? this.shown,
      );
}
