import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_app/model/category_model.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/resources/constants.dart';
import 'package:test_app/view/home_view/category_container.dart';
import 'package:test_app/view_model/category_view_model.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  AppColors.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Category',
          style: kH1Text,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryColor,
          ),
        ),
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
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: Image(
                width: 220,
                height: 220,
                fit: BoxFit.cover,
                image: AssetImage('assets/topLeft.png'),
              ),
            ),
          ),
          Positioned(
            top: 75,
            left: 10,
            right: 10,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    child: Consumer<CategoryViewModel>(
                      builder: (context, categoryProvider, child) {
                        if (!categoryProvider.isLoading &&
                            categoryProvider.categoryItems == null) {
                          categoryProvider.fetchCategoryItems();
                        }
                        return categoryProvider.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(color: AppColors.primaryColor,strokeWidth: 1.5,),
                              )
                            : categoryProvider.categoryItems == null
                                ? const Center(
                                    child: Text('No Results Found'),
                                  )
                                : CategoryGridView(
                                    categoryProvider.categoryItems!,
                                  );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryGridView extends StatefulWidget {
  final List<CategoryModel> categoryItems;

  const CategoryGridView(this.categoryItems, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryGridViewState createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  String _searchText = '';
  late List<CategoryModel> _filteredCategoryItems;

  @override
  void initState() {
    super.initState();
    _filteredCategoryItems = widget.categoryItems;
  }

  void _runFilter(String enteredKeyword) {
    List<CategoryModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.categoryItems;
    } else {
      results = widget.categoryItems
          .where((category) => category.title
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _searchText = enteredKeyword;
      _filteredCategoryItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: TextField(
            onChanged: _runFilter,
            decoration: InputDecoration(
              iconColor: Colors.grey,
              hintText: 'Search',
              hintStyle: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              filled: true,
              fillColor: AppColors.whiteColor,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 items per row
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: _filteredCategoryItems.length,
            itemBuilder: (context, index) {
              final item = _filteredCategoryItems[index];
              return CategoryContainer(
                title: item.title,
                imgUrl: item.image.toString(),
              );
            },
          ),
        ),
        const SizedBox(height: 70,)
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:test_app/resources/app_colors.dart';
// import 'package:test_app/resources/component/search_text_field.dart';
// import 'package:test_app/resources/constants.dart';
// import 'package:test_app/view/home_view/category_container.dart';
// import 'package:test_app/view_model/category_view_model.dart';
//
// class CategoryView extends StatefulWidget {
//   const CategoryView({super.key});
//
//   @override
//   State<CategoryView> createState() => _CategoryViewState();
// }
//
// class _CategoryViewState extends State<CategoryView> {
//   // This holds a list of fiction users
//   // You can use data fetched from a database or a server as well
//   final List<Map<String, dynamic>> _allCategory = [
//     // {'name': 'Allergy & Immunology', 'image': 'assets/antibody.png'},
//     // {'name': 'Baristic', 'image': 'assets/stomach.png'},
//     // {'name': 'Cardiology', 'image': 'assets/heart.png'},
//     // {'name': 'Dermatology', 'image': 'assets/facial.png'},
//     // {'name': 'Normal Medicine', 'image': 'assets/drugs.png'},
//     // {'name': 'General Care', 'image': 'assets/stethoscope.png'},
//     // {'name': 'Diabetes', 'image': 'assets/diabetes.png'},
//     // {'name': 'Hair', 'image': 'assets/haircare.png'},
//   ];
//
//   // This list holds the data for the list view
//   List<Map<String, dynamic>> _foundCategory = [];
//   @override
//   initState() {
//     // at the beginning, all users are shown
//     _foundCategory = _allCategory;
//     super.initState();
//   }
//
//   // This function is called whenever the text field changes
//   void _runFilter(String enteredKeyword) {
//     List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       results = _allCategory;
//     } else {
//       results = _allCategory
//           .where((user) =>
//           user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }
//
//     // Refresh the UI
//     setState(() {
//       _foundCategory = results;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff1f5f7),
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Category',
//           style: kH1Text,
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//             color: AppColors.primaryColor,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           const Positioned(
//             top: 0,
//             left: 0,
//             child: Opacity(
//               opacity: 0.5,
//               child: Image(
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//                 image: AssetImage('assets/bottomRight.png'),
//               ),
//             ),
//           ),
//           const Positioned(
//             bottom: 0,
//             right: 0,
//             child: Opacity(
//               opacity: 0.5,
//               child: Image(
//                 width: 220,
//                 height: 220,
//                 fit: BoxFit.cover,
//                 image: AssetImage('assets/topLeft.png'),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 10,
//             right: 10,
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: ListView.builder(
//                 itemCount: _foundCategory.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         height: 50,
//                         child: TextField(
//                           // controller: filterSearchResults,
//                           onChanged: _runFilter,
//                           decoration: InputDecoration(
//                             iconColor: Colors.grey,
//                             hintText: 'Search',
//                             hintStyle: GoogleFonts.montserrat(
//                               textStyle: const TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             filled: true,
//                             fillColor: AppColors.whiteColor,
//                             prefixIcon: const Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20.0),
//                       SizedBox(
//                         height: double.maxFinite,
//                         width: double.maxFinite,
//                         child: Consumer<CategoryViewModel>(builder: (context,categoryProvider,child){
//                           if (!categoryProvider.isLoading && categoryProvider.categoryItems == null) {
//                             categoryProvider.fetchCategoryItems();
//                           }
//                           return GridView.builder(
//                               itemCount: categoryProvider.categoryItems == null
//                                   ? 0
//                                   : categoryProvider.categoryItems!.length,
//                               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3, // 3 items per row
//                                 crossAxisSpacing: 5.0,
//                                 mainAxisSpacing: 10.0,
//                               ),
//                               // itemCount: _foundCategory.length,
//                               itemBuilder: (context, index) {
//                                 final item = categoryProvider.categoryItems![index];
//                                 if (_foundCategory.isEmpty) {
//                                   return const Text('No Results Found',
//                                       style: TextStyle(fontSize: 18));
//                                 }
//
//                                 final category = _foundCategory[index];
//
//                                 return CategoryContainer(
//                                   title: item.title,
//                                   imgUrl:item.image,
//                                 );
//
//                               }
//                           );
//                         })
//                       ),
//                       const SizedBox(height: 170,)
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//
//   }
// }
