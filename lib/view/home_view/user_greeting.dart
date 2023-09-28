import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/resources/constants.dart';
import 'package:test_app/view_model/user_profile_view_model.dart';

class UserGreetings extends StatelessWidget {
  final String? user;

  const UserGreetings({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              '👋',
            ),
            Text(
              'Good Morning,',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.black38),
            ),
          ],
        ),
        Text(
          '$user!',
          style: kH1Text,
        )
      ],
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<UserProfileViewModel>(
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
                user: userProfileProvider.userProfile!.user.name.toString());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
