import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
                primary: false,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SBBWebText.headerOne(
                          'Status',
                          color: SBBColors.red,
                        ),
                        SBBWebText.headerThree('- Icon'),
                        SBBStatus.valid(),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.warning(),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.invalid(),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.inProgress(),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.inactive(),
                        SizedBox(
                          height: 20,
                        ),
                        SBBWebText.headerThree('- Text'),
                        SBBStatus.valid(
                          showIcon: false,
                          text: 'Success',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.warning(
                          showIcon: false,
                          text: 'Warning',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.invalid(
                          showIcon: false,
                          text: 'Failure',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.inProgress(
                          showIcon: false,
                          text: 'In Progress',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.inactive(
                          showIcon: false,
                          text: 'Offline',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //SBBStatus(),
                        SizedBox(
                          height: 20,
                        ),
                        SBBWebText.headerThree('- Extended'),
                        SBBStatus.valid(
                          text: 'Everything is valid',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.warning(
                          text: 'There is a potential problem',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.invalid(
                          text: 'Somethign needs to be corrected',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.inProgress(
                          text: 'Process is in progress',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SBBStatus.inactive(
                          text: 'Application is offline',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )))));
  }
}
