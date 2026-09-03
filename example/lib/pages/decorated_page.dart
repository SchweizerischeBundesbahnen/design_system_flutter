import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DecoratedPage extends StatefulWidget {
  const DecoratedPage({super.key});

  @override
  State<DecoratedPage> createState() => _DecoratedPageState();
}

class _DecoratedPageState extends State<DecoratedPage> {
  final _selectedTags = <String>{'Bern'};

  bool _showStatus = true;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);

    return DemoPageScaffold(
      componentConfig: Column(
        children: [
          SBBSwitchListItem(
            value: _showStatus,
            onChanged: (val) {
              setState(() {
                _showStatus = val;
              });
            },
            titleText: 'Show Status',
          ),
        ],
      ),
      body: Column(
        children: [
          SBBListHeader('Listed'),
          SBBContentBox(
            child: Column(
              mainAxisSize: .min,
              children: SBBDivider.divideItems(
                context: context,
                items: [
                  SBBDecorated(
                    decoration: SBBInputDecoration(labelText: 'Empty'),
                    onTap: () => sbbToast.show(titleText: 'Empty'),
                  ),
                  SBBDecorated(
                    decoration: SBBInputDecoration(
                      labelText: 'With Placeholder',
                      placeholderText: 'Nothing selected',
                    ),
                    onTap: () => sbbToast.show(titleText: 'Empty with placeholder'),
                  ),
                  SBBDecorated(
                    decoration: SBBInputDecoration(
                      labelText: 'Status',
                      leadingIconData: SBBIcons.dog_small,
                    ),
                    onTap: () => sbbToast.show(titleText: 'Status'),
                    child: _showStatus ? SBBStatus(state: .success, labelText: 'On time') : null,
                  ),
                  SBBDecorated(
                    decoration: SBBInputDecoration(
                      labelText: 'Custom Layout',
                      leadingIconData: SBBIcons.dog_small,
                      trailingIconData: SBBIcons.chevron_small_right_circle_small,
                    ),
                    onTap: () => sbbToast.show(titleText: 'Custom Layout'),
                    child: const _Route(from: 'Bern', to: 'Zürich HB'),
                  ),
                  SBBDecorated(
                    decoration: SBBInputDecoration(
                      labelText: 'Error',
                      errorText: 'This is an error!',
                      leadingIconData: SBBIcons.dog_small,
                    ),
                    onTap: () => sbbToast.show(titleText: 'Error'),
                    child: const _Route(from: 'Bern', to: 'Zürich HB'),
                  ),
                  SBBDecorated(
                    decoration: SBBInputDecoration(
                      labelText: 'Disabled',
                      leadingIconData: SBBIcons.dog_small,
                    ),
                    child: const _Route(from: 'Bern', to: 'Zürich HB'),
                  ),
                  SBBDecorated(
                    decoration: SBBInputDecoration(
                      labelText: 'Top Aligned Affixes',
                      leadingIconData: SBBIcons.dog_small,
                      contentPadding: .only(left: SBBSpacing.medium, top: SBBSpacing.xSmall),
                    ),
                    topAlignAffixes: true,
                    onTap: () => sbbToast.show(titleText: 'Top Aligned Affixes'),
                    child: const Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        Text('I am'),
                        Text('tall content'),
                        Text('with top aligned icons'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 120.0,
                    child: SBBDecorated(
                      decoration: SBBInputDecoration(
                        labelText: 'Expands',
                        leadingIconData: SBBIcons.dog_small,
                        contentPadding: .only(left: SBBSpacing.medium, top: SBBSpacing.xSmall),
                      ),
                      expands: true,
                      topAlignAffixes: true,
                      onTap: () => sbbToast.show(titleText: 'Expands'),
                      child: const Text('I fill the available height'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: SBBSpacing.medium),
          SBBListHeader('Boxed'),
          Column(
            spacing: SBBSpacing.xSmall,
            children: [
              SBBDecoratedBoxed(
                decoration: SBBInputDecoration(
                  labelText: 'Empty',
                  leadingIconData: SBBIcons.unicorn_small,
                ),
                onTap: () => sbbToast.show(titleText: 'Empty'),
              ),
              SBBDecoratedBoxed(
                decoration: SBBInputDecoration(
                  labelText: 'Status',
                  leadingIconData: SBBIcons.unicorn_small,
                  trailingIconData: SBBIcons.circle_information_small_small,
                ),
                onTap: () => sbbToast.show(titleText: 'Status'),
                child: SBBStatus(state: .warning, labelText: 'Delayed by 5 min'),
              ),
              SBBDecoratedBoxed(
                decoration: SBBInputDecoration(
                  labelText: 'With Error',
                  errorText: 'Error Text',
                  leadingIconData: SBBIcons.unicorn_small,
                ),
                onTap: () => sbbToast.show(titleText: 'Error'),
                child: const _Route(from: 'Bern', to: 'Zürich HB'),
              ),
              SBBDecoratedBoxed(
                decoration: SBBInputDecoration(leadingIconData: SBBIcons.unicorn_small, labelText: 'Disabled'),
                child: const _Route(from: 'Bern', to: 'Zürich HB'),
              ),
            ],
          ),
          SizedBox(height: SBBSpacing.medium),
          SBBListHeader('With an interactive child'),
          SBBContentBox(
            child: SBBDecorated(
              decoration: SBBInputDecoration(
                labelText: 'Tags',
                contentPadding: .only(left: SBBSpacing.medium, top: SBBSpacing.xSmall, bottom: SBBSpacing.xSmall),
              ),
              topAlignAffixes: true,
              // The child handles its own taps. An empty callback keeps the field
              // looking enabled, since a null onTap renders it disabled.
              onTap: () {},
              child: Wrap(
                spacing: SBBSpacing.xSmall,
                runSpacing: SBBSpacing.xSmall,
                children: [
                  for (final tag in const {'Bern': '12', 'Zürich': '8', 'Basel': '5'}.entries)
                    SBBChip(
                      labelText: tag.key,
                      trailingText: tag.value,
                      selected: _selectedTags.contains(tag.key),
                      onChanged: (selected) => setState(() {
                        selected ? _selectedTags.add(tag.key) : _selectedTags.remove(tag.key);
                      }),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// An arbitrary widget that a single [String] would not represent well.
class _Route extends StatelessWidget {
  const _Route({required this.from, required this.to});

  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: SBBSpacing.xxSmall,
      children: [
        Text(from),
        Icon(SBBIcons.arrow_right_small, size: 16.0),
        Text(to),
      ],
    );
  }
}
