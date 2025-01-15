import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import 'launchpad_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SBBHeader(title: 'Design System Mobile'),
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://digital.sbb.ch/media/pages/home/b9ba24085b-1570784080/mobile.jpg'),
            const SizedBox(height: sbbDefaultSpacing),
            const Text('SBB Mobile Design System', style: SBBTextStyles.extraLargeLight),
            const SizedBox(height: sbbDefaultSpacing),
            const Text('Design System für native, mobile Anwendungen auf Mobile und Tablets.',
                style: SBBTextStyles.largeLight),
            const SizedBox(height: sbbDefaultSpacing * 3),
            SBBPrimaryButton(
                label: 'Entdecken',
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LaunchpadPage(),
                  ));
                })
          ],
        ),
      )),
    );
  }
}
