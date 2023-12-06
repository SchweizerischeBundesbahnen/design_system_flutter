import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class AutocompletePage extends StatefulWidget {
  const AutocompletePage({Key? key}) : super(key: key);

  @override
  State<AutocompletePage> createState() => _AutocompletePageState();
}

class _AutocompletePageState extends State<AutocompletePage> {
  final List<String> _favorites = ['123', '234', '345'];

  late final SBBAutocompletion<String> _autocompletion;
  late final SBBAutocompletion<String> _autocompletion2;

  @override
  void initState() {
    super.initState();
    _autocompletion = SBBAutocompletion<String>(
      key: GlobalKey(debugLabel: 'bla'),
      //icon: SBBIcons.route_circle_start_small,
      itemFilter: (String item, String query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      minLength: 0,
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
        'eee'
      ],
      suggestionIcon: SBBIconsSmall.train_station_small,
      enableFavorites: true,
      itemAddedToFavorites: (String item) {
        _autocompletion.addFavorite(item);
      },
      itemRemovedFromFavorites: (String item) {
        _autocompletion.removeFavorite(item);
      },
      favorites: _favorites,
      labelText: 'Autocompletion, favorites',
      controller: TextEditingController()..value = TextEditingValue(text: ''),
      clearOnSubmit: false,
    );
    _autocompletion2 = SBBAutocompletion<String>(
      key: GlobalKey(debugLabel: 'bla'),
      icon: SBBIconsSmall.route_circle_start_small,
      itemFilter: (String item, String query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      minLength: 0,
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
        'eee'
      ],
      itemAddedToFavorites: (_) {},
      itemRemovedFromFavorites: (_) {},
      enableFavorites: false,
      favorites: [],
      labelText: 'Autocompletion, no favorites',
      controller: TextEditingController()..value = TextEditingValue(text: ''),
      clearOnSubmit: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            primary: false,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SBBWebText.headerOne(
                        'Autocomplete',
                        color: SBBColors.red,
                      ),
                      Container(
                        width: 300,
                        child: _autocompletion,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: _autocompletion2,
                      )
                    ])),
          )),
    );
  }
}
