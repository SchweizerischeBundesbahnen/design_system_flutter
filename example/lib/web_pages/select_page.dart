import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SBBWebText.headerOne('Select (Dropdown)', color: SBBColors.red),
              SBBWebText.headerTwo('Ausprägungen'),
              SBBWebText.headerThree('- Default'),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SBBSelect<String>(
                    value: selectedValue,
                    items: List.of([
                      SelectMenuItem(value: 'value1', label: 'label1'),
                      SelectMenuItem(value: 'value2', label: 'label2'),
                      SelectMenuItem(value: 'value3', label: 'label3'),
                      SelectMenuItem(value: 'value4', label: 'label4'),
                    ]),
                    label: 'Label',
                    hint: 'Please choose...',
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    }),
              ),
              SBBWebText.headerThree('- Disabled'),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SBBSelect<String>(
                    value: selectedValue,
                    items: List.of([
                      SelectMenuItem(value: 'value1', label: 'label1'),
                      SelectMenuItem(value: 'value2', label: 'label2'),
                      SelectMenuItem(value: 'value3', label: 'label3'),
                      SelectMenuItem(value: 'value4', label: 'label4'),
                    ]),
                    label: 'Label',
                    hint: 'Please choose...',
                    onChanged: null),
              ),
              SBBWebText.headerThree('- Error'),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SBBSelect<String>(
                  value: selectedValue,
                  items: List.of([
                    SelectMenuItem(value: 'value1', label: 'label1'),
                    SelectMenuItem(value: 'value2', label: 'label2'),
                    SelectMenuItem(value: 'value3', label: 'label3'),
                    SelectMenuItem(value: 'value4', label: 'label4'),
                  ]),
                  label: 'Label',
                  hint: 'Please choose...',
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  errorText: 'Some error occured',
                ),
              ),
              SBBWebText.headerThree('- DropDownFormField'),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SBBDropdownButtonFormField<String>(
                  value: selectedValue,
                  items: List.of([
                    SBBDropdownMenuItem(
                      value: 'value1',
                      child: Text('label1'),
                    ),
                    SBBDropdownMenuItem(
                      value: 'value2',
                      child: Text('label2'),
                    ),
                    SBBDropdownMenuItem(
                      value: 'value3',
                      child: Text('label3'),
                    ),
                    SBBDropdownMenuItem(
                      value: 'value4',
                      child: Text('label4'),
                    ),
                  ]),
                  label: 'Label',
                  hint: Text('Please choose...'),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SBBDropdownButton<String>(
                  value: selectedValue,
                  items: List.of([
                    SBBDropdownMenuItem(
                      value: 'value1',
                      child: Text('label1'),
                    ),
                    SBBDropdownMenuItem(
                      value: 'value2',
                      child: Text('label2'),
                    ),
                    SBBDropdownMenuItem(
                      value: 'value3',
                      child: Text('label3'),
                    ),
                    SBBDropdownMenuItem(
                      value: 'value4',
                      child: Text('label4'),
                    ),
                  ]),
                  label: 'Label',
                  hint: Text('Please choose...'),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
