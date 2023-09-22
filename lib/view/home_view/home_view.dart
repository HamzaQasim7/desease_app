import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/resources/component/search_text_field.dart';
import 'package:test_app/resources/constants.dart';
import 'package:test_app/view/all_category.dart';
import 'package:test_app/view/home_view/category_container.dart';
import 'package:test_app/view/home_view/feature_carousel.dart';
import 'package:test_app/view/home_view/user_greeting.dart';
import 'package:test_app/view/home_view/users.dart';
import 'package:test_app/view_model/user_profile_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
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

          Consumer<UserProfileViewModel>(
            builder: (context, userProfileProvider, child) {
              if (!userProfileProvider.isLoading &&
                  userProfileProvider.userProfile == null) {
                userProfileProvider.fetchUserProfile();
              }

              if (userProfileProvider.userProfile == null) {
                return const CircularProgressIndicator(strokeWidth: 1,);
              }

              final profileImgUrl = userProfileProvider.userProfile!.profileImg;

              return CircleAvatar(
                backgroundImage: NetworkImage(profileImgUrl),
              );
            },
          ),
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
                width: 220,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: 70,
              left: 10,
              right: 10,
              child: SizedBox(
                height: MediaQuery
                    .sizeOf(context)
                    .height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            return Text('User!', style: kH1Text,);
                          }
                          else if (userProfileProvider.userProfile != null) {
                            return UserGreetings(
                                user: userProfileProvider.userProfile!.user.name
                                    .toString());
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const SizedBox(height: 8,),
                      const FeatureCarousel(),
                      const SizedBox(height: 8,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('My Users', style: kH1Text,),
                          const SizedBox(height: 5,),
                          const User(),
                          const SizedBox(height: 20,),
                        ],),
                      SearchTextField(
                          ontap: () {
                            // Navigator.pushNamed(context, RoutesName.categoryView);
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => const CategoryView()));
                          },
                          string: 'Search'),
                      SizedBox(
                        width: MediaQuery
                            .sizeOf(context)
                            .width * 0.95,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Category', style: kH1Text,),
                            TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const CategoryView()));
                            }, child: Text('See all', style: kH3Text,))
                          ],),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .sizeOf(context)
                            .width,
                        height: MediaQuery
                            .sizeOf(context)
                            .height * 0.2,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CategoryContainer(
                                title: 'Allergy &\nImmunology',
                                imgUrl: 'assets/antibody.png',
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: CategoryContainer(
                                title: 'Baristic',
                                imgUrl: 'assets/stomach.png',
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: CategoryContainer(
                                title: 'Cardiology',
                                imgUrl: 'assets/heart.png',
                              ),
                            ),
                          ],),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery
                            .sizeOf(context)
                            .width,
                        height: MediaQuery
                            .sizeOf(context)
                            .height * 0.2,

                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CategoryContainer(
                                title: 'Dermatology',
                                imgUrl: 'assets/facial.png',
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: CategoryContainer(
                                title: 'General Care',
                                imgUrl: 'assets/stethoscope.png',
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: CategoryContainer(
                                title: 'Normal Medicine',
                                imgUrl: 'assets/drugs.png',
                              ),
                            ),
                          ],),
                      ),
                      const SizedBox(height: 130,)

                    ],),
                ),
              )
          ),

        ],
      ),
    );
  }
}


