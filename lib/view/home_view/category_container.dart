import 'package:flutter/material.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/resources/constants.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({Key? key, required this.title, required this.imgUrl})
      : super(key: key);

  final String title;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Image(
              width: 40,
              height: 40,
              image: AssetImage(imgUrl),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: kH2Text,
            ),
          ),
        ],
      ),
    );
  }
}

// class CategoryView extends StatelessWidget {
//   const CategoryView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       // Specify the number of items in the grid
//       itemCount: 6,
//       // Set the grid delegate to control the layout
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3, // Number of columns in the grid
//       ),
//       // Build each grid item using a builder function
//       itemBuilder: (BuildContext context, int index) {
//         // Return a container with a colored box
//         return Container(
//           width: MediaQuery.of(context).size.width * 0.4,
//           height: MediaQuery.of(context).size.height * 0.2,
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image(
//                 width: 50,
//                 height: 50,
//                 image: AssetImage(imgUrl),
//               ),
//               Text(
//                 title,
//                 style: kH2Text,
//               ),
//             ],
//           ),
//         );(
//           color: Colors.blueAccent,
//           margin: EdgeInsets.all(10.0),
//           child: Center(
//             child: Text(
//               'Item $index',
//               style: TextStyle(color: Colors.white, fontSize: 18.0),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
