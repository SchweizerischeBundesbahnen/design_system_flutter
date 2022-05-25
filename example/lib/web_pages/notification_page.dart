import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey keyTestJumpMark = GlobalKey();
  final GlobalKey keyTitle = GlobalKey();

  bool expandConfirmation = true;
  bool expandHint = true;
  bool expandWarning = true;
  bool expandError = true;
  bool expandErrorWithJumpMark = true;

  void expandAll() {
    setState(() {
      expandConfirmation = true;
      expandHint = true;
      expandWarning = true;
      expandError = true;
      expandErrorWithJumpMark = true;
    });
  }

  void collapseAll() {
    setState(() {
      expandConfirmation = false;
      expandHint = false;
      expandWarning = false;
      expandError = false;
      expandErrorWithJumpMark = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SBBWebText.headerOne('Notification',
                    key: keyTitle, color: SBBColors.red),
                Row(
                  children: [
                    SBBGhostButton(label: 'Alle öffnen', onPressed: expandAll),
                    SizedBox(width: 8),
                    SBBGhostButton(
                        label: 'Alle schliessen', onPressed: collapseAll)
                  ],
                ),
                SBBWebText.headerTwo('Ausprägungen'),
                SBBWebText.headerThree('Bestätigung'),
                Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SBBNotificaitonWeb.confirmation('Meldungstext',
                        expand: expandConfirmation)),
                SBBWebText.headerThree('Hinweis'),
                Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SBBNotificaitonWeb.hint('Meldungstext',
                        expand: expandHint)),
                SBBWebText.headerThree('Warnung'),
                Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SBBNotificaitonWeb.warning('Meldungstext',
                        expand: expandWarning)),
                SBBWebText.headerThree('Fehler'),
                Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SBBNotificaitonWeb.error('Meldungstext',
                        expand: expandError)),
                SBBWebText.headerThree('Fehler mit Sprungmarke'),
                Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SBBNotificaitonWeb.error(
                      'Korrigieren Sie bitte folgende Eingaben:',
                      expand: expandErrorWithJumpMark,
                      jumpMarks: [
                        SBBJumpMark(
                            text: 'Test Sprungmarke',
                            keyToScrollTo: keyTestJumpMark),
                        SBBJumpMark(text: 'Title', keyToScrollTo: keyTitle),
                      ],
                    )),
                SizedBox(height: 800),
                Text(
                  'Test Sprungmarke',
                  key: keyTestJumpMark,
                  style: SBBWebTextStyles.medium,
                ),
                SizedBox(height: 800),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
