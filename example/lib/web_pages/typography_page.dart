import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: SingleChildScrollView(
          primary: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SBBWebText.headerOne('Typographie', color: SBBColors.red),
                SBBWebText.headerTwo('Stile'),
                SBBWebText.headerThree('Header H1'),
                SBBWebText.headerOne(_sampleTextShort),
                SBBWebText.headerThree('Header H2'),
                SBBWebText.headerTwo(_sampleTextShort),
                SBBWebText.headerThree('Header H3'),
                SBBWebText.headerThree(_sampleTextShort),
                SBBWebText.headerThree('Header H4'),
                SBBWebText.headerFour(_sampleTextShort),
                SBBWebText.headerThree('Fliesstext'),
                SBBWebText.running(_sampleTextLong),
                SBBWebText.headerThree('Fliesstext selektierbar'),
                SBBWebText.running(_sampleTextLong, selectable: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const String _sampleTextShort = 'The quick brown fox jumps over the lazy dog.';
const String _sampleTextLong =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis non sem orci. Etiam vel cursus eros, viverra ultrices libero. Quisque convallis, dolor ac sagittis rutrum, erat elit tincidunt lacus, id ullamcorper ex magna interdum ex. Suspendisse interdum lectus sed lectus sodales, vel ullamcorper ex egestas. Morbi ac maximus mi. Integer ligula augue, iaculis non enim eu, congue iaculis ex. Fusce nec odio in mauris varius maximus quis quis sem. Etiam et lorem sed lorem porttitor tempus eget eu lectus. Duis dapibus vitae felis efficitur suscipit. Donec molestie, turpis a posuere accumsan, lorem lectus elementum ante, ac blandit magna augue dignissim nisl. Nulla aliquet mi ac augue facilisis, sit amet malesuada ipsum porta. Sed vel malesuada mauris, vel ornare est.';
