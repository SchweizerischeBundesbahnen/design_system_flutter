import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'native_app.dart';
import 'web_app.dart';

void main() => runApp(kIsWeb ? WebApp() : MyApp());
