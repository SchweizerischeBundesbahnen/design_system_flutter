import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  State<DropdownPage> createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  int? _selectedValue1;
  int? _selectedValue2 = 1;
  int? _selectedValue3;

  int _itemCount = 5;

  List<SBBDropdownItem<int>> get _items =>
      List.generate(_itemCount, (idx) => SBBDropdownItem(value: idx, label: 'Item ${idx + 1}'));

  List<int> _multiSelectValues1 = [];
  List<int> _multiSelectValues2 = [1];
  final List<int> _multiSelectValues3 = [];

  List<SBBDropdownItem<int>> get _multiSelectItems =>
      List.generate(_itemCount, (idx) => SBBDropdownItem(value: idx, label: 'Item ${idx + 1}'));

  String _sheetTitle = 'Default Title';
  bool _showLeadingIcon = false;
  bool _showCloseButton = true;

  @override
  Widget build(BuildContext context) {
    final inputLabelTextStyle = Theme.of(context).sbbInputDecorationTheme?.floatingLabelTextStyle;
    final inputLabelColor = Theme.of(context).sbbInputDecorationTheme?.labelForegroundColor;
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            mainAxisSize: .min,
            spacing: SBBSpacing.xSmall,
            children: [
              const ThemeModeSegmentedButton(),
              Flexible(
                child: Column(
                  mainAxisSize: .min,
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: SBBSpacing.xSmall,
                        ).copyWith(left: SBBSpacing.medium),
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            Text(
                              'Number of Items',
                              style: inputLabelTextStyle?.copyWith(color: inputLabelColor?.resolve({})),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Container(
                                    alignment: .center,
                                    constraints: BoxConstraints(minWidth: 72.0),
                                    padding: .symmetric(horizontal: SBBSpacing.medium),
                                    child: Text('$_itemCount', style: SBBTextStyles.mediumBold),
                                  ),
                                  Expanded(
                                    child: SBBSlider(
                                      value: _itemCount.toDouble(),
                                      min: 1,
                                      max: 100,
                                      divisions: 99,
                                      onChanged: (value) {
                                        setState(() {
                                          _itemCount = value.round();
                                          // Reset selections that are out of range
                                          if (_selectedValue1 != null && _selectedValue1! >= _itemCount) {
                                            _selectedValue1 = null;
                                          }
                                          if (_selectedValue2 != null && _selectedValue2! >= _itemCount) {
                                            _selectedValue2 = null;
                                          }
                                          if (_selectedValue3 != null && _selectedValue3! >= _itemCount) {
                                            _selectedValue3 = null;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SBBTextInput(
                        decoration: SBBInputDecoration(
                          labelText: 'Bottom Sheet Title',
                        ),
                        autofocus: false,
                        controller: TextEditingController.fromValue(TextEditingValue(text: _sheetTitle)),
                        onChanged: (value) => setState(() => _sheetTitle = value),
                      ),
                      SBBSwitchListItem(
                        titleText: 'Show Leading Icon in Sheet',
                        value: _showLeadingIcon,
                        onChanged: (value) => setState(() => _showLeadingIcon = value),
                      ),
                      SBBSwitchListItem(
                        titleText: 'Show Close Button in Sheet',
                        value: _showCloseButton,
                        onChanged: (value) => setState(() => _showCloseButton = value),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: .symmetric(horizontal: SBBSpacing.xSmall),
          sliver: SliverList.list(
            children: [
              const SBBListHeader('Single Choice'),
              SBBContentBox(
                child: Column(
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: [
                      SBBDropdown<int>(
                        triggerDecoration: const SBBInputDecoration(labelText: 'Label', placeholderText: 'Placeholder'),
                        sheetTitleText: _sheetTitle.isNotEmpty ? _sheetTitle : null,
                        sheetConfig: SBBBottomSheetConfig(
                          leadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                          showCloseButton: _showCloseButton,
                        ),
                        selectedItem: _selectedValue1,
                        items: _items,
                        onChanged: (value) {
                          debugPrint('Selected: $value');
                          setState(() => _selectedValue1 = value);
                        },
                      ),
                      SBBDropdown<int>(
                        triggerDecoration: const SBBInputDecoration(
                          labelText: 'Default Value',
                          leadingIconData: SBBIcons.dog_small,
                        ),
                        sheetTitleText: _sheetTitle.isNotEmpty ? _sheetTitle : null,
                        sheetConfig: SBBBottomSheetConfig(
                          leadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                          showCloseButton: _showCloseButton,
                        ),
                        selectedItem: _selectedValue2,
                        items: _items,
                        onChanged: (value) {
                          debugPrint('Selected: $value');
                          setState(() => _selectedValue2 = value);
                        },
                      ),
                      SBBDropdown<int>(
                        triggerDecoration: const SBBInputDecoration(
                          labelText: 'Disabled',
                          leadingIconData: SBBIcons.dog_small,
                        ),
                        selectedItem: _selectedValue3,
                        items: _items,
                        onChanged: null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: SBBSpacing.medium),
              const SBBListHeader('Multiple choice'),
              SBBContentBox(
                child: Column(
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: [
                      SBBMultiDropdown<int>(
                        triggerDecoration: const SBBInputDecoration(labelText: 'Label', placeholderText: 'Placeholder'),
                        sheetTitleText: _sheetTitle.isNotEmpty ? _sheetTitle : null,
                        sheetConfig: SBBBottomSheetConfig(
                          leadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                          showCloseButton: _showCloseButton,
                        ),
                        selectedItems: _multiSelectValues1,
                        items: _multiSelectItems,
                        onChanged: (value) {
                          debugPrint('Selected: $value');
                          setState(() => _multiSelectValues1 = value);
                        },
                      ),
                      SBBMultiDropdown<int>(
                        triggerDecoration: const SBBInputDecoration(
                          labelText: 'Default Value',
                          leadingIconData: SBBIcons.dog_small,
                        ),
                        sheetTitleText: _sheetTitle.isNotEmpty ? _sheetTitle : null,
                        sheetConfig: SBBBottomSheetConfig(
                          leadingIconData: _showLeadingIcon ? SBBIcons.dog_small : null,
                          showCloseButton: _showCloseButton,
                        ),
                        selectedItems: _multiSelectValues2,
                        items: _multiSelectItems,
                        onChanged: (value) {
                          setState(() => _multiSelectValues2 = value);
                        },
                      ),
                      SBBMultiDropdown<int>(
                        triggerDecoration: const SBBInputDecoration(
                          labelText: 'Disabled',
                          leadingIconData: SBBIcons.dog_small,
                        ),
                        selectedItems: _multiSelectValues3,
                        items: _multiSelectItems,
                        onChanged: null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
