import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class AutocompletionPage extends StatefulWidget {
  @override
  _AutocompletionPageState createState() => _AutocompletionPageState();
}

class _AutocompletionPageState extends State<AutocompletionPage> {
  final List<String> _favorites = ['123', '234', '345'];

  late final SBBAutocompletion<String> _autocompletion;

  @override
  void initState() {
    super.initState();
    _autocompletion = SBBAutocompletion<String>(
      key: GlobalKey(debugLabel: 'bla'),
      icon: SBBIcons.route_circle_start_small,
      itemFilter: (String item, String query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (String a, String b) {
        return a.compareTo(b);
      },
      itemSubmitted: (String submitted) {
        debugPrint('Item submitted: $submitted');
      },
      suggestions: [
        'aaa',
        'aaa1',
        'aaa2',
        'aaa3',
        'aaa4',
        'aabb',
        'bbb',
        'bbcc',
        'ccc',
        'ccdd',
        'eee',
      ],
      suggestionIcon: SBBIcons.train_station_small,
      enableFavorites: true,
      itemAddedToFavorites: (String item) {
        _autocompletion.addFavorite(item);
      },
      itemRemovedFromFavorites: (String item) {
        _autocompletion.removeFavorite(item);
      },
      favorites: _favorites,
      labelText: 'Autocompletion',
      controller: TextEditingController()..value = TextEditingValue(text: ''),
      clearOnSubmit: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    return SingleChildScrollView(
      child: Container(
        color: style.themeValue(
          SBBColors.white,
          SBBColors.charcoal,
        ),
        child: _autocompletion,
      ),
    );
  }
}
