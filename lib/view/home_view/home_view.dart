import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/resources/component/search_text_field.dart';
import 'package:test_app/resources/constants.dart';
import 'package:test_app/view/all_category.dart';
import 'package:test_app/view/home_view/category_container.dart';
import 'package:test_app/view/home_view/feature_carousel.dart';
import 'package:test_app/view/home_view/user_greeting.dart';
import 'package:test_app/view/home_view/user_profile_builder.dart';
import 'package:test_app/view/home_view/users.dart';
import 'package:test_app/view_model/category_view_model.dart';
import 'package:test_app/view_model/user_profile_view_model.dart';

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
                  width: 100,
                  height: 100,
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
          Positioned(
              top: 70,
              left: 10,
              right: 10,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer<UserProfileViewModel>(
                      builder: (context, userProfileProvider, child) {
                        if (!userProfileProvider.isLoading &&
                            userProfileProvider.userProfile == null) {
                          userProfileProvider.fetchUserProfile();
                        }
                        if (userProfileProvider.isLoading) {
                          // Display a loading indicator while data is being fetched
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          );
                        } else if (userProfileProvider.userProfile == null) {
                          return Text(
                            'User!',
                            style: kH1Text,
                          );
                        } else if (userProfileProvider.userProfile != null) {
                          return UserGreetings(
                              user: userProfileProvider.userProfile!.user.name
                                  .toString());
                        } else {
                          return Container();
                        }
                      },
                    ),
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
                    const SizedBox(height: 10),
                    Consumer<CategoryViewModel>(
                      builder: (context, categoryProviderModel, child) {
                        if (!categoryProviderModel.isLoading &&
                            categoryProviderModel.categoryItems == null) {
                          categoryProviderModel.fetchCategoryItems();
                        }
                        return categoryProviderModel.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 1.5,
                                ),
                              )
                            : categoryProviderModel.categoryItems == null
                                ? const Center(
                                    child: Text('No Results Found'),
                                  )
                                : SizedBox(
                          width: width,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, // 3 items per row
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 10.0,
                                    ),
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      // Ensure that the index is within the category items list length
                                      if (index <
                                          categoryProviderModel
                                              .categoryItems!.length) {
                                        final item = categoryProviderModel
                                            .categoryItems![index];
                                        return CategoryContainer(
                                          title: item.title.toString(),
                                          imgUrl: item.image.toString(),
                                        );
                                      } else {
                                        return const SizedBox(); // Placeholder for empty cells
                                      }
                                    },
                                  ),
                                );
                      },
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
