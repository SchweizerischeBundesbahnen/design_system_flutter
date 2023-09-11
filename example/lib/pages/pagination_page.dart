import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

const int _kNumberPages = 5;

class PaginationPage extends StatelessWidget {
  const PaginationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      child: Column(children: <Widget>[
        const ThemeModeSegmentedButton(),
        PaginationView(),
      ]),
    );
  }
}

class PaginationView extends StatefulWidget {
  const PaginationView({super.key});

  @override
  State<PaginationView> createState() => _PaginationViewState();
}

class _PaginationViewState extends State<PaginationView> {
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
        padding: const EdgeInsets.symmetric(
          vertical: sbbDefaultSpacing * 3,
          horizontal: sbbDefaultSpacing,
        ),
        child: Column(
          children: [
            _paginationHeader(),
            Expanded(
              flex: 10,
              child: PageView(
                  onPageChanged: _changeCurrentPage,
                  children: List<Widget>.generate(
                    _kNumberPages,
                    (int index) => _IndexedTextPage(pageIndex: index),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paginationHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LabeledSBBPagination(label: 'Default', currentPage: currentPage),
        _LabeledSBBPagination(
          label: 'Floating',
          currentPage: currentPage,
          isFloating: true,
        ),
      ],
    );
  }

  void _changeCurrentPage(int page) => setState(() {
        currentPage = page;
      });
}

class _LabeledSBBPagination extends StatelessWidget {
  const _LabeledSBBPagination({
    required this.currentPage,
    required this.label,
    this.isFloating = false,
  });

  final int currentPage;
  final String label;
  final bool isFloating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: SBBTextStyles.extraSmallLight,
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBPagination(
          currentPage: currentPage,
          numberPages: _kNumberPages,
          isFloating: isFloating,
        ),
      ],
    );
  }
}

class _IndexedTextPage extends StatelessWidget {
  const _IndexedTextPage({required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page #${pageIndex + 1}'),
    );
  }
}
