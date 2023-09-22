import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/resources/app_colors.dart';
import 'package:test_app/resources/component/search_text_field.dart';
import 'package:test_app/resources/constants.dart';
import 'package:test_app/view/home_view/category_container.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allCategory = [
    {'name': 'Allergy & Immunology', 'image': 'assets/antibody.png'},
    {'name': 'Baristic', 'image': 'assets/stomach.png'},
    {'name': 'Cardiology', 'image': 'assets/heart.png'},
    {'name': 'Dermatology', 'image': 'assets/facial.png'},
    {'name': 'Normal Medicine', 'image': 'assets/drugs.png'},
    {'name': 'General Care', 'image': 'assets/stethoscope.png'},
    {'name': 'Diabetes', 'image': 'assets/diabetes.png'},
    {'name': 'Hair', 'image': 'assets/haircare.png'},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundCategory = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundCategory = _allCategory;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allCategory;
    } else {
      results = _allCategory
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundCategory = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f5f7),
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
            top: 0,
            left: 10,
            right: 10,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: _foundCategory.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 50,
                        child: TextField(
                          // controller: filterSearchResults,
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
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 items per row
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: _foundCategory.length,
                            itemBuilder: (context, index) {

                              if (_foundCategory.isEmpty) {
                                return Container(
                                    child: const Text('No Results Found',
                                        style: TextStyle(fontSize: 18))
                                );
                              }

                              final category = _foundCategory[index];

                              return CategoryContainer(
                                title: category['name'],
                                imgUrl: category['image'],
                              );

                            }
                        ),
                      ),
                      const SizedBox(height: 170,)
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

  }
}

//   const Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//   ],
// ),
// SizedBox(height: 10,),
// const Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//   ],
// ),
// SizedBox(height: 10,),
// const Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//   ],
// ),
// SizedBox(height: 10,),
//  const Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
//   children: [
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//     Expanded(
//       child: CategoryContainer(
//           title: 'Cardiology', imgUrl: 'assets/heart.png'),
//     ),
//   ],
// ),

// class _HomePageState extends State<HomePage> {
//   // This holds a list of fiction users
//   // You can use data fetched from a database or a server as well
//   final List<Map<String, dynamic>> _allUsers = [
//     {'name': 'Allergy & Immunology', 'image': 'assets/antibody.png'},
//     {'name': 'Cardiology', 'image': 'assets/heart.png'},
//   ];
//
//   // This list holds the data for the list view
//   List<Map<String, dynamic>> _foundUsers = [];
//   @override
//   initState() {
//     // at the beginning, all users are shown
//     _foundUsers = _allUsers;
//     super.initState();
//   }
//
//   // This function is called whenever the text field changes
//   void _runFilter(String enteredKeyword) {
//     List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       results = _allUsers;
//     } else {
//       results = _allUsers
//           .where((user) =>
//           user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }
//
//     // Refresh the UI
//     setState(() {
//       _foundUsers = results;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               onChanged: (value) => _runFilter(value),
//               decoration: const InputDecoration(
//                   labelText: 'Search', suffixIcon: Icon(Icons.search)),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: _foundUsers.isNotEmpty ? ListView.builder(
//                 itemCount: _foundUsers.length,
//                 itemBuilder: (context, index) => Card(
//                   key: ValueKey(_foundUsers[index]["name"]),
//                   color: Colors.amberAccent,
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: ListTile(
//                     leading: Text(
//                       _foundUsers[index]["id"].toString(),
//                       style: const TextStyle(fontSize: 24),
//                     ),
//                     title: Text(_foundUsers[index]['name']),
//                     subtitle: Text(
//                         '${_foundUsers[index]["age"].toString()} years old'),
//                   ),
//                 ),
//               )
//                   : const Text(
//                 'No results found',
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }












