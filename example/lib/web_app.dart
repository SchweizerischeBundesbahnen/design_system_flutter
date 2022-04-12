import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import 'pages/icons_page.dart';

class MyWebApp extends StatelessWidget {
  const MyWebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SBBTheme(
      builder: (context, theme, darkTheme) {
        return MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          home: Scaffold(
            appBar: SBBWebHeader(
              title: 'Example Web App',
              subtitle: 'Version 0.1',
              userMenu: SBBUserMenu(
                displayName: "Eisen Bahner",
                itemBuilder: (BuildContext context) => <SBBMenuEntry>[
                  SBBMenuItem.tile(
                    icon: SBBIcons.user_medium,
                    title: 'Account',
                  ),
                ],
                onLoginRequest: () {
                  print('Login!');
                },
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Buttons',
                        style: SBBLeanTextStyles.headerTitle
                            .copyWith(fontSize: 25),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: SBBPrimaryButtonNegative(
                            label: 'Alternative Primary Button',
                            onPressed: () {},
                          ),
                        ),
                        Flexible(
                          child: SBBPrimaryButton(
                            label: 'Primary Button',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Icons',
                        style: SBBLeanTextStyles.headerTitle
                            .copyWith(fontSize: 25),
                      ),
                    ),
                    Flexible(
                      child: GridView.builder(
                        physics: PageScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 36.0 + sbbDefaultSpacing),
                        itemCount: iconsMedium.length,
                        itemBuilder: (BuildContext context, index) {
                          final icon = iconsMedium[index];
                          return IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              icon['icon'] as IconData,
                              size: 36.0,
                            ),
                            onPressed: () {
                              SBBToast.of(context)
                                  .show(message: icon['name'] as String);
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Breadcrumb',
                        style: SBBLeanTextStyles.headerTitle
                            .copyWith(fontSize: 25),
                      ),
                    ),
                    Flexible(
                      child: SBBBreadCrumb(
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
                              Icon(SBBIcons.airplane_medium)
                            ]),
                            onPressed: null,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Loading Indicator',
                        style: SBBLeanTextStyles.headerTitle
                            .copyWith(fontSize: 25),
                      ),
                    ),
                    Flexible(
                      child: SBBLoadingIndicator(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
