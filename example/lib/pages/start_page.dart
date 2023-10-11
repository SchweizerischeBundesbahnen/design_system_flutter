import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import 'launchpad_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SBBHeader(title: 'Design System Mobile'),
      backgroundColor: Color.fromRGBO(241, 241, 241, 1),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://digital.sbb.ch/media/pages/home/b9ba24085b-1570784080/mobile.jpg'),
            SizedBox(height: sbbDefaultSpacing),
            Text('SBB Mobile Design System',
                style: SBBTextStyles.extraLargeLight),
            SizedBox(height: sbbDefaultSpacing),
            Text(
                'Design System für native, mobile Anwendungen auf Mobile und Tablets.',
                style: SBBTextStyles.largeLight),
            SizedBox(height: sbbDefaultSpacing * 3),
            SBBPrimaryButton(
                label: 'Entdecken',
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LaunchpadPage(),
                  ));
                })
          ],
        ),
      )),
    );
  }
}