// List<String> medicalTreatments = [
//   'Allergy & Immunology',
//   'Baristic',
//   'Cardiology',
//   'Internal Medicine',
//   'Dermatology',
//   'General',
//
//   // Add more treatment names here
// ];
//
// final TextEditingController _searchController = TextEditingController();
// List<String> filteredTreatments = [];
//
// @override
// void initState() {
//   super.initState();
//   filteredTreatments.addAll(medicalTreatments);
// }
//
// void _filterTreatments(String query) {
//   filteredTreatments.clear();
//   if (query.isNotEmpty) {
//     for (String treatment in medicalTreatments) {
//       if (treatment.toLowerCase().contains(query.toLowerCase())) {
//         filteredTreatments.add(treatment);
//       }
//     }
//   } else {
//     filteredTreatments.addAll(medicalTreatments);
//   }
//   setState(() {});
// }

// child: SingleChildScrollView(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [

// SizedBox(
// width: MediaQuery.of(context).size.width,
// child: Row(
// children: [
// for (var category in filteredCategories)
// Expanded(
// child: CategoryContainer(
// title: category['name'],
// imgUrl: category['image'],
// ),
// )
// ],
// ),
// ),

// Second row
// SizedBox(
//   width: MediaQuery.of(context).size.width,
//   child: Row(
//     children: [
//       for (var category in filteredCategories)
//         Expanded(
//           child: CategoryContainer(
//             title: category['name'],
//             imgUrl: category['image'],
//           ),
//         )
//     ],
//   ),
// ),

// SizedBox(
//   width: MediaQuery.sizeOf(context).width,
//   // height: MediaQuery.sizeOf(context).height*0.2,
//   child:   const Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//        Expanded(
//         child: CategoryContainer(
//           title: 'Allergy &\nImmunology',
//           imgUrl: 'assets/stomach.png',
//         ),
//       ),
//       SizedBox(width:8.0),
//       Expanded(
//         child: CategoryContainer(
//           title: 'Baristic ',
//           imgUrl: 'assets/stomach.png',
//         ),
//       ),
//       SizedBox(width:8.0),
//       Expanded(
//         child: CategoryContainer(
//           title: 'Cardiology',
//           imgUrl: 'assets/heart.png',
//         ),
//       ),
//     ],),
// ),
// const SizedBox(height:8.0),
// SizedBox(
//   width: MediaQuery.sizeOf(context).width,
//   // height: MediaQuery.sizeOf(context).height*0.3,
//
//   child: const Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Expanded(
//         child: CategoryContainer(
//           title: 'Cardiology',
//           imgUrl: 'assets/drugs.png',
//         ),
//       ),
//       SizedBox(width:8.0),
//       Expanded(
//         child: CategoryContainer(
//           title: 'Cardiology',
//           imgUrl: 'assets/drugs.png',
//         ),
//       ),
//       SizedBox(width:8.0),
//       Expanded(
//         child: CategoryContainer(
//           title: 'Cardiology',
//           imgUrl: 'assets/drugs.png',
//         ),
//       ),
//     ],),
// ),
//   // SizedBox(
//   width: MediaQuery.sizeOf(context).width,
//   height: MediaQuery.sizeOf(context).height*0.3,
//   child: Expanded(
//     child: GridView.count(
//       crossAxisCount: 3, // Number of columns in the grid
//       padding: const EdgeInsets.all(8.0),
//       children: const [
//         CategoryContainer(
//           title: 'Allergy &\nImmunology',
//           imgUrl: 'assets/antibody.png',
//         ),
//         CategoryContainer(
//           title: 'Baristic',
//           imgUrl: 'assets/stomach.png',
//         ),
//         CategoryContainer(
//           title: 'Cardiology',
//           imgUrl: 'assets/drugs.png',
//         ),
//         CategoryContainer(
//           title: 'Cardiology',
//           imgUrl: 'assets/heart.png',
//         ),
//         CategoryContainer(
//           title: 'Cardiology',
//           imgUrl: 'assets/drugs.png',
//         ),
//         CategoryContainer(
//           title: 'Cardiology',
//           imgUrl: 'assets/drugs.png',
//         ),
//       ],
//     ),
//   ),
// ),
// const SizedBox(height: 170,)
//
// ],),
// )
