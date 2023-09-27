import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/resources/constants.dart';
import 'package:test_app/view/home_view/user_profile_builder.dart';
import 'package:test_app/view_model/sub_user_view_model.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      child: Stack(
        children: [
          const Positioned(top: 0, child: UserProfileBuilder()),
          Positioned(
            top: 0,
            left: 25,
            child: Consumer<SubUserViewModel>(
              builder: (context, subUserViewModel, child) {
                if (!subUserViewModel.isLoading &&
                    subUserViewModel.subUsers == null) {
                  subUserViewModel.fetchSubUsers();
                }
                if (subUserViewModel.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  );
                } else if (subUserViewModel.subUsers == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  );
                } else if (subUserViewModel.subUsers != null) {
                  return SizedBox(
                    width: 200,
                    height: 50,
                    child: Stack(
                      children: subUserViewModel.subUsers!
                          .take(3) // Limit to the first three subusers
                          .map((subUser) {
                        return Positioned(
                          left: subUserViewModel.subUsers!.indexOf(subUser) * 25.0, // Adjust the positioning as needed
                          child: Container(
                            decoration: kProfileOutline,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(subUser.profileImg.toString()),
                            ),
                          ),
                          
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Positioned(
              top: 0,
              left: 100,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.whiteColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                      )),
                ),
              )),
        ],
      ),
    );
  }
}



// Out of this app
class Responsive  extends StatelessWidget{

  const Responsive({super.key, required this.smallScreen, required this.tabletScreen, required this.desktopScreen});

  final Widget? smallScreen;
  final Widget? tabletScreen;
  final Widget desktopScreen;

  bool isSmallScreen(BuildContext context){
    return MediaQuery.sizeOf(context).width < 786;
  }

  bool isTabletScreen(BuildContext context){
    return MediaQuery.sizeOf(context).width <= 992  && MediaQuery.of(context).size.width <=1200;
  }

  bool isDesktopScreen(BuildContext context){
    return MediaQuery.sizeOf(context).width > 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints){
      if (constraints.maxWidth > 1200 ) {
        return desktopScreen;
      } else if(constraints.maxWidth <= 786 && constraints.maxWidth <=992){
        return smallScreen ?? tabletScreen!;
      } else {
        return smallScreen?? desktopScreen;
      }
      });

    }}