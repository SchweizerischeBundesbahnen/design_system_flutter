import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

const int _kNumberPages = 5;

class PaginatorPage extends StatelessWidget {
  const PaginatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(SBBSpacing.medium),
      child: Column(children: <Widget>[ThemeModeSegmentedButton(), PaginatorView()]),
    );
  }
}

class PaginatorView extends StatefulWidget {
  const PaginatorView({super.key});

  @override
  State<PaginatorView> createState() => _PaginatorViewState();
}

class _PaginatorViewState extends State<PaginatorView> {
  late int currentPage;

  @override
  void initState() {
    currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: SBBSpacing.medium),
        child: Column(
          children: [
            _LabeledSBBPaginator(label: 'Default', currentPage: currentPage),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    onPageChanged: _changeCurrentPage,
                    children: List<Widget>.generate(_kNumberPages, (int index) => _IndexedTextPage(pageIndex: index)),
                  ),
                  _LabeledSBBPaginator(label: 'Floating', currentPage: currentPage, isFloating: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeCurrentPage(int page) => setState(() {
    currentPage = page;
  });
}

class _LabeledSBBPaginator extends StatelessWidget {
  const _LabeledSBBPaginator({required this.currentPage, required this.label, this.isFloating = false});

  final int currentPage;
  final String label;
  final bool isFloating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SBBSpacing.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: SBBSpacing.medium,
        children: [
          Text(label, style: SBBTextStyles.extraSmallLight),
          SBBPaginator(currentPage: currentPage, numberPages: _kNumberPages, isFloating: isFloating),
        ],
      ),
    );
  }
}

class _IndexedTextPage extends StatelessWidget {
  const _IndexedTextPage({required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(
      margin: EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall),
      child: Center(child: Text('Page #${pageIndex + 1}')),
    );
  }
}
