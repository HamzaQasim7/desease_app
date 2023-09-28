import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/resources/constants.dart';
import 'package:test_app/view_model/category_view_model.dart';

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
        borderRadius: BorderRadius.circular(8.0),
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
              image: NetworkImage(imgUrl),
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


class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return SizedBox(
      width: width,
      height: height * .35,
      child: Consumer<CategoryViewModel>(
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
              : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
                  categoryProviderModel.categoryItems!.length) {
                final item =
                categoryProviderModel.categoryItems![index];
                return CategoryContainer(
                  title: item.title.toString(),
                  imgUrl: item.image.toString(),
                );
              } else {
                return const SizedBox(); // Placeholder for empty cells
              }
            },
          );
        },
      ),
    );
  }
}

