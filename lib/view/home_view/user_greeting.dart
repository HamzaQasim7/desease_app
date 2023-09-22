import 'package:flutter/material.dart';
import 'package:test_app/resources/constants.dart';

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
