import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../design_system_flutter.dart';

typedef StringCallback = Function(String data);

typedef Filter<T> = bool Function(T suggestion, String query);

typedef InputEventCallback<T> = Function(T data);

typedef AutoCompleteOverlayItemBuilder<T> = Widget Function(
    BuildContext context, T suggestion);

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
    this.isLastElement = false,
    this.keyboardType,
    this.labelText,
    this.onChanged,
    this.onTextSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.icon,
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
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLastElement;
  final TextInputType? keyboardType;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onTextSubmitted;
  final TextCapitalization textCapitalization;
  final IconData? icon;

  /// Call this method to add a favorite to the list
  void addFavorite(T favorite) => key.currentState?.addFavorite(favorite);

  /// Call this method to remove a favorite from the list
  void removeFavorite(T favorite) => key.currentState?.removeFavorite(favorite);

  @override
  SBBAutocompletionState createState() => SBBAutocompletionState<T>();
}

class SBBAutocompletionState<T> extends State<SBBAutocompletion<T>>
    with WidgetsBindingObserver {
  final LayerLink _layerLink = LayerLink();
  late SBBTextField _textField;

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
    _textField = SBBTextField(
      controller: widget.controller ?? TextEditingController(),
      enabled: widget.enabled,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      hintText: widget.hintText,
      inputFormatters: widget.inputFormatters,
      isLastElement: widget.isLastElement,
      keyboardType: widget.keyboardType,
      labelText: widget.labelText,
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
      onSubmitted: (submittedText) {
        triggerSubmitted(submittedText);
      },
      textCapitalization: widget.textCapitalization,
      icon: widget.icon,
      focusNode: widget.focusNode ?? FocusNode(),
    );

    _textField.focusNode?.addListener(() {
      widget.onFocusChanged?.call(_textField.focusNode!.hasFocus);

      if (!_textField.focusNode!.hasFocus) {
        filteredSuggestions = [];
        showOverlay = false;
        _updateOverlay();
      } else if (_currentText.isNotEmpty) {
        showOverlay = true;
        _updateOverlay(query: _currentText);
      }
    });

    if (widget.controller?.text != null) {
      _currentText = widget.controller!.text;
    }
  }

  @override
  void didChangeMetrics() {
    _bottomInset = View.of(context).viewInsets.bottom /
        MediaQuery.of(context).devicePixelRatio;
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
    _textField.controller?.clear();
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

  void _updateWebOverlay({String? query, bool metricsChanged = false}) {
    filteredSuggestions = getSuggestions(
      widget.suggestions,
      widget.itemSorter,
      widget.itemFilter,
      widget.suggestionsAmount,
      query,
    );

    const double maxOverlayHeight = 400;
    final double entryHeight =
        (widget.enableFavorites || (widget.suggestionIcon != null)) ? 45 : 30;

    final double paddingLeft =
        widget.icon == null ? sbbDefaultSpacing : (sbbDefaultSpacing * 1.5);

    final double overlayHeight =
        (widget.favorites.isNotEmpty && widget.enableFavorites)
            ? (widget.favorites.length * entryHeight) +
                (filteredSuggestions.length * entryHeight) +
                32
            : (filteredSuggestions.length * entryHeight) + 16;

    final double dxOffset =
        widget.icon == null ? paddingLeft : paddingLeft + sbbIconSizeSmall;

    if (showOverlay) {
      if (listSuggestionsEntry != null) {
        listSuggestionsEntry!.remove();
        listSuggestionsEntry = null;
      }
      if (_metricsChanged) {
        _metricsChanged = false;
      }
      final Size textFieldSize = (context.findRenderObject() as RenderBox).size;
      final height = textFieldSize.height;
      listSuggestionsEntry = OverlayEntry(
        builder: (BuildContext context) {
          return Positioned(
            width: textFieldSize.width - dxOffset,
            height: overlayHeight > maxOverlayHeight
                ? maxOverlayHeight
                : overlayHeight,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(dxOffset, height),
              child: Container(
                decoration: BoxDecoration(
                  color: SBBColors.white,
                  border: Border(
                      left: BorderSide(),
                      right: BorderSide(),
                      bottom: BorderSide()),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    if (widget.favorites.isNotEmpty && widget.enableFavorites)
                      Container(
                        color: SBBColors.white,
                        height: 16.0,
                      ),
                    if (widget.favorites.isNotEmpty && widget.enableFavorites)
                      ...widget.favorites.map(
                        (T favorite) {
                          return Row(
                            children: [
                              Expanded(
                                child: _createListItem(
                                  item: favorite,
                                  onPressed: () {
                                    setState(
                                      () {
                                        final String newText =
                                            favorite.toString();
                                        _textField.controller?.text = newText;
                                        if (widget.submitOnSuggestionTap) {
                                          _textField.focusNode?.unfocus();
                                          widget.itemSubmitted(favorite);
                                          if (widget.clearOnSubmit) {
                                            clear();
                                          }
                                        } else {
                                          _textChanged?.call(newText);
                                        }
                                      },
                                    );
                                  },
                                  onCallToAction: () {
                                    widget.itemRemovedFromFavorites(favorite);
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    Container(
                      color: SBBColors.white,
                      height: 16.0,
                    ),
                    ...filteredSuggestions.map(
                      (T suggestion) {
                        return Row(
                          children: [
                            Expanded(
                              child: _createListItem(
                                item: suggestion,
                                onPressed: () {
                                  setState(() {
                                    final String newText =
                                        suggestion.toString();
                                    _textField.controller?.text = newText;
                                    if (widget.submitOnSuggestionTap) {
                                      _textField.focusNode?.unfocus();
                                      widget.itemSubmitted(suggestion);
                                      if (widget.clearOnSubmit) {
                                        clear();
                                      }
                                    } else {
                                      _textChanged?.call(newText);
                                    }
                                  });
                                },
                                onCallToAction: () {
                                  widget.itemAddedToFavorites(suggestion);
                                },
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

      if (listSuggestionsEntry != null) {
        Overlay.of(context).insert(listSuggestionsEntry!);
      }
    } else {
      if (listSuggestionsEntry != null) {
        listSuggestionsEntry!.remove();
        listSuggestionsEntry = null;
      }
    }

    listSuggestionsEntry?.markNeedsBuild();
  }

  void _updateNativeOverlay({String? query, bool metricsChanged = false}) {
    if (showOverlay) {
      if (listSuggestionsEntry == null || _metricsChanged) {
        if (listSuggestionsEntry != null) {
          listSuggestionsEntry!.remove();
          listSuggestionsEntry = null;
        }
        if (_metricsChanged) {
          _metricsChanged = false;
        }
        final Size textFieldSize =
            (context.findRenderObject() as RenderBox).size;
        final height = textFieldSize.height;

        /// to get the size of the suggestions area between the text field and
        /// the keyboard, do some calculations...
        final Offset textFieldGlobalPosition =
            (context.findRenderObject() as RenderBox)
                .localToGlobal(Offset(0.0, height));

        /// screen size - textfield bottom y - keyboard height = area height
        final overlayHeight = MediaQuery.of(context).size.height -
            textFieldGlobalPosition.dy -
            _bottomInset;

        final style = SBBBaseStyle.of(context);

        listSuggestionsEntry = OverlayEntry(
          builder: (BuildContext context) {
            final backgroundColor = style.themeValue(
              SBBColors.milk,
              SBBColors.black,
            );
            final optionColor = style.themeValue(
              SBBColors.white,
              SBBColors.charcoal,
            );
            return Positioned(
              width: MediaQuery.of(context).size.width,
              height: overlayHeight,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(-textFieldGlobalPosition.dx, height),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: textFieldGlobalPosition.dx,
                  ),
                  color: backgroundColor,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      if (widget.favorites.isNotEmpty && widget.enableFavorites)
                        Container(
                          color: backgroundColor,
                          height: 16.0,
                        ),
                      if (widget.favorites.isNotEmpty && widget.enableFavorites)
                        const Divider(),
                      if (widget.favorites.isNotEmpty && widget.enableFavorites)
                        ...widget.favorites.map(
                          (T favorite) {
                            return Container(
                              color: optionColor,
                              child: _createListItem(
                                item: favorite,
                                onPressed: () {
                                  setState(
                                    () {
                                      final String newText =
                                          favorite.toString();
                                      _textField.controller?.text = newText;
                                      if (widget.submitOnSuggestionTap) {
                                        _textField.focusNode?.unfocus();
                                        widget.itemSubmitted(favorite);
                                        if (widget.clearOnSubmit) {
                                          clear();
                                        }
                                      } else {
                                        _textChanged?.call(newText);
                                      }
                                    },
                                  );
                                },
                                onCallToAction: () {
                                  widget.itemRemovedFromFavorites(favorite);
                                },
                              ),
                            );
                          },
                        ),
                      Container(
                        color: backgroundColor,
                        height: 16.0,
                      ),
                      if (filteredSuggestions.isNotEmpty) const Divider(),
                      ...filteredSuggestions.map(
                        (T suggestion) {
                          return Container(
                            color: optionColor,
                            child: _createListItem(
                              item: suggestion,
                              onPressed: () {
                                setState(() {
                                  final String newText = suggestion.toString();
                                  _textField.controller?.text = newText;
                                  if (widget.submitOnSuggestionTap) {
                                    _textField.focusNode?.unfocus();
                                    widget.itemSubmitted(suggestion);
                                    if (widget.clearOnSubmit) {
                                      clear();
                                    }
                                  } else {
                                    _textChanged?.call(newText);
                                  }
                                });
                              },
                              onCallToAction: () {
                                widget.itemAddedToFavorites(suggestion);
                              },
                            ),
                          );
                        },
                      ),
                    ],
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

  void _updateOverlay({String? query, bool metricsChanged = false}) {
    final bool isWeb =
        SBBBaseStyle.of(context).hostPlatform == HostPlatform.web;
    if (isWeb) {
      _updateWebOverlay(query: query, metricsChanged: metricsChanged);
    } else {
      _updateNativeOverlay(query: query, metricsChanged: metricsChanged);
    }
  }

  Widget _createListItem({
    required T item,
    required VoidCallback onPressed,
    required VoidCallback onCallToAction,
  }) {
    return SBBListItem.button(
      title: item.toString(),
      leadingIcon: widget.suggestionIcon,
      buttonIcon: SBBIcons.star_small,
      onPressedButton: onCallToAction,
      onPressed: onPressed,
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

    final List<T> filteredSuggestions =
        suggestions.where((item) => filter(item, query)).toList();
    filteredSuggestions.sort(sorter);
    if (filteredSuggestions.length > maxAmount) {
      return filteredSuggestions.sublist(0, maxAmount);
    }
    return filteredSuggestions;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // if we created our own focus node and controller, dispose of them
    // otherwise, let the caller dispose of their own instances
    if (widget.focusNode == null) {
      _textField.focusNode?.dispose();
    }
    if (widget.controller == null) {
      _textField.controller?.dispose();
    }
    listSuggestionsEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: _textField,
    );
  }
}
