import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/bindings/general_bindings.dart';
import 'package:nutriscan/features/admin/screens/admin_dashboard.dart';

import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: AdminDashboard(),
    );
  }
}
