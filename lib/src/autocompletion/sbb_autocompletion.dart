import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/autocompletion/autocompletion_link.dart';
import 'package:sbb_design_system_mobile/src/autocompletion/autocompletion_overlay.dart';
import 'package:sbb_design_system_mobile/src/autocompletion/autocompletion_target.dart';

typedef StringCallback = Function(String data);

typedef Filter<T> = bool Function(T suggestion, String query);

typedef InputEventCallback<T> = Function(T data);

typedef AutoCompleteOverlayItemBuilder<T> = Widget Function(BuildContext context, T suggestion);

/// SBB Autocompletion, BETA!
///
/// Displays a list of suggestions below the text field using an
/// [OverlayPortal]. The available height of the suggestion list automatically
/// accounts for the on-screen keyboard so the overlay never overlaps the
/// keyboard.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/autocompletion>
class SBBAutocompletion<T> extends StatefulWidget {
  const SBBAutocompletion({
    required this.key,
    required this.itemSubmitted,
    required this.suggestions,
    required this.favorites,
    required this.itemSorter,
    required this.itemFilter,
    this.onFocusChanged,
    this.submitOnSuggestionTap = true,
    this.clearOnSubmit = true,
    this.minLength = 1,
    this.suggestionsAmount = 5,
    this.focusNode,
    required this.itemAddedToFavorites,
    required this.itemRemovedFromFavorites,
    this.enableFavorites = false,
    this.suggestionIcon,
    this.controller,
    this.enabled = true,
    this.enableInteractiveSelection = false,
    this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.labelText,
    this.onChanged,
    this.onTextSubmitted,
    this.textCapitalization = .none,
    this.icon,
    this.decoration,
  }) : super(key: key);

  /// GlobalKey used to enable addSuggestion etc
  @override
  // ignore: overridden_fields
  final GlobalKey<SBBAutocompletionState<T>> key;

  /// Callback on item selected, this is the item selected of type T
  final InputEventCallback<T> itemSubmitted;

  /// Suggestions that will be displayed
  final List<T> suggestions;

  final List<T> favorites;

  /// Callback to sort items in the form (a of type T, b of type T)
  final Comparator<T> itemSorter;

  /// Callback to filter item: return true or false depending on input text
  final Filter<T> itemFilter;

  final ValueSetter<bool>? onFocusChanged;

  /// Call textSubmitted on suggestion tap, itemSubmitted will be called no matter what
  final bool submitOnSuggestionTap;

  /// Clear autoCompleteTextfield on submit
  final bool clearOnSubmit;

  /// Minimal length of input to trigger filter
  final int minLength;

  /// The amount of suggestions to show, larger values may result in them going off screen
  final int suggestionsAmount;

  /// The FocusNode to use for this widget
  final FocusNode? focusNode;

  /// Called when a suggestion is added to the favorites
  final InputEventCallback<T> itemAddedToFavorites;

  /// Called when a suggestion is removed from the favorites
  final InputEventCallback<T> itemRemovedFromFavorites;

  /// When enabled, a star icon is display on the suggestions and the callback are called
  final bool enableFavorites;

  /// The icon display in front of a suggestion
  final IconData? suggestionIcon;

  final TextEditingController? controller;
  final bool enabled;
  final bool enableInteractiveSelection;

  /// Placeholder text shown when the input is empty. Maps to [SBBInputDecoration.placeholderText].
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  /// Label text shown above the input field. Maps to [SBBInputDecoration.labelText].
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onTextSubmitted;
  final TextCapitalization textCapitalization;

  /// Leading icon shown before the input field. Maps to [SBBInputDecoration.leadingIconData].
  final IconData? icon;

  /// Additional decoration applied to the trigger [SBBTextInput].
  ///
  /// When provided, [labelText], [hintText], and [icon] are ignored in favour
  /// of the values set in [decoration].
  final SBBInputDecoration? decoration;

  /// Call this method to add a favorite to the list
  void addFavorite(T favorite) => key.currentState?.addFavorite(favorite);

  /// Call this method to remove a favorite from the list
  void removeFavorite(T favorite) => key.currentState?.removeFavorite(favorite);

  @override
  SBBAutocompletionState createState() => SBBAutocompletionState<T>();
}

class SBBAutocompletionState<T> extends State<SBBAutocompletion<T>> {
  final AutocompletionLink _link = AutocompletionLink();

  late FocusNode _effectiveFocusNode;
  late TextEditingController _effectiveController;

  String _currentText = '';

  List<T> filteredSuggestions = [];
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();

    _effectiveFocusNode = widget.focusNode ?? FocusNode();
    _effectiveController = widget.controller ?? TextEditingController();

    _effectiveFocusNode.addListener(_handleFocusChanged);

