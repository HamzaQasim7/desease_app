
import 'package:flutter/material.dart';
import 'package:test_app/utilities/routes/route_name.dart';
import 'package:test_app/view/all_category.dart';
import 'package:test_app/view/bottom_nav_bar.dart';
import 'package:test_app/view/home_view/home_view.dart';


class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.bottomNav:
        return MaterialPageRoute(
            builder: (_) => const NavigationBarView()
        );
      case RoutesName.home:
        return MaterialPageRoute(builder: (context)=>const HomeView());
      case RoutesName.categoryView:
        return MaterialPageRoute(builder: (context)=>const CategoryView());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(body: Center(child: Text('No Routes Defined')),);
        });

    }
  }
}