import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../sbb_design_system_mobile.dart';

typedef StringCallback = Function(String data);

typedef Filter<T> = bool Function(T suggestion, String query);

typedef InputEventCallback<T> = Function(T data);

typedef AutoCompleteOverlayItemBuilder<T> = Widget Function(BuildContext context, T suggestion);

/// SBB Autocompletion, BETA!
///
/// This widget still has some layout problems and is best used on top of a
/// page. Does not yet work in the middle of a form, as the calculation of the
/// height of the suggestions overlay is based on the position of the text field.
/// Unfortunately [MediaQuery.of] does not provide valid data (always 0) to get
/// the size of the system keyboard. Therefore a [WidgetsBindingObserver] is
/// necessary and this makes the handling somewhat more complex (flags for
/// visibility).
///
/// Will revise the whole thing when there is more time... (famous last words)
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

  /// Callback on item selected, this is the item selected of type <T>
  final InputEventCallback<T> itemSubmitted;

  /// Suggestions that will be displayed
  final List<T> suggestions;

  final List<T> favorites;

  /// Callback to sort items in the form (a of type <T>, b of type <T>)
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

class SBBAutocompletionState<T> extends State<SBBAutocompletion<T>> with WidgetsBindingObserver {
  final LayerLink _layerLink = LayerLink();

  late FocusNode _effectiveFocusNode;
  late TextEditingController _effectiveController;

  StringCallback? _textChanged;
  String _currentText = '';

  OverlayEntry? listSuggestionsEntry;
  List<T> filteredSuggestions = [];

  double _bottomInset = 0.0;
  bool _metricsChanged = false;
  bool showOverlay = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _effectiveFocusNode = widget.focusNode ?? FocusNode();
    _effectiveController = widget.controller ?? TextEditingController();

    _effectiveFocusNode.addListener(_handleFocusChanged);

    if (_effectiveController.text.isNotEmpty) {
      _currentText = _effectiveController.text;
    }

