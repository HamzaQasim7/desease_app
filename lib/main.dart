import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/utilities/routes/route_name.dart';
import 'package:test_app/utilities/routes/routes.dart';
import 'package:test_app/view/bottom_nav_bar.dart';
import 'package:test_app/view_model/slider_view_model.dart';
import 'package:test_app/view_model/sub_user_view_model.dart';
import 'package:test_app/view_model/user_profile_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
          ChangeNotifierProvider(create: (_) => SliderItemViewModel()),
          ChangeNotifierProvider(create: (_) => SubUserViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
          home: const NavigationBarView(),
          // initialRoute: RoutesName.bottomNav,
          // onGenerateRoute: Routes.generateRoute,
        ));
  }
}
