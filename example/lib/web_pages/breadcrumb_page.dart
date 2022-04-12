import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class BreadcrumbPage extends StatelessWidget {
  const BreadcrumbPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Breadcrumb',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 25, color: SBBColors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Ausprägungen',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 20, color: SBBColors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  '- Standard',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              SBBBreadCrumb(
                onLeadingPressed: () {},
                breadCrumbItems: [
                  SBBBreadCrumbItem(
                    child: Text('Level 1'),
                    onPressed: () {},
                  ),
                  SBBBreadCrumbItem(
                    child: Text('Level 2'),
                    onPressed: () {},
                  ),
                  SBBBreadCrumbItem(
                    child: Row(children: [
                      Text('Level 3 with Icon'),
                      Icon(SBBIcons.cup_hot_medium)
                    ]),
                    onPressed: null,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  '- Wrapped',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'TODO',
                  style: SBBLeanTextStyles.headerTitle
                      .copyWith(fontSize: 18, color: SBBColors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
