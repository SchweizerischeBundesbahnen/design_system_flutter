import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const int _kNumberPages = 5;

class PaginatorPage extends StatefulWidget {
  const PaginatorPage({super.key});

  @override
  State<PaginatorPage> createState() => _PaginatorPageState();
}

class _PaginatorPageState extends State<PaginatorPage> {
  late int currentPage;

  @override
  void initState() {
    currentPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      componentConfig: Padding(
        padding: const .all(SBBSpacing.xSmall),
        child: Row(
          mainAxisAlignment: .center,
          spacing: SBBSpacing.medium,
          children: [
            SBBTertiaryButtonSmall(
              iconData: SBBIcons.arrow_left_small,
              labelText: 'Previous',
              onPressed: () {
                if (currentPage > 0) {
                  setState(() => currentPage--);
                }
              },
            ),
            SBBTertiaryButtonSmall(
              iconData: SBBIcons.arrow_right_small,
              labelText: 'Next',
              onPressed: () {
                if (currentPage < _kNumberPages - 1) {
                  setState(() => currentPage++);
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _LabeledSBBPaginator(label: 'Default', currentPage: currentPage),
          _LabeledSBBPaginator(label: 'Floating', currentPage: currentPage, isFloating: true),
        ],
      ),
    );
  }
}

class _LabeledSBBPaginator extends StatelessWidget {
  const _LabeledSBBPaginator({required this.currentPage, required this.label, this.isFloating = false});

  final int currentPage;
  final String label;
  final bool isFloating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(bottom: SBBSpacing.medium),
      child: Column(
        mainAxisSize: .min,
        spacing: SBBSpacing.small,
        children: [
          Text(label, style: SBBTextStyles.extraSmallLight),
          isFloating
              ? SBBPaginatorFloating(numberPages: _kNumberPages, currentPage: currentPage)
              : SBBPaginator(currentPage: currentPage, numberPages: _kNumberPages),
        ],
      ),
    );
  }
}
