import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class AutocompletionPage extends StatefulWidget {
  const AutocompletionPage({super.key});

  @override
  AutocompletionPageState createState() => AutocompletionPageState();
}

class AutocompletionPageState extends State<AutocompletionPage> {
  final List<String> _favorites = ['123', '234', '345'];

  late final SBBAutocompletion<String> _autocompletion;

  @override
  void initState() {
    super.initState();
    _autocompletion = SBBAutocompletion<String>(
      key: GlobalKey(debugLabel: 'bla'),
      icon: SBBIcons.route_circle_start_small,
      itemFilter: (item, query) => item.toLowerCase().startsWith(query.toLowerCase()),
      itemSorter: (a, b) => a.compareTo(b),
      itemSubmitted: (submitted) => debugPrint('Item submitted: $submitted'),
      onChanged: (value) => debugPrint('onChanged: $value'),
      suggestions: ['aaa', 'aaa1', 'aaa2', 'aaa3', 'aaa4', 'aabb', 'bbb', 'bbcc', 'ccc', 'ccdd', 'eee'],
      suggestionIcon: SBBIcons.train_station_small,
      enableFavorites: true,
      itemAddedToFavorites: (item) => _autocompletion.addFavorite(item),
      itemRemovedFromFavorites: (item) => _autocompletion.removeFavorite(item),
      favorites: _favorites,
      labelText: 'Autocompletion',
      controller: TextEditingController()..value = const TextEditingValue(text: ''),
      clearOnSubmit: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).sbbBaseStyle;
    return DemoPageScaffold(
      body: Container(
        margin: .only(top: SBBSpacing.large),
        color: style.themeValue(SBBColors.white, SBBColors.charcoal),
        child: _autocompletion,
      ),
    );
  }
}