    if (_effectiveController.text.isNotEmpty) {
      _currentText = _effectiveController.text;
    }
  }

  void _handleFocusChanged() {
    widget.onFocusChanged?.call(_effectiveFocusNode.hasFocus);

    if (!_effectiveFocusNode.hasFocus) {
      setState(() {
        filteredSuggestions = [];
        _showOverlay = false;
      });
    } else if (_currentText.isNotEmpty) {
      setState(() {
        _showOverlay = true;
        filteredSuggestions = getSuggestions(
          widget.suggestions,
          widget.itemSorter,
          widget.itemFilter,
          widget.suggestionsAmount,
          _currentText,
        );
      });
    }
  }

  void triggerSubmitted(String submittedText) {
    widget.onTextSubmitted?.call(submittedText);

    if (widget.clearOnSubmit) {
      clear();
    }
  }

  void clear() {
    _effectiveController.clear();
    setState(() {
      _currentText = '';
      filteredSuggestions = [];
      _showOverlay = false;
    });
  }

  void addFavorite(T favorite) {
    if (!widget.favorites.contains(favorite)) {
      widget.favorites.add(favorite);
      widget.favorites.sort(widget.itemSorter);
      setState(() {});
    }
  }

  void removeFavorite(T favorite) {
    widget.favorites.remove(favorite);
    widget.favorites.sort(widget.itemSorter);
    setState(() {});
  }

  void _updateSuggestions(String query) {
    setState(() {
      filteredSuggestions = getSuggestions(
        widget.suggestions,
        widget.itemSorter,
        widget.itemFilter,
        widget.suggestionsAmount,
        query,
      );
    });
  }

  List<T> getSuggestions(
    final List<T> suggestions,
    final Comparator<T> sorter,
    final Filter<T> filter,
    final int maxAmount,
    final String? query,
  ) {
    if (query == null || query.length < widget.minLength) {
      return [];
    }

    final List<T> result = suggestions.where((item) => filter(item, query)).toList();
    result.sort(sorter);
    if (result.length > maxAmount) {
      return result.sublist(0, maxAmount);
    }
    return result;
  }

  Widget _createListItem({
    required T item,
    required VoidCallback onPressed,
    required VoidCallback onCallToAction,
    bool isFavorite = false,
  }) {
    return SBBListItem(
      titleText: item.toString(),
      onTap: onPressed,
      leadingIconData: widget.suggestionIcon,
      padding: .only(left: SBBSpacing.medium, right: SBBSpacing.xSmall),
      trailing: SBBTertiaryButtonSmall(
        onPressed: onCallToAction,
        iconData: isFavorite ? SBBIcons.star_filled_small : SBBIcons.star_small,
      ),
    );
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    // Dispose only what we created ourselves.
    if (widget.focusNode == null) {
      _effectiveFocusNode.dispose();
    }
    if (widget.controller == null) {
      _effectiveController.dispose();
    }
    _link.dispose();
    super.dispose();
  }

  SBBInputDecoration get _effectiveDecoration {
    if (widget.decoration != null) return widget.decoration!;
    return SBBInputDecoration(
      labelText: widget.labelText,
      placeholderText: widget.hintText,
      leadingIconData: widget.icon,
    );
  }

  List<Widget> get _favoritesWidgets {
    if (!widget.enableFavorites || widget.favorites.isEmpty) return const [];
    return widget.favorites.map((T favorite) {
      return _createListItem(
        isFavorite: true,
        item: favorite,
        onPressed: () {
          setState(() {
            final String newText = favorite.toString();
            _effectiveController.text = newText;
            widget.onChanged?.call(newText);
            if (widget.submitOnSuggestionTap) {
              _effectiveFocusNode.unfocus();
              widget.itemSubmitted(favorite);
              if (widget.clearOnSubmit) clear();
            }
          });
        },
        onCallToAction: () => widget.itemRemovedFromFavorites(favorite),
      );
    }).toList();
  }

  List<Widget> get _suggestionsWidgets {
    return filteredSuggestions.map((T suggestion) {
      return _createListItem(
        item: suggestion,
        onPressed: () {
          setState(() {
            final String newText = suggestion.toString();
            _effectiveController.text = newText;
            widget.onChanged?.call(newText);
            if (widget.submitOnSuggestionTap) {
              _effectiveFocusNode.unfocus();
              widget.itemSubmitted(suggestion);
              if (widget.clearOnSubmit) clear();
            }
          });
        },
        onCallToAction: () => widget.itemAddedToFavorites(suggestion),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final textField = SBBTextInput(
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
      enabled: widget.enabled,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      decoration: _effectiveDecoration,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      onChanged: (newText) {
        _currentText = newText;
        _showOverlay = true;
        _updateSuggestions(newText);
        widget.onChanged?.call(newText);
      },
      onTap: () {
        setState(() {
          _showOverlay = true;
        });
        _updateSuggestions(_currentText);
      },
      onSubmitted: triggerSubmitted,
      textCapitalization: widget.textCapitalization,
    );

    return AutocompletionTarget(
      link: _link,
      child: AutocompletionOverlay(
        link: _link,
        visible: _showOverlay,
        favoritesSection: _favoritesWidgets,
        suggestionsSection: _suggestionsWidgets,
        child: textField,
      ),
    );
  }
}