    _textChanged = (value) => widget.onChanged?.call(value);
  }

  void _handleFocusChanged() {
    widget.onFocusChanged?.call(_effectiveFocusNode.hasFocus);

    if (!_effectiveFocusNode.hasFocus) {
      filteredSuggestions = [];
      showOverlay = false;
      _updateOverlay();
    } else if (_currentText.isNotEmpty) {
      showOverlay = true;
      _updateOverlay(query: _currentText);
    }
  }

  @override
  void didChangeMetrics() {
    _bottomInset = View.of(context).viewInsets.bottom / MediaQuery.of(context).devicePixelRatio;
    _metricsChanged = true;
    _updateOverlay(query: _currentText);
  }

  void triggerSubmitted(String submittedText) {
    widget.onTextSubmitted?.call(submittedText);

    if (widget.clearOnSubmit) {
      clear();
    }
  }

  void clear() {
    _effectiveController.clear();
    _currentText = '';
    _updateOverlay();
  }

  void addFavorite(T favorite) {
    if (!widget.favorites.contains(favorite)) {
      widget.favorites.add(favorite);
      widget.favorites.sort(widget.itemSorter);
      _updateOverlay(query: _currentText);
    }
  }

  void removeFavorite(T favorite) {
    widget.favorites.remove(favorite);
    widget.favorites.sort(widget.itemSorter);
    _updateOverlay(query: _currentText);
  }

  void _updateOverlay({String? query}) {
    if (showOverlay) {
      if (listSuggestionsEntry == null || _metricsChanged) {
        if (listSuggestionsEntry != null) {
          listSuggestionsEntry!.remove();
          listSuggestionsEntry = null;
        }
        if (_metricsChanged) {
          _metricsChanged = false;
        }
        final Size textFieldSize = (context.findRenderObject() as RenderBox).size;
        final height = textFieldSize.height;

        /// to get the size of the suggestions area between the text field and
        /// the keyboard, do some calculations...
        final Offset textFieldGlobalPosition = (context.findRenderObject() as RenderBox).localToGlobal(
          Offset(0.0, height),
        );

        /// screen size - textfield bottom y - keyboard height = area height
        final overlayHeight = MediaQuery.of(context).size.height - textFieldGlobalPosition.dy - _bottomInset;

        final style = SBBBaseStyle.of(context);

        listSuggestionsEntry = OverlayEntry(
          builder: (context) {
            final backgroundColor = style.themeValue(SBBColors.milk, SBBColors.black);
            final optionColor = style.themeValue(SBBColors.white, SBBColors.charcoal);
            return Positioned(
              width: MediaQuery.of(context).size.width,
              height: overlayHeight,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(-textFieldGlobalPosition.dx, height),
                child: Material(
                  child: Container(
                    padding: .symmetric(horizontal: textFieldGlobalPosition.dx),
                    color: backgroundColor,
                    child: ListView(
                      padding: .zero,
                      shrinkWrap: true,
                      children: [
                        if (widget.favorites.isNotEmpty && widget.enableFavorites)
                          Container(color: backgroundColor, height: 16.0),
                        if (widget.favorites.isNotEmpty && widget.enableFavorites) const Divider(),
                        if (widget.favorites.isNotEmpty && widget.enableFavorites)
                          ...widget.favorites.map((T favorite) {
                            return Container(
                              color: optionColor,
                              child: _createListItem(
                                isFavorite: true,
                                item: favorite,
                                onPressed: () {
                                  setState(() {
                                    final String newText = favorite.toString();
                                    _effectiveController.text = newText;
                                    _textChanged?.call(newText);
                                    if (widget.submitOnSuggestionTap) {
                                      _effectiveFocusNode.unfocus();
                                      widget.itemSubmitted(favorite);
                                      if (widget.clearOnSubmit) {
                                        clear();
                                      }
                                    }
                                  });
                                },
                                onCallToAction: () {
                                  widget.itemRemovedFromFavorites(favorite);
                                },
                              ),
                            );
                          }),
                        Container(color: backgroundColor, height: 16.0),
                        if (filteredSuggestions.isNotEmpty) const Divider(),
                        ...filteredSuggestions.map((T suggestion) {
                          return Container(
                            color: optionColor,
                            child: _createListItem(
                              item: suggestion,
                              onPressed: () {
                                setState(() {
                                  final String newText = suggestion.toString();
                                  _effectiveController.text = newText;
                                  _textChanged?.call(newText);
                                  if (widget.submitOnSuggestionTap) {
                                    _effectiveFocusNode.unfocus();
                                    widget.itemSubmitted(suggestion);
                                    if (widget.clearOnSubmit) {
                                      clear();
                                    }
                                  }
                                });
                              },
                              onCallToAction: () {
                                widget.itemAddedToFavorites(suggestion);
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );

        if (listSuggestionsEntry != null) {
          Overlay.of(context).insert(listSuggestionsEntry!);
        }
      }
    } else {
      if (listSuggestionsEntry != null) {
        listSuggestionsEntry!.remove();
        listSuggestionsEntry = null;
      }
    }

    filteredSuggestions = getSuggestions(
      widget.suggestions,
      widget.itemSorter,
      widget.itemFilter,
      widget.suggestionsAmount,
      query,
    );

    listSuggestionsEntry?.markNeedsBuild();
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
      padding: SBBListItemStyle.defaultPadding.copyWith(right: 8.0),
      trailing: SBBTertiaryButtonSmall(
        onPressed: onCallToAction,
        iconData: isFavorite ? SBBIcons.star_filled_small : SBBIcons.star_small,
      ),
    );
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

    final List<T> filteredSuggestions = suggestions.where((item) => filter(item, query)).toList();
    filteredSuggestions.sort(sorter);
    if (filteredSuggestions.length > maxAmount) {
      return filteredSuggestions.sublist(0, maxAmount);
    }
    return filteredSuggestions;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    // if we created our own focus node and controller, dispose of them
    // otherwise, let the caller dispose of their own instances
    if (widget.focusNode == null) {
      _effectiveFocusNode.dispose();
    }
    if (widget.controller == null) {
      _effectiveController.dispose();
    }
    listSuggestionsEntry?.remove();
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

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SBBTextInput(
        controller: _effectiveController,
        focusNode: _effectiveFocusNode,
        enabled: widget.enabled,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        decoration: _effectiveDecoration,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        onChanged: (newText) {
          _currentText = newText;
          showOverlay = true;
          _updateOverlay(query: newText);
          _textChanged?.call(newText);
        },
        onTap: () {
          showOverlay = true;
          _updateOverlay(query: _currentText);
        },
        onSubmitted: triggerSubmitted,
        textCapitalization: widget.textCapitalization,
      ),
    );
  }
}
