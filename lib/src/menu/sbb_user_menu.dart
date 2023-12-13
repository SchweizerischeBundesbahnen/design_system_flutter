import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

const double _kHorizontalSpacing = 8.0;

/// The SBB user menu for enabling login and an expandable SBBMenu, i.e. for logout.
///
/// If a [displayName] is given, the itemBuilder is called to create a SBB menu.
/// The header is added to the itemBuilder at the top.
class SBBUserMenu<T> extends StatelessWidget {
  /// Creates an SBBUserMenu with loggedIn = [displayName] != null.
  ///
  /// When loggedIn, the menu is a SBBMenuButton to build [itemBuilder].
  /// When not loggedIn, the menu is a flat TextButton with [leading] and
  /// loginTitle.
  ///
  /// The [onSelected] is called, when an entry from the expanded menu is called with
  /// the specified value as a return.
  ///
  /// To act upon a login request, use [onLoginRequest].
  const SBBUserMenu({
    required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.displayName,
    this.leading,
    this.onLoginRequest,
    this.header,
    this.loginTitle = 'Login',
    Key? key,
  }) : super(key: key);

  /// Called to create menu items when UserMenu is expanded.
  ///
  /// Only called when [displayName] != null (logged in).
  final SBBMenuItemBuilder<T> itemBuilder;

  /// The value of the menu item, if any,
  /// that should be highlighted when the logged in menu opens.
  final T? initialValue;

  /// Called when the user selects a value from the expanded userMenu.
  ///
  /// is never called if [displayName] == null.
  final SBBMenuSelected<T>? onSelected;

  /// The name of the user to display.
  ///
  /// When value given, user is "logged in" and [loginTitle] is ignored.
  /// The full menu becomes expandable.
  final String? displayName;

  /// The widget to lead left of [displayName].
  ///
  /// When logged in:
  /// defaults to a CircleAvatar with initials of [displayName].
  ///
  /// When not logged in:
  /// Defaults to [SBBIconswip.user_medium].
  final Widget? leading;

  /// Callback for handling login request.
  ///
  /// Ignored when [displayName] != null.
  final VoidCallback? onLoginRequest;

  /// Custom header for expanded [SBBUserMenu]. Renders at the top of the menu.
  ///
  /// Defaults to a [SBBMenuItem] with [leading] and [displayName].
  final SBBMenuEntry<T>? header;

  /// The title to display when [displayName] is null.
  ///
  /// User is "not logged in".
  /// defaults to "Login"
  final String loginTitle;

  bool get _isLoggedIn => displayName != null;

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn
        ? _buildLoggedInButton(context)
        : _buildLogInButton(context);
  }

  TextButton _buildLogInButton(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return TextButton(
      onPressed: onLoginRequest,
      style: _getThemedUserMenuButtonStyle(style),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leading != null
              ? leading!
              : Icon(
            SBBIcons.user_small,
                ),
          SizedBox(width: _kHorizontalSpacing),
          Text(loginTitle, maxLines: 1),
        ],
      ),
    );
  }

  Widget _buildLoggedInButton(BuildContext context) => SBBMenuButton(
        itemBuilder: _addHeaderToItemBuilder(context),
        onSelected: onSelected,
        initialValue: initialValue,
        child: Row(
          children: [
            leading != null ? leading! : _buildAvatar(),
            SizedBox(
              width: _kHorizontalSpacing,
            ),
            Text(
              displayName!,
              style: SBBWebTextStyles.medium.copyWith(color: SBBColors.iron),
            ),
            SizedBox(
              width: _kHorizontalSpacing,
            ),
            Transform.rotate(
              angle: 90.0 * math.pi / 180,
              child: Icon(
                SBBIcons.chevron_right_small,
                color: SBBColors.iron,
              ),
            ),
          ],
        ),
      );

  String _getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((l) => l[0].toUpperCase()).take(2).join()
      : '';

  ButtonStyle _getThemedUserMenuButtonStyle(SBBControlStyles style) => ButtonStyle(
        textStyle: SBBTheme.allStates(
          style.userMenuTextStyle,
        ),
        foregroundColor: style.userMenuForegroundColor,
        backgroundColor: SBBTheme.allStates(
          SBBColors.transparent,
        ),
        overlayColor: SBBTheme.allStates(
          SBBColors.transparent,
        ),
        padding: SBBTheme.allStates(
          EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: _kHorizontalSpacing,
          ),
        ),
        shape: SBBTheme.allStates(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        side: SBBTheme.allStates(BorderSide.none),
      );

  SBBMenuItemBuilder<T> _addHeaderToItemBuilder(BuildContext context) {
    final List<SBBMenuEntry<T>> items = itemBuilder(context);
    return (BuildContext context) => <SBBMenuEntry<T>>[
          header != null ? header! : _buildHeader(context),
          SBBMenuDivider(),
          ...items,
        ];
  }

  SBBMenuEntry<T> _buildHeader(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return SBBMenuItem(
      enabled: false,
      foregroundColor: SBBTheme.allStates(SBBColors.iron),
      backgroundColor: SBBTheme.allStates(SBBColors.white),
      textStyle: style.userMenuTextStyle,
      child: Row(
        children: [
          _buildAvatar(),
          SizedBox(
            width: _kHorizontalSpacing,
          ),
          Text(
            displayName!,
          )
        ],
      ),
    );
  }

  CircleAvatar _buildAvatar() => CircleAvatar(
        backgroundColor: SBBColors.cloud,
        child: Text(
          _getInitials(displayName ?? ''),
          style:
              SBBWebTextStyles.extraSmallBold.copyWith(color: SBBColors.metal),
        ),
        radius: 12.0,
      );
}
