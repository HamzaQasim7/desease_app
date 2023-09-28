import 'package:flutter/material.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/resources/component/search_text_field.dart';
import 'package:test_app/resources/constants.dart';
import 'package:test_app/view/all_category.dart';
import 'package:test_app/view/home_view/category_container.dart';
import 'package:test_app/view/home_view/feature_carousel.dart';
import 'package:test_app/view/home_view/user_greeting.dart';
import 'package:test_app/view/home_view/user_profile_builder.dart';
import 'package:test_app/view/home_view/users.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      backgroundColor: const Color(0xfff1f5f7),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.headphones,
              color: AppColors.primaryColor,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: AppColors.primaryColor,
              )),
          const UserProfileBuilder(),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: Stack(
        children: [
          const Positioned(
              top: 0,
              left: 0,
              child: Opacity(
                opacity: 0.5,
                child: Image(
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/bottomRight.png'),
                ),
              )),
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/topLeft.png', // Use a placeholder image
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 10.0, ),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const UserName(),
                    const SizedBox(height: 8),
                    const FeatureCarousel(),
                    const SizedBox(height: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My Users', style: kH1Text),
                        const SizedBox(height: 5),
                        const User(),
                        const SizedBox(height: 20),
                      ],
                    ),
                    SearchTextField(
                        ontap: () {
                          // Navigator.pushNamed(context, RoutesName.categoryView);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CategoryView()));
                        },
                        string: 'Search'),
                    SizedBox(height: height*.02,),
                    SizedBox(
                      width: width * 0.95,
                      height: height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category',
                            style: kH1Text,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CategoryView()));
                              },
                              child: Text(
                                'See all',
                                style: kH3Text,
                              ))
                        ],
                      ),
                    ),
                     SizedBox(height: height*.05,),
                     const CategoryList()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


