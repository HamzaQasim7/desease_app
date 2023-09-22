import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/view_model/sub_user_view_model.dart';
import 'package:test_app/view_model/user_profile_view_model.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.orange,
      width: MediaQuery
          .sizeOf(context)
          .width,
      height: 50,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              child: Consumer<UserProfileViewModel>(
                builder: (context, userProfileProvider, child) {
                  if (!userProfileProvider.isLoading &&
                      userProfileProvider.userProfile == null) {
                    userProfileProvider.fetchUserProfile();
                  }

                  if (userProfileProvider.userProfile == null) {
                    return const CircularProgressIndicator(
                      strokeWidth: 1,
                    );
                  }

                  final profileImgUrl =
                      userProfileProvider.userProfile!.profileImg;

                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.whiteColor, // Set the border color
                        width: 2, // Set the border width
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profileImgUrl),
                    ),
                  );
                },
              )),

          Positioned(
            top: 0,
            left: 30,
            child:  Consumer<SubUserViewModel>(
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
                }
                else if (subUserViewModel.subUsers != null) {
                  return Row(
                    children: subUserViewModel.subUsers!
                        .take(3) // Limit to the first three subusers
                        .map((subUser) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.whiteColor,
                            width: 2, // Set the border width
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              subUser.profileImg.toString()),
                        ),
                      );
                    }).toList(),
                  );
                } else {
// Handle the case when no data is available
                  return Container();
                }
              },
            ),
          ),
          Positioned(
              top: 0,
              left: 150,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.whiteColor, // Set the border color
                    width: 1, // Set the border width
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










//
// Consumer<SubUserViewModel>(
// builder: (context, subUserViewModel, child) {
// if (!subUserViewModel.isLoading &&
// subUserViewModel.subUsers == null) {
// subUserViewModel.fetchSubUsers();
// }
//
// if (subUserViewModel.isLoading) {
// return const Center(
// child: CircularProgressIndicator(
// strokeWidth: 1,
// ),
// );
// } else if (subUserViewModel.subUsers == null) {
// return const Center(
// child: CircularProgressIndicator(
// strokeWidth: 1,
// ),
// );
// } else if (subUserViewModel.subUsers != null) {
// return SizedBox(
// width: 200,
// height: 50,
// child: Stack(
// children: [
// if (subUserViewModel.subUsers!.isNotEmpty)
// Positioned(
// top: 0,
// left: 60,
// child: CircleAvatar(
// backgroundImage: NetworkImage(
// subUserViewModel.subUsers![0].profileImg.toString()),
// ),
// ),
// if (subUserViewModel.subUsers!.length > 1)
// Positioned(
// top: 0, // Adjust the top position as needed
// left: 60,
// child: CircleAvatar(
// backgroundImage: NetworkImage(
// subUserViewModel.subUsers![1].profileImg.toString()),
// ),
// ),
// if (subUserViewModel.subUsers!.length > 2)
// Positioned(
// top: 0, // Adjust the top position as needed
// left: 60,
// child: CircleAvatar(
// backgroundImage: NetworkImage(
// subUserViewModel.subUsers![2].profileImg.toString()),
// ),
// ),
// ],
// ),
// );
// } else {
// // Handle the case when no data is available
// return Container(child: Text('No'),);
// }
// },
// )