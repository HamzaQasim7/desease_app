

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/view_model/user_profile_view_model.dart';

class UserProfileBuilder extends StatelessWidget {
  const UserProfileBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileViewModel>(
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

        final profileImgUrl = userProfileProvider.userProfile!.profileImg;

        return CircleAvatar(
          backgroundImage: NetworkImage(profileImgUrl),
        );
      },
    );
  }
}